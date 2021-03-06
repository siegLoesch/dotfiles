# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000
export HISTCONTROL=ignoreboth:erasedups

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

get_PS1(){
  # ${1:-default} means "if input parameter 1 is unset or empty, then use 
  # default instead".
  limit=${1:-$(/usr/bin/tput cols)}
  # ${#PWD} ... number of elements (characters) in PWD
  if [[ "${#PWD}" -gt "$limit" ]]; then
    # Get the last $limit characters of $PWD.
    right="${PWD:$((${#PWD}-$limit+5)):${#PWD}}"
    if [[ $EUID -ne 0 ]]; then
      PS1="\[\033[0;32m\][...${right}]\n\[\033[1;36m\]\A> \[\033[0m\]"
    else
      PS1="\[\033[0;32m\][...${right}]\n\[\033[1;36m\]su-> \[\033[0m\]"
      ## PS1="[\[\033[32m\]\w]\[\033[0m\]\n\[\033[1;36m\]su-> \[\033[0m\]"
    fi
  else
    if [[ $EUID -ne 0 ]]; then
      PS1="[\[\033[32m\]\w]\[\033[0m\]\n\[\033[1;36m\]\A> \[\033[0m\]"
    else
      PS1="[\[\033[32m\]\w]\[\033[0m\]\n\[\033[1;36m\]su-> \[\033[0m\]"
    fi
  fi
}
PROMPT_COMMAND=get_PS1
unset color_prompt force_color_prompt

# Now we can set the title of the terminal with terminal_title my title
function terminal_title ()
{
    export THIS_TERMINAL_TITLE="$@"
}
# Here's a good default
export THIS_TERMINAL_TITLE="$USER@$HOSTNAME"

# enable color support of ls and also add handy aliases
alias ls='ls --color=auto'
#alias dir='dir --color=auto'
#alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
#alias fgrep='fgrep --color=auto'
#alias egrep='egrep --color=auto'

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# cd up to n dirs
# using:  cd.. 10   cd.. dir
function cd_up() {
  case $1 in
    *[!0-9]*)                                      # if no a number
      cd $( pwd | sed -r "s|(.*/$1[^/]*/).*|\1|" ) # search dir_name in current 
                                                   # path, if found - cd to it
      ;;                                           # if not found - not cd
    *)
      cd $(printf "%0.0s../" $(seq 1 $1));         # cd ../../../../  (N dirs)
    ;;
  esac
}
# alias 'cd'='cd -P'                               # follow symbolic links real
alias 'cd..'='cd_up'                             # can not name function 'cd..'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# root ssh
alias ssr='ssh -X root@$HOSTNAME'

# OpenFOAM 4.0
#nux-gnu/source /home/loesch/OpenFOAM/OpenFOAM-plus/etc/bashrc
#alias of40="export QT_SELECT="5" && source /opt/OpenFOAM/OpenFOAM-4.0/etc/bashrc && PS1='\[\e[1;31m\][4.0]\[\e[0m\]\[\e[1;32m\][$(tty | cut -d/ -f3,4)]\[\e[0m\][\W]\[\e[1;31m\]:\[\e[0m\] ' "

# foam-extend-3.2
#alias fe32="export PATH=/opt/foam/foam-extend-3.2/ThirdParty/rpmBuild/BUILD/swak4Foam-0.3.2/privateRequirements/bin:$PATH && export QT_SELECT="5" && source /opt/foam/foam-extend-3.2/etc/bashrc && PS1='\[\e[1;31m\][3.2]\[\e[0m\]\[\e[1;32m\][$(tty | cut -d/ -f3,4)]\[\e[0m\][\W]\[\e[1;31m\]:\[\e[0m\] ' "

# codeblocks svn
alias CB='/opt/codeblocks_svn/bin/codeblocks'

# SLO, 20180601
export ELMER_HOME=/opt/elmer
LD_LIBRARY_PATH=$ELMER_HOME/lib:$LD_LIBRARY_PATH

# preCICE
export PRECICE_ROOT="/home/loesch/Install/preCISE/precice"

# Dolfin
if [[ -f /usr/share/dolfin/dolfin.conf ]]; then
	source /usr/share/dolfin/dolfin.conf
fi

