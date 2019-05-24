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

echo $user
echo $password

domainjoin-cli leave $user $password

xx=$(ip a | grep 10.2.67 | python -c "from sys import stdin;x=stdin.readline().strip().split()[1].split(\".\")[-1].split(\"/\")[0];print(x)")
hostname "$name"-$xx

domainjoin-cli join LABINFO.IS.ESCUELAING.EDU.CO "$user" "$password" && echo "Success, rebooting..."

