#!/bin/bash

help() {
    echo "Help" ; 
    echo "(Required) Use -p to define active directory password"  ; 
    echo "(Optional) Use -u to define admin username in directory"  ; 
    echo "(Optional) Use -n to define machine prefix name (if n is not present, the default value will be automatically set to linux-[ComputerNumber])" ;

}

user='rescate'
name='linux'

while getopts "p:n:u:h" opt; do
  case $opt in
    n) name="$OPTARG"
    ;;
    p) password="$OPTARG"
    ;;
    u) user="$OPTARG"
    ;;
    h) help
    ;;
    \?) printf  "this is not a valid option\n"; help
    ;;
  esac
done



echo "3c1l4b1nf0" | sudo apt -y install python3-dev libpython3-dev 
echo "3c1l4b1nf0" | sudo apt -y install python3-mysqldb
echo "3c1l4b1nf0" | sudo apt-get -y install python3-pymysql
chmod +x ~/dependencies/login.sh
chmod +x ~/dependencies/Default
chmod +x ~/dependencies/lastW.txt
chmod +x ~/dependencies/who.txt
chmod +x ~/dependencies/login.py


echo "3c1l4b1nf0" | sudo cp -r ~/dependencies/  /usr/local/bin/
echo "3c1l4b1nf0" | sudo cp /usr/local/bin/dependencies/login.sh /etc/profile.d/
echo "3c1l4b1nf0" | sudo cp /usr/local/bin/dependencies/Default /etc/gdm3/PostSession/


reboot 

# echo "Press any key to reboot"
# read

