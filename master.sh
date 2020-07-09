#!/bin/bash
mm_decho ()
{
local i stepping
stepping="0.01"

# When first argument is empty or not given, it just echoes a new line
# and leaves.
if [ ! "$1" ]; then 
echo
return
fi

# If a second argument is given (delay stepping), check it for validity
# (if it is a float) and set stepping according to the argument.
if (( $# > 1 )) && 
[[ ($2 = $(echo $2 | grep -oE '[[:digit:]]')) ||
($2 = $(echo $2 | grep -oE '[[:digit:]]+\.[[:digit:]]+')) ]] 
then
stepping="$2"
# In case the previous test failed, but we have a second argument,
# meaning it is invalid, just print the message, complain a bit and then
# quit the function with false.
elif (( $# > 1 )); then
echo "$1"
echo ".! mm_decho() oops: second argument is invalid!" 1>&2
echo ".! must be /float but is: \"$2\", leaving function.." 1>&2
return false 2>/dev/null
fi

# Do delayed printing of first input argument. Calculate the
# length of first arg. and substract one. Then make it a /for/
# sequence going through all the characters of the string,
# printing these and wait the delay stepping time.
for i in $(seq 0 $((${#1}-1))); do
echo -ne "${1:$i:1}"
sleep $stepping
done
echo
}
# VARIABLES DE COLORES
COLOR[0]='\033[1;37m' #BRAN='\033[1;37m'
COLOR[1]='\e[31m' #VERMELHO='\e[31m'
COLOR[2]='\e[32m' #VERDE='\e[32m'
COLOR[3]='\e[33m' #AMARELO='\e[33m'
COLOR[4]='\e[34m' #AZUL='\e[34m'
COLOR[5]='\e[35m' #MAGENTA='\e[35m'
COLOR[6]='\033[1;36m' #MAG='\033[1;36m'
BARRA="\e[37m×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×\e[0m"
blan='\033[1;37m'
ama='\033[1;33m'
blue='\033[1;34m'
asul='\033[0;34m'
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
plain='\033[0m'
# Instalacion
clear

echo -e "$BARRA"
echo -e "\e[1;33mESPERE UN MOMENTO${plain}"
echo -e "$BARRA"
apt-get update -y >/dev/null 2>&1 && mm_decho "APT-GET UPDATE & UPGRADE" "0.08"
apt-get upgrade -y >/dev/null 2>&1

apt-get install apache2 -y &>/dev/null && mm_decho "INSTALANDO APACHE2" "0.08"
 sed -i "s;Listen 80;Listen 81;g" /etc/apache2/ports.conf
 service apache2 restart > /dev/null 2>&1 &
 
 apt-get install figlet -y &>/dev/null && mm_decho "INSTALANDO FIGLET" "0.08"
 
 apt-get install shc -y &>/dev/null && mm_decho "INSTALANDO SHC" "0.08"
apt-get install lsof >/dev/null 2>&1 && mm_decho "INSTALANDO DEPENDENCIAS" "0.08"
apt-get install sudo >/dev/null 2>&1
apt-get install screen -y >/dev/null 2>&1

apt-get install bc -y >/dev/null 2>&1 && mm_decho "ACTUALIZANDO SISTEMA" "0.08"
apt-get python -y >/dev/null 2>&1

apt-get install unzip -y >/dev/null 2>&1 && mm_decho "EJECUTANDO DESCARGA" "0.08"
apt-get python3 -y >/dev/null 2>&1
echo -e "$BARRA"
IVAR="/etc/http-instas"
SCPT_DIR="/etc/SCRIPT"
rm $(pwd)/$0
ofus () {
unset txtofus
number=$(expr length $1)
for((i=1; i<$number+1; i++)); do
txt[$i]=$(echo "$1" | cut -b $i)
case ${txt[$i]} in
".")txt[$i]="+";;
"+")txt[$i]=".";;
"1")txt[$i]="@";;
"@")txt[$i]="1";;
"2")txt[$i]="?";;
"?")txt[$i]="2";;
"3")txt[$i]="%";;
"%")txt[$i]="3";;
"/")txt[$i]="K";;
"K")txt[$i]="/";;
esac
txtofus+="${txt[$i]}"
done
echo "$txtofus" | rev
}
veryfy_fun () {
[[ ! -d ${IVAR} ]] && touch ${IVAR}
[[ ! -d ${SCPT_DIR} ]] && mkdir ${SCPT_DIR}
unset ARQ
case $1 in
"master.sh")ARQ="/usr/bin/";;
"http-server.py")ARQ="/bin/";;
*)ARQ="${SCPT_DIR}/";;
esac
mv -f $HOME/$1 ${ARQ}/$1
chmod +x ${ARQ}/$1
}
echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
echo -e "\033[1;36m--------------------KEY GENERATOR BY MORDRET OFFICIAL----------------------\033[0m"
echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
read -p "INTRODUZCA SU KEY DE INSTALACIÓN: " Key
echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
[[ ! $Key ]] && {
echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
echo -e "\033[1;33mKey inválida!"
echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
exit
}
meu_ip () {
MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MIP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
echo "$IP" > /usr/bin/vendor_code
}
meu_ip
echo -e "\033[1;33mVerificando key... "
cd $HOME
wget -O "$HOME/lista-arq" $(ofus "$Key")/$IP > /dev/null 2>&1
IP=$(ofus "$Key" | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')
sleep 1s
[[ -e $HOME/lista-arq ]] && {
REQUEST=$(ofus "$Key" |cut -d'/' -f2)
for arqx in `cat $HOME/lista-arq`; do
echo -ne "\033[1;33mDescargando archivo: \033[1;31m[$arqx] "
wget -O $HOME/$arqx ${IP}:81/${REQUEST}/${arqx} > /dev/null 2>&1 && echo -e "\033[1;31m- \033[1;32mRecibido con éxito!" || echo -e "\033[1;31m- \033[1;31mFalla (no recibido!)"
[[ -e $HOME/$arqx ]] && veryfy_fun $arqx
done
[[ ! -e /usr/bin/trans ]] && wget -O /usr/bin/trans https://www.dropbox.com/s/l6iqf5xjtjmpdx5/trans?dl=0 &> /dev/null
mv -f /bin/http-server.py /bin/http-server.sh && chmod +x /bin/http-server.sh
apt-get install bc -y &>/dev/null
apt-get install screen -y &>/dev/null
apt-get install nano -y &>/dev/null
apt-get install curl -y &>/dev/null
apt-get install netcat -y &>/dev/null
apt-get install apache2 -y &>/dev/null
sed -i "s;Listen 80;Listen 81;g" /etc/apache2/ports.conf
service apache2 restart > /dev/null 2>&1 &
IVAR2="/etc/key-gerador"
echo "$Key" > $IVAR2
rm $HOME/lista-arq
echo -e "\033[1;33m Perfecto, utilize el comando \033[1;31m master.sh o master \033[1;33mpara administrar sus keys y
 actualizar la base del servidor"
echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
} || {
echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
echo -e "\033[1;33mKey inválida!"
echo -e "\033[1;36m--------------------------------------------------------------------\033[0m"
}
echo -ne "\033[0m"1