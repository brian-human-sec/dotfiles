#!/bin/sh

touch apikey
apikey="$(cat apikey)"
count=7

generic()
{
  fname=$1
  videoid=$2
  shift; shift;

  if [ ! -f "audio/$fname.mp3" ]; then
    youtube-dl -x --audio-format mp3 "https://www.youtube.com/watch?v=$videoid" --output "audio/$fname.mp3"
  fi
}


mrturvy()
{
  fname=$1
  videoid=$2
  shift; shift;

  if [ ! -f "audio/$fname.mp3" ]; then
    youtube-dl -x --audio-format mp3 "https://www.youtube.com/watch?v=$videoid" --output "audio/$fname.mp3"
    duration=$(ffprobe -i "audio/${fname}.mp3" -show_entries format=duration -v quiet -of csv="p=0")
    trim=$(perl -le "print($duration-28.0)")
    ffmpeg -ss 8 -t "${trim}" -i "audio/$fname.mp3" "audio/new-${fname}.mp3"
  fi
}

for channel in $(cat channels.txt); do
  channelId=$(echo "$channel" | awk -F, '{print $1}')
  channelName=$(echo "$channel" | awk -F, '{print $2}')
  echo "$channelName"
  echo "$channelId"
  upload=$(curl -s "https://www.googleapis.com/youtube/v3/channels?id=${channelId}&key=${apikey}&part=contentDetails" | jq -r '.items[].contentDetails.relatedPlaylists.uploads')
  # echo "https://www.googleapis.com/youtube/v3/channels?id=${channelId}&key=${apikey}&part=contentDetails"

  if [ "${channelName}" = "techhut" ]; then
    count=15
  elif [ "${channelName}" = "mrturvy" ]; then
    count=15
  else
    count=7
  fi

  payload=$(curl -s "https://www.googleapis.com/youtube/v3/playlistItems?playlistId=${upload}&key=${apikey}&part=snippet&maxResults=${count}&order=date")
  echo "https://www.googleapis.com/youtube/v3/playlistItems?playlistId=${upload}&key=${apikey}&part=snippet&maxResults=${count}&order=date"
  rm -rf "*.csv"
  echo "${payload}" | jq -r '.items[].snippet.title' | sed 's/[[:punct:]]//g' | tr 'ᴴᴰ' ' ' | tr " " "-" | tr '[:upper:]' '[:lower:]' > title.csv
  echo "${payload}" | jq -r '.items[].snippet.publishedAt' > published.csv
  echo "${payload}" | jq -r '.items[].snippet.resourceId.videoId' > videoid.csv

  paste -d ',' published.csv title.csv videoid.csv > output.csv

  for row in $(cat output.csv); do
    # date=$(echo "$row" | awk -F, '{print $1}')
    fname=$(echo "$row" | awk -F, '{print $2}')
    videoid=$(echo "$row" | awk -F, '{print $3}')

    if [ "${channelName}" = "mrturvy" ]; then
      mrturvy "${fname}" "${videoid}"
    else
      generic "${fname}" "${videoid}"
    fi

  done
done

exit 0
