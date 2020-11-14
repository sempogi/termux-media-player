#!/data/data/com.termux/files/usr/bin/bash
#termux-media-player wrapper
#pure bash code.
#with playlist function!!!
#find -L ~/storage/shared/ -type f -ipath $strf  >>mp4.list
cnter=0
cd        
clear
        echo "Updating playlist Please wait........."
        find -L ~/storage/shared/mp3s/ -type f -ipath '*.mp3' >all.list
        find -L ~/storage/shared/youtube/ -type f -ipath '*.mp4' >>all.list
        find -L ~/storage/shared/ -type f -ipath '*.m4a'  >>all.list
        echo " Scanning Finished!"
 #----------
echo '#!/bin/sh' >playl.sh
echo 'DIALOG=${DIALOG=dialog}'>>playl.sh
echo 'tempfile=`tempfile 2>/dev/null` || tempfile=/tmp/test$$' >>playl.sh
echo 'trap "rm -f $tempfile" 0 1 2 5 15'  >>playl.sh
echo "" >>playl.sh
#playl.sh script header end here

  
echo 'dialog --radiolist "Playlist" 0 0 0 \' >>playl.sh
  #f1 "Directory One" off \
  >base
  ast="'"
cat all.list | while read line
   do  
        ((cnter++))
        basefi=""
        basename $ast"$line"$ast >base
        basefi=$(<base)
        
        echo '  '$cnter' "'$basefi'" on\' >>playl.sh
  
  echo "$cnter">cnt 
   done
   
   #playl.sh footer
   
   
echo '  en "This the End of Playlist" on  2> $tempfile' >>playl.sh
echo "" >>playl.sh
echo 'choice=`cat $tempfile`'>>playl.sh
echo 'echo "index: $choice"' >>playl.sh
 echo ' prep=`grep -ne ^ all.list | grep -e ^$choice:`' >>playl.sh
 echo 'echo "${prep#$choice:}">track' >>playl.sh
echo 'track=$(<track)' >>playl.sh
#echo "$choice">line
echo 'echo "$choice">line' >>playl.sh
echo 'termux-media-player play "$track"' >>playl.sh
echo 'bash playl.sh'>>playl.sh
#end of playl.sh script
   
   
   
cnt=$(<cnt)
#line=$(shuf -i 1-"$cnt" -n 1)
line=$(<line)
echo "$line"
#line=1
prep=`grep -ne ^ all.list | grep -e ^$line:`
echo "${prep#$line:}">track
track=$(<track)
figlet " " SEM
echo "Music Daemon Running......."
echo "$cnt songs available"
chmod +x playl.sh
#bash playl.sh
mkdir -p tmp
fdir="tmp"
 while [[ -d $fdir ]]
 do
 #sleep 1
 
 
 

 
 line=$(<line)
 pinfo=$(termux-media-player info)
 termux-notification --action "termux-toast 'Sem Is My Name' " --type media --media-previous "termux-media-player pause; echo yes>prev " --media-play "termux-media-player 'play'" --media-pause "termux-media-player 'pause' " --media-next "termux-media-player stop"  -t "🎧$pinfo" --content "$line of $cnt" --sound --vibrate 800 --priority high  --image-path "$HOME/test.png" --id $$ --on-delete "rm -rf  tmp"  
 
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
                     
                     termux-media-player stop
                     ((line--))
                     echo "$line">line
                  ;;
          esac
;;
esac
 
 done
 termux-media-player stop
 termux-notification-remove $$
#push server https://github.com/sempogi/termux-media-player.git
 

