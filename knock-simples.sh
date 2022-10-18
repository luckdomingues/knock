#!/bin/bash
# Script para teste PORTKNOCK 
# Malware LAB DESEC - Rede VPN
# Portas bate: 13/tcp 37/tcp 30000/tcp 3000/tcp
# Porta abre: 1337/tcp

## Testa se o parametro da rede foi passado
if  [ "$1" == "" ] 
then
        echo [ DESEC SECURITY - Port Scannetwork ]
        echo  " Modelo de uso: $0 REDE ALVO "
        echo " Exemplo: $0 172.16.1 "
        exit 1
fi

## Inicia script
sudo echo "[+] Iniciando varredura da rede $1 ..."
for ip in {1..254}
do
   echo "[+] Testando IP $1.$ip ..."
   sudo hping3 -S -p 13  -c 1 $1.$ip &> /dev/null
   sudo hping3 -S -p 37  -c 1 $1.$ip &> /dev/null
   sudo hping3 -S -p 30000  -c 1 $1.$ip &> /dev/null
   sudo hping3 -S -p 3000  -c 1 $1.$ip &> /dev/null
   sudo hping3 -S -p 1337  -c 1 $1.$ip 2> /dev/null | grep "flags=SA"
   echo "#------------#"
done 
exit 0
