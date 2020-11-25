#!/data/data/com.termux/files/usr/bin/bash

        termux-volume >volume
		 #get music volume data
			mvolume=$(jq '.[] | select(.stream=="music")' volume)
			echo "$mvolume">volume
			jq '.volume' volume>curv
			jq '.max_volume' volume>maxv

        dialog --rangebox "Termux Volume Controller" 0 0 1 $(<maxv) $(<curv) 2>defaultvol
        termux-volume music $(<defaultvol)
        volumectrl | bash volumectrl.sh
        exit
 
