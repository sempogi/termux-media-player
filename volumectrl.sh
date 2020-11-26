#!/data/data/com.termux/files/usr/bin/bash
clear
cd 
        termux-volume >genvolume
		 #get music volume data
			mvolume=$(jq '.[] | select(.stream=="music")' genvolume)
			echo "$mvolume">genvolume
			jq '.volume' genvolume>curv
			jq '.max_volume' genvolume>maxv

        dialog --rangebox "Termux Volume Controller" 0 0 1 $(<maxv) $(<curv)  2>defaultvol
        
       

retval=$?
      case $retval in
     0)
        
        termux-volume music $(<defaultvol)
        termux-toast "Volume Set"
        volumectrl ||  bash volumectrl.sh
       ;;
      esac
        
    
        exit
 
