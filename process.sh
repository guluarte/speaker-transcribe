process_yt_video () {
	yt-dlp "$1" --sponsorblock-remove all -f ba -o "./output/audios/audio-%(id)s.%(ext)s"
}

process_yt_video "https://www.youtube.com/watch?v="

audiofiles=`ls ./output/audios/audio-*`
for eachfile in $audiofiles
do
    if [[ ! -e "./output/json/$eachfile" ]]
    then
        echo $eachfile
        python predict.py "$eachfile" "./output/json/$(basename $eachfile).json" "Prompt"
    fi
done

csvfiles=`ls ./output/json/*.json`
for eachfile in $csvfiles
do
    python convert_json_to_csv.py "$eachfile" "./output/csv/$(basename $eachfile)"
done

tar -czvf output.tar.gz ./output/
