#!/data/data/com.termux/files/usr/bin/bash
mode=$(<mode)
case "$mode" in
shuffle)
echo "Continous">mode
termux-toast "Continous Mode Selected"
;;
*)
echo "shuffle">mode
termux-toast "Shuffle Mode Selected"
;;
esac
