url="https://xkcd.com/info.0.json"
echo "Fetching $url"
curl -s "$url" -o xkcd.json
img_url=$(jq -r .img xkcd.json)
title=$(jq -r .title xkcd.json)
num=$(jq -r .num xkcd.json)
alt=$(jq -r .alt xkcd.json)

echo "Title: $title"
echo "$title" > latest-xkcd-title.txt
echo "$num" > latest-xkcd-num.txt
echo "$alt" > latest-xkcd-alt.txt
curl -s -L "$img_url" -o latest-xkcd.png

title=$(cat latest-xkcd-title.txt)
num=$(cat latest-xkcd-num.txt)
alt=$(cat latest-xkcd-alt.txt)
link="https://xkcd.com/$num"

# README.md
echo "# XKCD of the Day" > README.md
echo "### [#${num} – ${title}](${link})" >> README.md
echo "![Latest XKCD](latest-xkcd.png)" >> README.md
echo "> ${alt}" >> README.md
echo "_Last updated: $(date -u +'%Y-%m-%d %H:%M UTC')_" >> README.md
echo "EOF" >> README.md

