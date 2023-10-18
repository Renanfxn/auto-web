#!/bin/bash
#
# Instalação de servidor automatizado 
#Feito por Renan Santos de Souza do 2 semestre de Redes de Computadores da Rede SENAI Jandira
#Data realizada o script em casa: 29/09/2023
# Cvs $header$
# DECLARAR VARIAVEL
shopt -s -o nounset

# validação
server_root="/var/www/html"
server_port="80"
index_page="index.html"

# Título
echo "Iniciando servidor apache2"

# validar permissão
if [ "$EUID" -ne 0 ]; then
  echo "Necessário permissão administrativa"
  exit 1
fi

# upgrade
echo "Atualizando com apt-get"
echo "Deseja continuar a atualizaçaão (sim/não)?"
read resposta
if [ "$resposta" = "sim"]; then 
echo "Atualizando maquina..."
apt-get update -y
sleep 2
elif [ "$resposta" = "não"]; then
else
    echo "Escolha uma opção valida. Escolha a opção 'sim' ou 'não'"
fi
sleep 2

echo "Indo para o Menu WEB"
sleep 1

#MENU
echo "Menu WEB
1)Instalação do servidor
2)Desinstalar servidor
3)Iniciar servidor
4)Parar servidor
5)Reiciar servidor
6)Informações do servidor
7)Sair
Escolha uma opção: "
read OPC

function install () {
    echo "Instalando servidor"; apt-get install apache2; sleep 2; clear; echo "Servidor Instalado!!"
}
function purge () {
    echo "Desinstalando Servidor!!"; apt-get purge apache2 -y; sleep 2; clear; echo "Servidor Desinstalado!!"
}
function start() {
    echo "Iniciando Servidor!!"; systemctl start apache2; sleep 2; clear; echo "Servidor Iniciado!!"
}
function stop () {
    echo "Parando Servidor!!"; systemctl stop apache2; sleep 2; clear; echo "Servidor Inativo!!"
}
function restart (){
    echo "Reiniciando Servidor!!"; systemctl restart apache2; sleep 2; clear; echo "Servidor Reinicado!!"
}
function status () {
    echo "Informações do Servidor!!"; systemctl status apache2; sleep 4; clear; echo "Informações exibidas!!"
}
function exit () {
    echo "Saindo do Menu..."; exit 0; sleep 2;
}

case $OPC in
1) install;;
2) purge;;
3) start;;
4) stop;;
5) restart;;
6) status;;
7) exit;;
*) echo "Opção Invalida";;
esac
