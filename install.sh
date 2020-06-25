#!/usr/bin/bash
shopt -s expand_aliases


alias drawline='tput setaf 2; printf "%*s\n" "${COLUMNS:-$(tput cols)}" "" | tr " " - ;tput setaf 7'

drawline
tput setaf 6;echo "Starting Instillation of Terminal..."
drawline

drawline
tput setaf 6;echo "Adding Progress Bar and Colours to apt"
drawline

cp ~/config-files/99progressbar  /etc/apt/apt.conf.d
chmod 644 /etc/apt/apt.conf.d/99progressbar

drawline
tput setaf 6;echo "Performing update and upgrade"
drawline

apt update -y && apt upgrade -y

drawline
tput setaf 6;printf "Installing Required Packages and Adding Git Colours" '\n%s\n' "openssh-server openssh-client xclip wget git perl tilix tmux neofetch fonts-firacode dconf-cli ruby zsh python3 python3-pip python3-dev" 
drawline

apt install -y openssh-server openssh-client xclip wget git perl tilix tmux neofetch fonts-firacode dconf-cli ruby zsh python3 python3-pip python3-dev
git config --global color.ui auto

drawline
tput setaf 6;echo "Installing Anaconda"
drawline

wget https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh -O ~/anaconda.sh
bash ~/anaconda.sh -b -p $HOME/.anaconda

drawline
tput setaf 6;echo "Setting Default Shell to Z-Shell and Installing Oh My Zsh"
drawline

chsh -s /usr/bin/zsh root

wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
source ~/.zshrc

drawline
tput setaf 6;echo "Installing Syntax Highlighting and Autosuggestions"
drawline

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

drawline
tput setaf 6;echo "Changing Default Font of Tilix to Fira Conda Retina and Applying Transparency"
drawline

dconf write "/com/gexperts/Tilix/profiles/$(dconf list /com/gexperts/Tilix/profiles/)font" 'Fira Coda weight=453 12'
dconf write "/com/gexperts/Tilix/profiles/$(dconf list /com/gexperts/Tilix/profiles/)background-transparency-percent" 21

drawline
tput setaf 6;echo "Installing Powerline Theme (Powerlevel10k)"
drawline

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

drawline
tput setaf 6;echo "Installing Colourful List Files"
drawline

gem install -y colorls

apt update -y && apt upgrade -y

drawline
tput setaf 6;echo "Installing Glances System Monitoring Tool and Addons"
drawline

pip3 install -y psutil 'glances[action,browser,cloud,cpuinfo,docker,export,folders,gpu,graph,ip,raid,snmp,web,wifi]' 

drawline
tput setaf 6;echo "Installing Powerlines for TMUX"
drawline

cd
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .

drawline
tput setaf 6;echo "Creating Symbolic Links to Config Files"
drawline


if  [[ $1 != "-giraffe" ]]; then
    sed "2d" ~/config-files/.zshrc > ~/config-files/.zshrc
    rm ~/config-files/giraffe.txt
fi

ln -s -f ~/config-files/.tmux.conf ~/.tmux.conf
ln -s -f ~/config-files/.tmux.conf.local ~/.tmux.conf.local
ln -s -f ~/config-files/.tmux.conf ~/.tmux/.tmux.conf
ln -s -f ~/config-files/.bashrc ~/.bashrc
ln -s -f ~/config-files/.zshrc ~/.zshrc
ln -s -f ~/config-files/.p10k.zsh ~/.p10k.zsh
ln -s -f ~/config-files/.condarc ~/.condarc


drawline
drawline
tput setaf 6;echo "DONE!!! Close and Open Tilix"
drawline
drawlinw




