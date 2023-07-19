apt-get update
apt-get install ffmpeg libsndfile1 python3.10-venv -y

python3.10 -m venv venv
source ./venv/bin/activate
pip install -r requeriments.txt

if [[ ! -e "/data/pyannote" ]]
then
    wget -O - https://pyannote-speaker-diarization.s3.eu-west-2.amazonaws.com/data-2023-03-25-02.tar.gz | tar xz -C /
fi

if [[ ! -e "/data/whisper/large-v2.pt" ]]
then
    mkdir /data/whisper
    wget -P /data/whisper https://openaipublic.azureedge.net/main/whisper/models/81f7c96c852ee8fc832187b0132e569d6c3065a3252ed18e56effd0b6a73e524/large-v2.pt
fi

sudo wget -qO /usr/local/bin/yt-dlp https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp
sudo chmod a+rx /usr/local/bin/yt-dlp
yt-dlp --version

mkdir -p ./output/json/
mkdir -p ./output/audios/
mkdir -p ./output/csv/

process_yt_video () {
	yt-dlp "$1" --sponsorblock-remove all -f ba -o "./output/audios/audio-%(id)s.%(ext)s"
}

process_yt_video "https://www.youtube.com/watch?v=id"

audiofiles=`ls ./output/audios/audio-*`
for eachfile in $audiofiles
do
    if [[ ! -e "./output/json/$eachfile" ]]
    then
        echo $eachfile
        python predict.py "$eachfile" "./output/json/$(basename $eachfile).json" "Transcript of Part of a Career Counseling Session"
    fi
done

csvfiles=`ls ./output/json/*.json`
for eachfile in $csvfiles
do
    python convert_json_to_csv.py "$eachfile" "./output/csv/$(basename $eachfile)"
done
