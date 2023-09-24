#!/bin/bash
#
# Instalação de servidor automatizado
#
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
apt-get update -y && apt-get upgrade

# validar se servidor já existe
if ! command -v apache2; then
  echo "Apache não instalado"
  echo "Instalando servidor..."
  apt-get install apache2 -y
  sleep 2
else
  echo "Apache instalado"
fi

# Diretório
if [[ ! -d "$server_root" ]]; then
  echo "Diretório do servidor"
  mkdir -p "$server_root"
fi

# arquivo index
if [[ ! -f "$server_root/$index_page" ]]; then
  echo "Criando página de início"
  sleep 2
fi

# Iniciar servidor
echo "Iniciando servidor na porta $server_port..."
apt-get install apache2
systemctl start apache2

# Feature git
echo "Instalando Git..."
sleep 1
apt-get install git

# Clone de link do github
echo "Entrando em pasta raiz..."
cd /var/www/html
sleep 3

# Clonando o git
git clone "https://github.com/Renanfxn/JujutsuKaisen.git"

# cp
if [[ ! -d "$server_root" ]]; then
  cp -rfp JujutsuKaisen/* /var/www/html
  sleep 3
fi
