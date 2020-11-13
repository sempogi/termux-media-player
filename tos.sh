#!/data/data/com.termux/files/usr/bin/bash
#termux-media-player wrapper
#pure bash code.

cnter=0
cat mp4.list | while read line
   do  
        ((cnter++))
  # echo '"'$line'"' >tmmp
  echo "$cnter">cnt 
   done
cnt=$(<cnt)
line=$(shuf -i 1-"$cnt" -n 1)
echo "$line"
#line=1
prep=`grep -ne ^ mp4.list | grep -e ^$line:`
echo "${prep#$line:}">track
track=$(<track)
figlet " " SEM
echo "Music Daemon Running......."
echo "$cnt songs available"
mkdir -p tmp
fdir="tmp"
 while [[ -d $fdir ]]
 do
 #sleep 1
 pinfo=$(termux-media-player info)
 termux-notification --action "am start --user 0 -n com.termux/com.termux.app.TermuxActivity" --type media --media-previous "termux-media-player pause; echo yes>prev " --media-play "termux-media-player 'play'" --media-pause "termux-media-player 'pause' " --media-next "termux-media-player stop"  -t "🎧$pinfo" --content "$line of $cnt" --sound --vibrate 800 --priority high  --image-path "$HOME/test.png" --id $$ --on-delete "rm -rf  tmp"  
 
 echo $(termux-media-player info)>stat
 yy=$(<stat)
case "$yy" in
No*)
#echo "Not Playing"
termux-media-player play "$track"


((line++))
prep=`grep -ne ^ mp4.list | grep -e ^$line:`
echo "${prep#$line:}">track
track=$(<track)
echo "$line">line




;;
*ause*)
prev=$(<prev)
 case "$prev" in
 yes)
 echo no>prev
 ((line--))
 ((line--))
 prep=`grep -ne ^ mp4.list | grep -e ^$line:`
echo "${prep#$line:}">track
track=$(<track)
echo "$line">line
termux-media-player stop
 ;;
 
 esac
;;
esac
 
 done
 termux-media-player stop
 