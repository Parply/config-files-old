#!/usr/bin/bash
shopt -s expand_aliases
alias drawline='tput setaf 2; printf "%*s\n" "${COLUMNS:-$(tput cols)}" "" | tr " " - ;tput setaf 7'


if [ -f continue_install.txt ]; then 
 
curl -Lo install.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O install.sh
export CHSH="no"; export RUNZSH="no"; sh ./install.sh

 
 
#runuser -l $USERINVOKING 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"'
#sed -i's@~@'"$PWD"'@g' $PWD/install.sh 
#sh $PWD/install.sh
#cp $PWD/.oh-my-zsh/templates/zshrc.zsh-template $PWD/.zshrc
#source $PWD/.zshrc

drawline
tput setaf 6;echo "Installing Syntax Highlighting and Autosuggestions"
drawline

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $PWD/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions $PWD/.oh-my-zsh/custom/plugins/zsh-autosuggestions

#drawline
#tput setaf 6;echo "Changing Default Font of Tilix to Fira Conda Retina and Applying Transparency"
#drawline

#dconf write "/com/gexperts/Tilix/profiles/$(dconf list /com/gexperts/Tilix/profiles/)font" 'Fira Coda weight=453 12'
#dconf write "/com/gexperts/Tilix/profiles/$(dconf list /com/gexperts/Tilix/profiles/)background-transparency-percent" 21

#export DISPLAY=:0.0; xhost +; dconf load /org/gnome/terminal/ < config-files/gnome-terminal.conf; xhost -
#export DISPLAY=:0.0; xhost +; dconf load /com/gexpert/ < config-files/tilix-terminal.conf; xhost -


drawline
tput setaf 6;echo "Installing Powerline Theme (Powerlevel10k)"
drawline

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $PWD/.oh-my-zsh/custom/themes/powerlevel10k


drawline
tput setaf 6;echo "Installing Powerlines for TMUX"
drawline


git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .

drawline
tput setaf 6;echo "Creating Symbolic Links to Config Files"
drawline

cd config-files




if  [[ $1 != "-giraffe" ]]; then
    sed -i "2d" .zshrc 
    rm giraffe.txt
fi

#cd

#rm .bashrc
#rm .zshrc
#rm .tmux.conf
#rm .tmux.conf.local
#rm .tmux/.tmux.conf
#rm .tmux/.tmux.conf.local

#cd config-files

ln -s -f $PWD/.tmux.conf /home/$USER/.tmux.conf
ln -s -f $PWD/.tmux.conf /home/$USER/.tmux/.tmux.conf
ln -s -f $PWD/.tmux.conf.local /home/$USER/.tmux.conf.local
ln -s -f $PWD/.tmux.conf.local /home/$USER/.tmux/.tmux.conf.local
ln -s -f $PWD/.bashrc /home/$USER/.bashrc
ln -s -f $PWD/.zshrc /home/$USER/.zshrc
ln -s -f $PWD/.p10k.zsh /home/$USER/.p10k.zsh
ln -s -f $PWD/.condarc /home/$USER/.condarc

#cp .tmux.conf ../.tmux.conf
#cp .tmux.conf ../.tmux/.tmux.conf
#cp .tmux.conf.local ../.tmux.conf.local
#cp .tmux.conf.local ../.tmux/.tmux.conf.local
#cp .bashrc ../.bashrc
#cp .zshrc ../.zshrc
#cp .p10k.zsh ../.p10k.zsh
#cp .condarc ../.condarc


cd 

#source .bashrc
#source .zshrc
#source .p10.conf
#source .condarc
#source .tmux.conf
#source .tmux.conf.local


drawline
drawline
tput setaf 6;echo "DONE!!! Change font in terminal to Fira Code"
drawline
drawline



else


cd ..
USERINVOKING=$(basename $PWD)
cd config-files
ln -s -f /etc/profile.d/vte-2.91.sh /etc/profile.d/vte.sh 
for i in $(ls .[!.^g]*); do
    sed -i 's@alexander@'"$USERINVOKING"'@g' $i
done   

drawline
tput setaf 6;echo "Starting Instillation of Terminal..."
drawline

drawline
tput setaf 6;echo "Adding Progress Bar and Colours to apt"
drawline

cp $PWD/99progressbar  /etc/apt/apt.conf.d
chmod 644 /etc/apt/apt.conf.d/99progressbar

drawline
tput setaf 6;echo "Performing update and upgrade"
drawline

apt update -y && apt upgrade -y

drawline
tput setaf 6;echo "Installing Required Packages and Adding Git Colours"; echo "curl openssh-server openssh-client xclip wget git perl tilix tmux neofetch fonts-firacode dconf-cli ruby ruby-dev zsh python3 python3-pip python3-dev" 
drawline

apt install -y curl openssh-server openssh-client xclip wget git perl tilix tmux neofetch fonts-firacode dconf-cli ruby ruby-dev zsh python3 python3-pip python3-dev
git config --global color.ui auto

drawline
tput setaf 6;echo "Installing Anaconda"
drawline
cd ..
wget https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh -O anaconda.sh
bash ./anaconda.sh -b -p .anaconda3

drawline
tput setaf 6;echo "Installing Colourful List Files"
drawline

gem install colorls

apt update -y && apt upgrade -y

drawline
tput setaf 6;echo "Installing Glances System Monitoring Tool and Addons"
drawline

pip3 install psutil 'glances[action,browser,cloud,cpuinfo,docker,export,folders,gpu,graph,ip,raid,snmp,web,wifi]' 

drawline
tput setaf 6;echo "Setting Default Shell to Z-Shell and Installing Oh My Zsh"
drawline




touch .zshrc
touch ~/.zshrc
chsh -s /usr/bin/zsh root
chsh -s /usr/bin/zsh $USERINVOKING
echo "alias shopt='/usr/bin/shopt'" >> .zshrc
echo "touch continue_install.txt; zsh ./config-files/install.sh" >> .zshrc

runuser -l $USERINVOKING -c "exec zsh"

fi

