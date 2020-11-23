#!/data/data/com.termux/files/usr/bin/bash
#termux-media-player wrapper
#pure bash code.
#with playlist function!!!

#find -L ~/storage/shared/ -type f -ipath $strf  >>mp4.list
if [ -e "$PREFIX/tmp/media.play" ]; then
termux-toast "Only One Instance is Allowed" || echo "Only 1 instance of program to run is allow"
exit
fi
iamrunning="$PREFIX/tmp/media.play"
>$iamrunning
trap "rm -f $iamrunning" 0 1 2 5 15

cd
commu=$1

case $commu in 
start)
cnter=0
cd  $HOME      
echo $$>id
clear 
if [ -e first ]; then
 line=$(<line)
 else
 echo 1>line
 echo "init">first
 fi

DIALOG=${DIALOG=dialog}

$DIALOG --title " Media Scanner" --clear \
        --yesno "Search Audio File and Create Playlist?" 10 30

case $? in
  0)
  clear
  $DIALOG --backtitle "Controls" \
	--title "Media Config" \
        --radiolist "Search in"  0 0 0 \
        "1" "Internal Storage Only" on \
        "2" "External Storage Only" off \
        "3" "Both Internal and External" off \
        "4" "Expert Mode -Search String" off \
        "5" "Install Mp3,M4a Downloader" off \
        "6" "Update This Script from repo.r" off \
        "7" "Exit App" off 2>location

  clear
        figlet " "SEM
        echo "Please wait........................ok"
        echo "Searching media....................wait"
        #external sdcard test /storage/0ECE-1F1A
        #its working#
        loc=$(<location)
        case "$loc" in
        2)
        find -L  /storage/ -type f -ipath '*.m4a'  >all.list #this my external sdcard
        find -L  /storage/ -type f -ipath '*.mp4'  >>all.list #this my external sdcard
        find -L  /storage/ -type f -ipath '*.mp3'  >>all.list #this my external sdcard
        ;;
        #this is internal sdcard
        1)
      find -L ~/storage/shared/ -type f -ipath '*.mp3' >all.list
      find -L ~/storage/shared/ -type f -ipath '*.mp4' >>all.list
       find -L ~/storage/shared/ -type f -ipath '*.m4a'  >>all.list
      ;;
      3)
        find -L  /storage/ -type f -ipath '*.m4a'  >all.list #this my external sdcard
        find -L  /storage/ -type f -ipath '*.mp4'  >>all.list #this my external sdcard
        find -L  /storage/ -type f -ipath '*.mp3'  >>all.list #th
        find -L ~/storage/shared/ -type f -ipath '*.mp3' >>all.list
        find -L ~/storage/shared/ -type f -ipath '*.mp4' >>all.list
        find -L ~/storage/shared/ -type f -ipath '*.m4a'  >>all.list
      ;;
      4)
        
        $DIALOG --title "Expert Mode" --clear \
        --inputbox "Enter Your Search String \n example: \n *.mp3 -mp3 wild card \n *.mp4 -mp4 wildcardsearch \n *eraser* - search for eraser. \n *madonna*.mp3 \n General Format: *stringtosearch*.mp3" 0 0 "$(<strsear)" 2>strsear

         clear
         figlet " " Sem
         echo ""
         echo "-----------"
         kwery=$(<strsear)
        
        echo "Searching $kwery.......... wait"
        echo "-----------"
        echo ""
        find -L  /storage/ -type f -ipath "$kwery" >all.list #this my external sdcard
        find -L  ~/storage/shared/ -type f -ipath "$kwery"  >>all.list #this my internal sdcar
   
        ;;
        5)
        curl https://raw.githubusercontent.com/sempogi/termuxurl/main/installytandspoti.sh -o ytinstall.sh
        chmod +x ytinstall.sh
        dos2unix ytinstall.sh
        bash ytinstall.sh
        
        bash ~/bin/termux-url-opener "https://youtu.be/fzXOxKSJHxM"
        exit
        ;;
        6)
        curl https://raw.githubusercontent.com/sempogi/termux-media-player/main/install.sh -o updateme.sh
        chmod +x updateme.sh
        dos2unix updateme.sh
        bash updateme.sh
        exit
        ;;
         7)
        exit
        ;;
      esac
        echo 1>line
                echo "Searching media.................... Done"
                echo "Creating Playlist.................wait"
 #----------