# Miniconda
# export PATH=/home/loesch/miniconda3/bin:$PATH

DEBEMAIL="Siegfried.Loesch@gmx.at"
DEBFULLNAME="Siegfried Loesch"
export DEBEMAIL DEBFULLNAME

# Neovim
alias vim="/opt/usr/bin/nvim"
alias g-v="$HOME/Install/Neovim/neovide/target/release/neovide"
export SYSTEMD_EDITOR=/opt/usr/bin/nvim
export EDITOR=/opt/usr/bin/nvim
export VISUAL=/opt/usr/bin/nvim

# mc related
### export HISTCONTROL=ignoreboth
### . /usr/lib/mc/mc.sh

# quilt
_completion_loader quilt
alias dquilt="quilt --quiltrc=${HOME}/.quiltrc-dpkg"
complete -F _quilt_completion -o filenames dquilt
#complete -F _quilt_completion $_quilt_complete_opt dquilt

# Check for WSL
unameStr=$(uname -r)

# Lua 5.1
if [[ "$unameStr" == *"microsoft"* ]]; then
  export LUA_PATH='/usr/share/lua/5.1/?.lua;/usr/share/lua/5.1/?/init.lua;/usr/lib/lua/5.1/?.lua;/usr/lib/lua/5.1/?/init.lua;./?.lua;./?/init.lua;;'
  export LUA_CPATH='/usr/lib/lua/5.1/?.so;/usr/lib/lua/5.1/loadall.so;./?.so;/usr/lib/x86_64-linux-gnu/lua/5.1/?.so'
fi
##SLO-20201122 else
  ##SLO-20201122 export LUA_PATH='/usr/share/lua/5.1/?.lua;/usr/share/lua/5.1/?/init.lua;/usr/lib/lua/5.1/?.lua;/usr/lib/lua/5.1/?/init.lua;./?.lua;./?/init.lua;;'
  ##SLO-20201122 export LUA_CPATH='/usr/lib/lua/5.1/?.so;/usr/lib/lua/5.1/loadall.so;./?.so;/home/loesch/.luarocks/lib/lua/5.1/?.so'
##SLO-20201122 fi

#### ruby --version | perl -pe '($_)=/([0-9]+([.][0-9]+)+)/'
if [[ "$unameStr" == *"microsoft"* ]]; then
  # Here we are running windows subsystem for linux at workplace
  # Proxy servers for curl
  # export http_proxy=http://u13m72:benjamin%26Valentin7@squid.avl01.avlcorp.lan:8080
  # export https_proxy=http://u13m72:benjamin%26Valentin7@squid.avl01.avlcorp.lan:8080
  export http_proxy=http://u13m72:benjamin%26Valentin7@10.12.100.13:8080
  export https_proxy=http://u13m72:benjamin%26Valentin7@10.12.100.13:8080
  # add path to local user installed modules
  PATH=/opt/usr/bin:$HOME/.local/bin:$HOME/node_modules/bin:$HOME/.gem/ruby/2.7.0/bin:$HOME/bin:$HOME/usr/bin:$ELMER_HOME/bin:$PATH
  export PATH
else
  # add path to local user installed modules
  PATH=/opt/usr/bin:$HOME/node_modules/bin:$HOME/.gem/ruby/2.7.0/bin:$HOME/bin:$HOME/usr/bin:$ELMER_HOME/bin:$HOME/Install/Neovim/neovide/target/release:$PATH
  export PATH
fi

# Perl
## eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)"

# Check if graphic card 'R9 270X' is present. In that case special environment
# has to be set for functional 'opencl'.
lspciStr=$(lspci)                                                               
graphicCardStr='R9 270X'                                                        
if [[ "$lspciStr" == *"$graphicCardStr"* ]]; then
	export GPU_FORCE_64BIT_PTR=1
	export GPU_USE_SYNC_OBJECTS=1
	export GPU_MAX_ALLOC_PERCENT=100
	export GPU_SINGLE_ALLOC_PERCENT=100
	export GPU_MAX_HEAP_SIZE=100
fi

# Clang
if [[ "$unameStr" == *"debian"* ]]; then
	source /usr/lib/llvm-10/share/clang/bash-autocomplete.sh
