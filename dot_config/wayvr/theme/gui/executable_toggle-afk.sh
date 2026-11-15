#!/usr/bin/env bash
CURRENT_FOCUS=$(kdotool getactivewindow)
VRC=$(kdotool search vrchat)
if [ -n "$VRC" ]; then
  kdotool windowactivate $VRC
  echo key end | dotool
  kdotool windowactivate $CURRENT_FOCUS
fi
