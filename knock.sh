#!/bin/bash
#
# script knock.sh
# Script para encontrar malware
# LAB DESEC

# Portas (tcp) para ativacao 13,37,30000,3000
# Malware fica ativo na porta 1337/tcp
#
# Autor : Luciano Domingues
# Data : Out.2019
# Versao: 1.2

## DEFINICAO DE VARIAVEIS
rede="172.16.1"
portas=(13 37 30000 3000)
ativado="1337"
conta=1

## INICIO FUNCOES
function _limpaTela(){
	clear
}

function _mensagemIniciandoScript(){
	echo "[*] Iniciando scan...."	
}

function _exibeIpMalware(){
		echo " ==========================================================="
		echo "[MALWARE ATIVADO] no IP $rede.$ip ( socket $rede.$ip:$ativado )"
		echo " ==========================================================="
		echo " "
}

function _exibePaginaMalware(){
		echo " **** Exibindo pagina HTML do Malware =========="
		wget $rede.$ip:$ativado -O - 2>/dev/null
		echo " ==========================================================="
}
## FIM FUNCOES

## INICIA SCRIPT
_limpaTela
_mensagemIniciandoScript

for ip in $(seq 1 254)
do
	echo "[$conta] Testando host $rede.$ip "
	for porta in ${!portas[*]}
	do
		hping3 -S $rede.$ip -c 1 -p ${portas[$porta]} &>/dev/null
	done
	# RODA TESTE NA PORTA PARA IDENTIFICAR SE FOI ATIVADA
		hping3 -S $rede.$ip -c 1 -p $ativado 2>/dev/null | grep "SA" &>/dev/null
	# CONFIRMA SE A PORTA FOI ABERTA
	if [ $? -eq 0 ]
	then
		_exibeIpMalware
		_exibePaginaMalware
		exit
	fi
	((conta++))
done
exit 0