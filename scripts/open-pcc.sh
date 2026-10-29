#!/usr/bin/env bash

# Path to Python Crash Course repo
PCC_DIR="$HOME/python-crash-course"

# The PDF file
PDF_FILE="$PCC_DIR/python_crash_course/python_crash.pdf"

# Find the latest modified python file
# We use find to get all .py files, stat to get modification time, sort numerically, and pick the top 1.
LATEST_FILE=$(find "$PCC_DIR" -type f -name "*.py" -exec stat -c '%Y %n' {} + | sort -nr | head -n 1 | awk '{print $2}')

if [ -z "$LATEST_FILE" ]; then
    echo "No python files found in $PCC_DIR."
    # If no python file, just open the directory
    LATEST_FILE="$PCC_DIR"
fi

# Elisp script to set up splits, open the files, and start vterm.
# We use emacsclient -c to create the graphical frame, so we don't need make-frame.
ELISP="(let ((py-buf (find-file-noselect \"$LATEST_FILE\"))
      (pdf-buf (find-file-noselect \"$PDF_FILE\")))
  (delete-other-windows)
  ;; Switch main window to the python file
  (switch-to-buffer py-buf)
  
  ;; Create a vertical split for the PDF on the right
  (let ((w-pdf (split-window-right)))
    (set-window-buffer w-pdf pdf-buf))
    
  ;; Create a horizontal split below for vterm
  (let ((w-vterm (split-window-below -15)))
    (select-window w-vterm)
    (vterm))
    
  ;; Finally, select the first window again to start editing
  (select-window (frame-first-window (selected-frame))))"

# Use -c to tell Emacs to create a new graphical frame
emacsclient -c -n -e "$ELISP"
