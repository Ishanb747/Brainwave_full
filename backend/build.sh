#!/usr/bin/env bash
# exit on error
set -o errexit

# Install Python dependencies
pip install --upgrade pip
pip install -r requirements.txt
pip install gunicorn

# Install ffmpeg (Required for Whisper)
# Since we don't have sudo/apt on Render's native environment, 
# we download the static binary and add it to our path.
if [ ! -d "ffmpeg" ]; then
  echo "Downloading ffmpeg..."
  mkdir -p ffmpeg
  cd ffmpeg
  curl -L https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz | tar xJ --strip-components=1
  cd ..
fi

# Make sure ffmpeg is in the path for the current process
export PATH=$PATH:$(pwd)/ffmpeg
echo "ffmpeg installed at $(which ffmpeg)"
