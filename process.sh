sudo wget -qO /usr/local/bin/yt-dlp https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp
sudo chmod a+rx /usr/local/bin/yt-dlp
yt-dlp --version

process_yt_video () {
	yt-dlp "https://www.youtube.com/watch?v=$1" -f 251 -o "./output/$1.webm"
	python predict.py "./output/$1.webm" "./output/$1.json"
	python convert_json_to_csv.py "./output/$1.json" "./output/$1.csv"
}

#https://www.youtube.com/watch?v=dQw4w9WgXcQ

process_yt_video "dQw4w9WgXcQ"