elif [[ "$unameStr" == *"arch"* ]]; then
	source /usr/share/clang/bash-autocomplete.sh
fi

# Environment modules (/etc/profile.d/modules.sh seems not to work on Buster)
# source /usr/share/modules/init/bash

# os-release
read osRelease < /etc/os-release
osReleaseA=${osRelease#*NAME='"'}
osNameA=${osReleaseA%% *}
osReleaseB=${osRelease#*'('}
osNameB=${osReleaseB%%')'*}

# OS specific path definitions and sources
if [[ "$OSTYPE" == "linux-gnu" ]]; then
	# printf "OSTYPE detected: %s\n" $OSTYPE
	case $osNameA in
		"Debian")
			if [[ "$unameStr" == *"microsoft"* ]]; then
				export PATH=/opt/Salome-9.6.0-DebNative:$PATH
				source /opt/Salome-9.6.0-DebNative/salomeTools/complete_sat.sh
			elif [[ "$osNameB" == *"buster"* ]]; then
				export PATH=/home/loesch/Install/Salome/Salome-Dev:$PATH
				export PATH=/home/loesch/.local/bin:$PATH
				source /home/loesch/Install/Salome/Salome-Dev/salomeToolsDev/complete_sat.sh
				export PATH=/usr/local/sbin:$PATH
				export PATH=/usr/sbin:$PATH
				export PATH=/sbin:$PATH
			else
				export PATH=$HOME/Install/Salome/Salome_960/Salome-9.6.0-Debian:$PATH
				source /home/loesch/Install/Salome/Salome_960/Salome-9.6.0-Debian/salomeTools/complete_sat.sh
			fi
			;;
		# TODO: Check if arch-linux name specifier is correct
		# "Arch") export PATH=$HOME/Install/Salome/Salome_960/Salome-9.6.0-Arch:$PATH
			# source /home/loesch/Install/Salome/Salome_960/Salome-9.6.0-Arch/salomeTools/complete_sat.sh
		"Arch") export PATH=$HOME/Install/Salome/Salome_960/SALOME-9.6.0-MPI-CO7-SRC:$PATH
			source /home/loesch/Install/Salome/Salome_960/SALOME-9.6.0-MPI-CO7-SRC/salomeTools/complete_sat.sh
			;;
		*) printf "Could not assign salomeTools sat to any os type\n";;
	esac
fi

# pyenv
# eval "$(pyenv init -)"

# File header template environment variables
export Full_Name="Siegfried Loesch"

# Add path for example bash scripts
export PATH=$HOME/bin/bashScripts:$PATH

# Code saturne
if [[ -d /opt/code_saturne-930 ]]; then
	alias code_saturne="/opt/code_saturne/bin/code_saturne"
	alias salome_cfd="/opt/code_saturne/bin/salome_cfd"
	source /opt/code_saturne-930/etc/bash_completion.d/code_saturne
fi

# Nvidia HPC SDK
## if [[ -d /opt/nvidia/hpc_sdk/Linux_x86_64/21.1 ]]; then
## 	NVARCH=`uname -s`_`uname -m`; export NVARCH
## 	NVCOMPILERS=/opt/nvidia/hpc_sdk; export NVCOMPILERS
## 	MANPATH=$MANPATH:$NVCOMPILERS/$NVARCH/21.1/compilers/man; export MANPATH
## 	PATH=$NVCOMPILERS/$NVARCH/21.1/compilers/bin:$PATH; export PATH
## 	export LD_LIBRARY_PATH=/opt/nvidia/hpc_sdk/Linux_x86_64/21.1/compilers/lib:$LD_LIBRARY_PATH
## 	# nvOpenMPI
## 	export PATH=$NVCOMPILERS/$NVARCH/21.1/comm_libs/mpi/bin:$PATH
## 	export MANPATH=$MANPATH:$NVCOMPILERS/$NVARCH/21.1/comm_libs/mpi/man
## 	# Libraries
## fi
# Nvidia MDL-SDK
if [[ -d /opt/nvidia/mdl-sdk ]]; then
	export PATH=/opt/nvidia/mdl-sdk/bin:$PATH
	export LD_LIBRARY_PATH=/opt/nvidia/mdl-sdk/lib:$LD_LIBRARY_PATH
fi

# Configure dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
