sudo wget -qO /usr/local/bin/yt-dlp https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp
sudo chmod a+rx /usr/local/bin/yt-dlp
yt-dlp --version

process_yt_video () {
	yt-dlp "https://www.youtube.com/watch?v=$1" -f 251 -o "./output/$1.webm"
	python predict.py "./output/$1.webm" "./output/$1.json"
	python convert_json_to_csv.py "./output/$1.json" "./output/$1.csv"
}

#https://www.youtube.com/watch?v=HKp68LX7fPA
#https://www.youtube.com/watch?v=PM60sowd3x4
#https://www.youtube.com/watch?v=Tm8z4Fs8XEs
#https://www.youtube.com/watch?v=xGIWq3271DY
#https://www.youtube.com/watch?v=IjM3ZO9QnZ8
#https://www.youtube.com/watch?v=tG8w4H6CP_Y
#https://www.youtube.com/watch?v=rQ7G8qIgMPg
#https://www.youtube.com/watch?v=HKp68LX7fPA
#https://www.youtube.com/watch?v=peqWQ0nkjC0
#https://www.youtube.com/watch?v=-HNYcyDahtg

process_yt_video "HKp68LX7fPA"
process_yt_video "PM60sowd3x4"
process_yt_video "Tm8z4Fs8XEs"
process_yt_video "xGIWq3271DY"
process_yt_video "IjM3ZO9QnZ8"
process_yt_video "tG8w4H6CP_Y"
process_yt_video "rQ7G8qIgMPg"
process_yt_video "HKp68LX7fPA"
process_yt_video "peqWQ0nkjC0"
process_yt_video "-HNYcyDahtg"