echo '#!/data/data/com.termux/files/usr/bin/bash' >playl.sh
echo '#Auto generated script for playlist control of mediaplay--coded by semsabiduria' >>playl.sh
echo 'cd $HOME'>>playl.sh
echo 'pasme="$1"' >>playl.sh
echo 'case $pasme in' >>playl.sh
echo 'pass)'>>playl.sh
echo 'echo "" '>>playl.sh
echo ';;' >>playl.sh
echo '*)' >>playl.sh
echo 'if [ -e $PREFIX/tmp/test.run ]; then '>>playl.sh
echo 'termux-toast "Program running"'>>playl.sh
echo 'exit' >>playl.sh
echo 'fi' >>playl.sh
echo ';;' >>playl.sh
echo 'esac' >>playl.sh
echo 'DIALOG=${DIALOG=dialog}'>>playl.sh
echo 'tempfile=$PREFIX/tmp/test.run' >>playl.sh
echo 'trap "rm -f $tempfile" 0 1 2 5 15'  >>playl.sh
echo "" >>playl.sh
#playl.sh script header end here
echo 'default=$(<line)' >>playl.sh
 echo 'dialog --default-item "$default" --title "Mediaplay Loaded with $(<cnt) Audio File" \' >>playl.sh
echo '--menu "Playlist \n Use Arrow Key to Navigate \n Enter or Spacebar to Play." 0 0 0 \' >>playl.sh
echo '  enjoy "RANDOM Start" \'>>playl.sh
  #f1 "Directory One" off \
  >base
  ast="'"
cat all.list | while read line
   do  
        ((cnter++))
        basefi=""
        basename $ast"$line"$ast >base
        basefi=$(<base)
        
        echo '  '$cnter' "'$basefi'" \' >>playl.sh
  
  echo "$cnter">cnt 
   done
   
   #playl.sh footer
   
   
echo '  enjoy "End Of Playlist: RANDOM PLAY"  2> $tempfile' >>playl.sh
echo "" >>playl.sh
echo 'retval=$?'>>playl.sh
echo 'if [ -e "$tempfile" ]; then' >>playl.sh
echo 'choice=`cat $tempfile`'>>playl.sh
echo 'else' >> playl.sh
echo 'exit' >>playl.sh
echo 'fi' >>playl.sh
echo 'echo "index: $choice"' >>playl.sh


echo 'case "$choice" in' >>playl.sh
echo 'enjoy)' >>playl.sh
echo 'cnt1=$(<cnt)'>>playl.sh
echo 'choice=$(shuf -i 1-"$cnt1" -n 1)'>>playl.sh
echo ' echo "shuffle" >mode ' >>playl.sh
echo ';;' >>playl.sh
echo '*)' >>playl.sh
echo ' echo "continuous" >mode ' >>playl.sh
echo ';;' >>playl.sh
echo 'esac' >>playl.sh


echo 'case $retval in'>>playl.sh
echo '0)echo " Hello" ;;' >>playl.sh
echo '*)exit;;' >>playl.sh
echo 'esac'>>playl.sh
 echo ' prep=`grep -ne ^ all.list | grep -e ^$choice:`' >>playl.sh
 echo 'echo "${prep#$choice:}">track' >>playl.sh
echo 'track=$(<track)' >>playl.sh
#echo "$choice">line
echo 'echo "$choice">line' >>playl.sh
echo 'termux-media-player play "$track"' >>playl.sh
echo 'id1=$(<id)' >>playl.sh
#echo 'termux-notification --action "mediaplay 'serve' " --type media --media-previous "termux-media-player pause; echo yes>prev " --media-play "termux-media-player 'play'" --media-pause "termux-media-player 'pause' " --media-next "termux-media-player stop"  -t "🎧$pinfo" --content "$choice" --sound --vibrate 800 --priority high  --image-path "$HOME/test.png" --id "$id1" --on-delete "rm -rf  tmp"  ' >>playl.sh
#echo 'mediaplay serve'>>playl.sh
echo 'showplay "pass" || bash playl.sh "pass" '>>playl.sh

#end of playl.sh script
echo "Playlist Created!"
chmod +x playl.sh
cp playl.sh $PREFIX/bin/showplay
chmod +x $PREFIX/bin/showplay

     
;;
  1)
  if [ -e all.list ]; then
  clear
  figlet " " SEM
    echo "Loading old playlist................."
  else
  echo "No playlis Found,  <quitting>"
  exit
  fi
    ;;
  255)
    echo "Exiting"
    exit
