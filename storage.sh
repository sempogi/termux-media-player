

ls /storage > stor
line=1
cat stor | while read line
   do  

   prep=`grep -ne ^ stor | grep -e ^$line:`
   echo "${prep#$line:}"
      
   done