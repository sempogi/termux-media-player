#!/data/data/com.termux/files/usr/bin/bash
#termux-media-player wrapper
#pure bash code.
#find -L ~/storage/shared/ -type f -ipath $strf  >>mp4.list
cnter=0
cd
#if [ -e "all.list"  ]; then
# echo "Playlist  Found" 
   
#else
        
        echo "Updating playlist Please wait........."
        find -L ~/storage/shared/mp3s/ -type f -ipath '*.mp3' >all.list
        find -L ~/storage/shared/youtube/ -type f -ipath '*.mp4' >>all.list
        find -L ~/storage/shared/ -type f -ipath '*.m4a'  >>all.list
        echo " Scanning Finished!"
   
#fi
cat all.list | while read line
   do  
        ((cnter++))
  # echo '"'$line'"' >tmmp
  echo "$cnter">cnt 
   done
   
cnt=$(<cnt)
line=$(shuf -i 1-"$cnt" -n 1)
echo "$line"
#line=1
prep=`grep -ne ^ all.list | grep -e ^$line:`
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
#termux-media-player play "$track"
((line++))


prep=`grep -ne ^ all.list | grep -e ^$line:`
echo "${prep#$line:}">track
track=$(<track)
echo "$line">line
termux-media-player play "$track"




;;

*ause*)
       prev=$(<prev)
       case "$prev" in
               yes)
                    echo no>prev
                    ((line--))
                     prep=`grep -ne ^ all.list | grep -e ^$line:`
                     echo "${prep#$line:}">track
                     track=$(<track)
                     echo "$line">line
                     termux-media-player stop
                     ((line--))
                  ;;
          esac
;;
esac
 
 done
 termux-media-player stop
 termux-notification-remove $$
#push server https://github.com/sempogi/termux-media-player.git
 