;;
esac



        


echo "Open New Temux Session"
echo "Type cd and the bash playl.sh"   
   
   
cnt=$(<cnt)
#line=$(shuf -i 1-"$cnt" -n 1)
line=$(<line)
echo "$line"
#line=1
prep=`grep -ne ^ all.list | grep -e ^$line:`
echo "${prep#$line:}">track
track=$(<track)
clear



mkdir -p tmp
fdir="tmp"
 while [[ -d $fdir ]]
 do
 figlet " "Sem
 echo "Music Daemon Running.........listening"

 echo "Playmode : " $(<mode)
echo "$line of $cnt"
echo ""
echo "$yy"
ast1='"'
tick=$track

#ffmpeg -i mp31.mp3 -an -vcodec  copy -y test2.png > output.txt 2>&1
 ffmpeg -i """$tick""" -an -vcodec copy -y test.png >output.txt 2>&1
#sleep $2
 
 ffprobe -show_format -print_format json """$tick""" >tag.list 2>tagl
 echo "Title : "$(jq '.format .tags .title' tag.list)>tagdis
 echo "Artist:"$(jq '.format .tags .artist' tag.list)>>tagdis
 
 echo "Location:"$(jq '.format .filename' tag.list)>>tagdis
 
 echo "File Format:"$(jq '.format .format_long_name' tag.list)>>tagdis
 echo "Bitrate:"$(jq '.format .bit_rate' tag.list)>>tagdis
 echo "Description:"$(jq '.format .tags .description' tag.list)>>tagdis
# echo "Comment:"$(jq '.format .tags .comment' tag.list)>>tagdis
# echo "Description:"$(jq '.format .tags .lyrics' tag.list)>>tagdis
 tagdis=$(<tagdis)
 line=$(<line)
 #pinfo=$(termux-media-player info)
 pinfo=$(jq '.format .tags .title' tag.list)
 case "$pinfo" in
 null)
 pinfo=$(termux-media-player info)
 ;;
 esac
 termux-notification --title "Media Info" --content "$tagdis" --id 12 --image-path "$HOME/test.png" --icon "$HOME/test.png"
 termux-notification --action "termux-toast 'Sem Is My Name'; toogleplay " --type media --media-previous "termux-media-player pause; echo yes>prev " --media-play "termux-media-player 'play'" --media-pause "termux-media-player 'pause' " --media-next "termux-media-player stop" --icon "next" -t "🎧$pinfo" --content "Playmode: $(<mode)  $line of $cnt" --sound --vibrate 800 --priority high  --image-path "$HOME/test.png" --id $$ --on-delete "rm -rf  tmp"  
 
 echo $(termux-media-player info)>stat
 yy=$(<stat)
 clear
case "$yy" in
No*)
#echo "Not Playing"
#termux-media-player play "$track"
playmode=$(<mode)
case "$playmode" in
shuffle)
line=$(shuf -i 1-"$cnt" -n 1)
;;
*)
((line++))
;;
esac


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
 ;;
 serve)
 
 cnt=$(<cnt)
 echo "Music Daemon Running.........listening"
echo "Open New Temux Session"
echo "Type cd and the bash playl.sh"  
echo "$cnt songs available"

#bash playl.sh
mkdir -p tmp
fdir="tmp"
 while [[ -d $fdir ]]
 do
 sleep $2
 
 
 

 
 line=$(<line)
 pinfo=$(termux-media-player info)
 termux-notification --action "termux-toast 'SEM Is MyName' " --type media --media-previous "termux-media-player pause; echo yes>prev " --media-play "termux-media-player 'play'" --media-pause "termux-media-player 'pause' " --media-next "termux-media-player stop"  -c "🎧$pinfo" -t "$line of $cnt" --sound --vibrate 800 --priority high  --image-path "$HOME/test.png" --id $$ --on-delete "rm -rf  tmp"  
 
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
 
 ;;
 *) 
 clear
 figlet " " CODEX
 echo ""
 echo "_________________"
 echo "Script info"
 echo "_________________"
 echo "1. Mediaplay/tos.sh   - play your audio"
 echo "2. showplay/playl.sh  - Display Playlist"
 echo ""
 echo  'Type "mediaplay start" to begin'
 echo  '                 or "bash tos.sh" start'
 echo  'Type "showplay" or "bash playl.sh" for playlist'
 echo ""
 
 ;;
 esac

