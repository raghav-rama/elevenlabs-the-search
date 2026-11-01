#!/usr/bin/env python3
"""Diagnostic only: track stationary rail features and project a proposed train path.

Run with uv run --python 3.12 --with numpy --with opencv-python-headless
--with imageio-ffmpeg python SCRIPT SOURCE NEW_DIRECTORY.
Writes tracking data and annotated source frames only. No corrected video is
created. User stopped this experiment before compositing was implemented.
"""
import json
import sys
from pathlib import Path

import cv2
import numpy as np

source = Path(sys.argv[1]).resolve()
out = Path(sys.argv[2]).resolve()
out.mkdir(parents=True, exist_ok=True)
cap = cv2.VideoCapture(str(source))
fps = cap.get(cv2.CAP_PROP_FPS)
frames = []
while True:
    ok, im = cap.read()
    if not ok:
        break
    frames.append(im)
cap.release()
assert len(frames) == 121 and frames[0].shape == (480, 854, 3)
gray = [cv2.cvtColor(im, cv2.COLOR_BGR2GRAY) for im in frames]
# Fixed ground/trackside features, excluding the moving train, Riley and people.
mask = np.zeros((480, 854), np.uint8)
mask[:, :205] = 255
mask[:, 307:379] = 255
ref = cv2.goodFeaturesToTrack(gray[-1], 700, 0.005, 5, mask=mask)
current = ref.copy()
original = ref.copy()
H = {120: np.eye(3)}
metrics = []
for i in range(119, 59, -1):
    local_mask = np.zeros_like(mask)
    for left, right in [(-1000, 205), (307, 405)]:
        polygon = np.array([[left, -1800], [right, -1800], [right, 2500], [left, 2500]], np.float32).reshape(1,-1,2)
        polygon = cv2.perspectiveTransform(polygon, H[i+1])[0]
        cv2.fillPoly(local_mask, [np.round(polygon).astype(np.int32)], 255)
    current = cv2.goodFeaturesToTrack(gray[i+1], 700, 0.004, 4, mask=local_mask)
    tracked, status, error = cv2.calcOpticalFlowPyrLK(
        gray[i+1], gray[i], current, None, winSize=(31, 31), maxLevel=4,
        criteria=(cv2.TERM_CRITERIA_EPS | cv2.TERM_CRITERIA_COUNT, 40, 0.005))
    back, status_back, _ = cv2.calcOpticalFlowPyrLK(
        gray[i], gray[i+1], tracked, None, winSize=(31, 31), maxLevel=4)
    fb = np.linalg.norm(back.reshape(-1, 2)-current.reshape(-1, 2), axis=1)
    good = ((status[:, 0] == 1) & (status_back[:, 0] == 1) & (fb < 1.5)
            & (tracked[:, 0, 0] > 1) & (tracked[:, 0, 0] < 853)
            & (tracked[:, 0, 1] > 1) & (tracked[:, 0, 1] < 479))
    current = tracked[good]
    assert len(current) >= 12, (i, len(current))
    previous = back[good]
    matrix, inliers = cv2.findHomography(previous, current, cv2.RANSAC, 1.5)
    assert matrix is not None
    composed = matrix @ H[i+1]
    H[i] = composed / composed[2, 2]
    predicted = cv2.perspectiveTransform(previous, matrix)
    errors = np.linalg.norm(predicted-current, axis=2).ravel()
    metrics.append({'frame': i, 'tracked': len(current), 'inliers': int(inliers.sum()),
                    'median_error': float(np.median(errors[inliers[:, 0] == 1]))})

def transform(points, matrix):
    return cv2.perspectiveTransform(np.array(points, np.float32).reshape(1, -1, 2), matrix)[0]

# Nose advances toward decreasing world Y at 30 reference pixels per second.
# The camera matrix is independently determined from stationary world features.
for i in [60, 66, 72, 78, 84, 90, 96, 102, 108, 114, 120]:
    im = frames[i].copy()
    nose_y = 230 + 30 * ((120-i) / fps)
    corners = transform([[218, -1000], [298, -1000], [298, 1500], [218, 1500]], H[i])
    nose = transform([[258, nose_y]], H[i])[0]
    cv2.polylines(im, [np.round(corners).astype(np.int32)], True, (0, 255, 0), 1)
    cv2.circle(im, tuple(np.round(nose).astype(int)), 5, (0, 0, 255), -1)
    cv2.imwrite(str(out/f'track-{i:03d}.png'), im)
    print(i, 'nose', nose.tolist())
report = {'source': str(source), 'fps': fps, 'frames': len(frames),
          'world_reference_frame': 120, 'matrices': {str(k):v.tolist() for k,v in H.items()},
          'tracking': metrics, 'nose_world_y_at_end': 230, 'forward_world_speed': 30}
(out/'tracking.json').write_text(json.dumps(report, indent=2)+'\n')
print('tracking range', len(metrics), 'max median error', max(m['median_error'] for m in metrics))
