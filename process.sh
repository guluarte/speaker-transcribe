apt-get update
apt-get install ffmpeg libsndfile1 python3.8-venv -y

python3.8 -m venv venv
source ./venv/bin/activate
pip install -r requeriments.txt

if [[ ! -e "/data/pyannote" ]]
then
    wget -O - https://pyannote-speaker-diarization.s3.eu-west-2.amazonaws.com/data-2023-03-25-02.tar.gz | tar xz -C /
fi

if [[ ! -e "/data/whisper/medium.en.pt" ]]
then
    mkdir /data/whisper
    wget -P /data/whisper https://openaipublic.azureedge.net/main/whisper/models/d7440d1dc186f76616474e0ff0b3b6b879abc9d1a4926b7adfa41db2d497ab4f/medium.en.pt
fi

sudo wget -qO /usr/local/bin/yt-dlp https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp
sudo chmod a+rx /usr/local/bin/yt-dlp
yt-dlp --version

process_yt_video () {
	yt-dlp "https://www.youtube.com/watch?v=$1" -f 251 -o "./output/$1.webm"
    if [[ ! -e "./output/$1.json" ]]
    then
        python predict.py "./output/$1.webm" "./output/$1.json"
    fi
	python convert_json_to_csv.py "./output/$1.json" "./output/$1"
}

process_yt_video "yt-id"
