#!/bin/bash


echo 'Este sehll pode instalar: gdebi, python3.8, pip, vim plug, fira code font, nodejs, mongodb, npm, git, git flow'

read -p 'Deseja instalar o git s/n ' git_config 
if [$git_config -eq 's']
then
echo 'Para configurar o git e preciso informar um nome e email para definir as configuracoes globais'

read -p "Digite seu nome para configuracao do git user.name: " name
read -p 'Digite seu email para configuracao do git user.email: ' email
fi

read -p 'Deseja configurar o python s/n ' config_python 

read -p 'Deseja configurar o vim  s/n ' config_vim 

read -p 'Deseja configurar o MEAN stack  s/n ' config_mean 


echo 'Atualizando dependencias e pacotes'
apt update

echo 'Instalando gdebi - gerenciador de pactoes deb'
apt install -y  gdebi-core
if [$config_python -eq 's']
then

echo 'Instalando python3.8 e python3-pip'
apt install -y  python3.8 && apt install -y  python3-pip && apt install -y python3-dev 

echo 'Movendo a versao antiga do python pre instalada para python_old'
mv /usr/bin/python /usr/bin/python_old
echo 'Criando atalho do python3.8 como default python, criando atalho do pip3 como default pip'
ln -s /usr/bin/python3.8 /usr/bin/python
ln -s /usr/bin/pip3 /usr/bin/pip
echo 'Atualizando pip'
pip install --upgrade pip
echo 'Instalando poetry'
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
echo 'configurando poetry'
source $HOME/.poetry/env

fi
if [$vim_config -eq 's']
then
echo 'Instalando Vim plug'
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo 'Instalando Vim'
apt install -y  vim
fi
echo 'Instalando font fira code'
apt install -y  fonts-firacode
if [$config_mean -eq 's']
then
echo 'Instalando Nodejs'
apt install -y  nodejs
echo 'Instalando NPM'
apt install -y  npm 
echo 'Instalando mongodb'
apt install -y mongodb
echo 'Restarando servico do mongodb'
sevice mongodb restart
echo 'Validando status do servico'
service mongodb status
fi
echo 'Instalando Git'
apt install -y  git
echo 'Instalando Git flow'
apt install -y  git-flow
echo 'Etapa de configuracao do git user.name e user.email'

if [$git_config -eq 's']
then
if [$name -ne ''] 
then
	git config --global user.name=$name
	git config --global pull.rebase false
else
	echo 'Nao foi possivel configurar seu git'
fi

if [$email -ne '']
then
	git config --global user.email=$email
else
	echo 'Nao foi possivel configurar seu git'
fi
fi

echo 'Instalando oh-my-zsh'
apt install -y zsh

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo 'Download vimrc file from my github'
wget https://raw.githubusercontent.com/andersonflima/config-machine/master/.vimrc
echo 'Download zshrc file from my github'
wget https://raw.githubusercontent.com/andersonflima/config-machine/master/.zshrc

echo "Overwriting your .vimrc and .zshrc with mines"
cp .vimrc $HOME/.
cp .zshrc $HOME/.

echo "Running update again"
apt update
