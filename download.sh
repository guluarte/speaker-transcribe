mkdir ./output/audios -p
mkdir ./output/csv -p
mkdir ./output/json -p

process_yt_video() {
    yt-dlp "$1" --sponsorblock-remove all -f ba -o "./output/audios/%(title)s-%(id)s.%(ext)s"  --restrict-filenames
}

process_yt_video "https://youtu.be/fCUkvL0mbxI"