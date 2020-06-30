#!/usr/bin/bash
shopt -s expand_aliases
alias drawline='tput setaf 2; printf "%*s\n" "${COLUMNS:-$(tput cols)}" "" | tr " " - ;tput setaf 7'


if [ -f continue_install.txt ]; then 
drawline
tput setaf 6;echo "Installing MesloLGS NF fonts"
drawline
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf

mkdir -p ~/.local/share/fonts 

mv *.ttf ~/.local/share/fonts 

fc-cache -f -v 

drawline
tput setaf 6;echo "Setting Default Shell to Z-Shell and Installing Oh My Zsh"
drawline
 
curl -Lo install.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O install.sh
export CHSH="no"; export RUNZSH="no"; sh ./install.sh

 
 


drawline
tput setaf 6;echo "Installing Syntax Highlighting and Autosuggestions"
drawline

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $PWD/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions $PWD/.oh-my-zsh/custom/plugins/zsh-autosuggestions



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
tput setaf 6;echo "Vim plugin manager"
drawline

curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

drawline
tput setaf 6;echo "Creating Symbolic Links to Config Files"
drawline

mkdir -p ~/.config/glances
mkdir -p ~/.config/kitty


cd config-files




if  [[ $1 != "-giraffe" ]]; then
    sed -i "2d" .zshrc 
    rm giraffe.txt
fi






ln -s -f $PWD/colours.conf /home/$USER/.config/kitty/colours.conf
ln -s -f $PWD/kitty.conf /home/$USER/.config/kitty/kitty.conf
ln -s -f $PWD/glances.conf /home/$USER/.config/glances/glances.conf
ln -s -f $PWD/.vimrc /home/$USER/.vimrc
ln -s -f $PWD/.tmux.conf /home/$USER/.tmux.conf
ln -s -f $PWD/.tmux.conf /home/$USER/.tmux/.tmux.conf
ln -s -f $PWD/.tmux.conf.local /home/$USER/.tmux.conf.local
ln -s -f $PWD/.tmux.conf.local /home/$USER/.tmux/.tmux.conf.local
ln -s -f $PWD/.bashrc /home/$USER/.bashrc
ln -s -f $PWD/.zshrc /home/$USER/.zshrc
ln -s -f $PWD/.p10k.zsh /home/$USER/.p10k.zsh
ln -s -f $PWD/.condarc /home/$USER/.condarc




cd 


source .anaconda3/bin/activate
source .bashrc
source .zshrc
source .p10.conf
source .condarc
source .tmux.conf
source .tmux.conf.local

conda init

export SHELL="$zsh"

drawline
tput setaf 6;echo "Installing vim plugins"
drawline

ex "+:PlugInstall" "+:q" "+:q"
ex "+:CocInstall coc-python coc-clangd coc-css coc-cssmodules coc-highlight coc-html coc-r-lsp coc-rls coc-snippets coc-spell-checker coc-sql coc-yaml coc-texlab" "+:q" "+:q"

drawline
drawline
tput setaf 6;echo "DONE!!! Change font in terminal to MesloLGS NF or use Kitty"
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
tput setaf 6;echo "Installing Required Packages and Adding Git Colours"; echo "texlive r-base cmake clangd lolcat gnupg ca-certificates npm kitty vim curl openssh-server openssh-client xclip wget git perl tilix tmux neofetch fonts-firacode dconf-cli ruby ruby-dev zsh python3 python3-pip python3-dev" 
drawline

apt install -y texlive curl lolcat cmake clangd r-base npm openssh-server openssh-client xclip wget git perl kitty vim tmux neofetch fonts-firacode dconf-cli ruby ruby-dev zsh python3 python3-pip python3-dev
git config --global color.ui auto

npm install -y npm -g 

drawline
tput setaf 6;echo "Installing Anaconda"
drawline
cd ..
wget https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh -O anaconda.sh
bash ./anaconda.sh -b -p .anaconda3
runuser -l $USERINVOKING -c "source ~/.anaconda3/bin/activate; conda init"

drawline
tput setaf 6;echo "Installing Colourful List Files"
drawline

gem install colorls

apt update -y && apt upgrade -y

drawline
tput setaf 6;echo "Installing Glances System Monitoring Tool and Addons"
drawline

pip3 install psutil 'glances[action,browser,cloud,cpuinfo,docker,export,folders,gpu,graph,ip,raid,snmp,web,wifi]' 






touch .zshrc
touch ~/.zshrc
chsh -s /usr/bin/zsh root
chsh -s /usr/bin/zsh $USERINVOKING
echo "alias shopt='/usr/bin/shopt'" >> .zshrc
echo "touch continue_install.txt; zsh ./config-files/install.sh $1; exit" >> .zshrc
usermod --shell /usr/bin/zsh $USERINVOKING
runuser -l $USERINVOKING -c "exec zsh"

rm continue_install.txt

fi

