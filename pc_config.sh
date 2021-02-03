#!/bin/bash

echo 'Atualizando'
apt update
echo 'Instalando python3.8 e python3-pip'
apt install python3.8 && apt install python3-pip 
echo 'Movendo a versao antiga do python pre instalada para add a nova'
mv /usr/bin/python /usr/bin/python_old
echo 'Criando atalho do python3.8 como default python, criando atalho do pip3 como default pip'
ln -s /usr/bin/python3.8 /usr/bin/python
ln -s /usr/bin/pip3 /usr/bin/pip
echo 'Atualizando pip'
pip install --upgrade pip
echo 'Instalando Vim plug'
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo 'Instalando Vim'
apt install vim
echo 'Instalando font fira code'
apt install fonts-firacode
echo 'Instalando Nodejs'
apt install nodejs
echo 'Instalando NPM'
apt install npm 
echo 'Instalando mongodb'
apt install -y mongodb
echo 'Restarando servico do mongodb'
sevice mongodb restart
echo 'Validando status do servico'
service mongodb status
echo 'Instalando poetry'
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
echo 'configurando poetry'
source $HOME/.poetry/env
echo 'Instalando Git'
apt install git
echo 'Instalando Git flow'
apt install git-flow
echo 'Etapa de configuracao do git user.name e user.email'

name= read -r -p "Digite seu nome: " input
echo 'Digite seu email: '
read email

if [$name -ne ''] 
then
	git config --global user.name=$name
else
	echo 'Nao foi possivel configurar seu git'
fi

if [$email -ne '']
then
	git config --global user.email=$email
else
	echo 'Nao foi possivel configurar seu git'
fi

echo 'Instalando spotify'
curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add -
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

apt update && sudo apt install spotify-client
