@echo off
ffmpeg.exe -threads 4 -i %1 -ab 32 -ar 22050 -vcodec libx264 -b 500 -r 25 -s 480*300 -flags +loop -crf 24 -bt 256k -vol 200 -vf yadif %2
qt-faststart.exe %2 %3