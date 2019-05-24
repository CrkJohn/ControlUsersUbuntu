#!/bin/bash
## gen key 

which parallel > /dev/null
if [ $? -ne 0 ]; then
    echo "No esta instalado gnu-parallel; intentando instalarlo"
    sudo apt-get update
    sudo apt-get install -y parallel
fi

which sshpass > /dev/null
if [ $? -ne 0 ]; then
    echo "No esta instalado sshpass; intentando instalarlo"
    sudo apt-get update
    sudo apt-get install -y sshpass
fi


function copy-key () {
    echo "Copiando clave publica a computador $1"
    sshpass -p3c1l4b1nf0 ssh-copy-id -o  StrictHostKeyChecking=no -o ConnectTimeout=10 sistemas@10.2.67.$1
}

function copy_dependencies () {
    echo "Copiando dependencias a computador $1"
    if [ ! -f script.sh ]; then
    	echo "ERROR: debe existir el archivo de script.sh para ejecutarlo en las maquinas remotamente"
    	exit 1
    fi

    scp -o StrictHostKeyChecking=no -o ConnectTimeout=10 script.sh sistemas@10.2.67.$1:~ > pilogs/$1.log
    
    scp -rp -o StrictHostKeyChecking=no -o ConnectTimeout=10 dependencies sistemas@10.2.67.$1:~ >> pilogs/$1.log
   
}

function execute-script () {
    echo "Ejecutando script en computador $1"
    ssh -o StrictHostKeyChecking=no -o ConnectTimeout=10 "sistemas@10.2.67.$1" -t 'chmod +x script.sh' >> pilogs/$1.log
    ssh -o StrictHostKeyChecking=no -o ConnectTimeout=10 "sistemas@10.2.67.$1" -t 'echo "3c1l4b1nf0" | sudo -S nohup ./script.sh' >> pilogs/$1.log
 
    echo "Termino en computador $1"
}

echo "================"
echo "Rango: $1 - $2"
echo "================"

export -f copy-key
export -f copy_dependencies
export -f execute-script

mkdir -p pilogs

SHELL=/bin/bash parallel copy-key ::: $(seq $1 $2)
SHELL=/bin/bash parallel copy_dependencies ::: $(seq $1 $2)
SHELL=/bin/bash parallel execute-script ::: $(seq $1 $2)
