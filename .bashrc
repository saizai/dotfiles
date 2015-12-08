[[ -s "/Users/saizai/.rvm/scripts/rvm" ]] && source "/Users/saizai/.rvm/scripts/rvm"  # This loads RVM into a shell session.

export PATH=/opt/local/bin:/opt/local/sbin:/Users/saizai/Dropbox/android/sdk/tools:/Users/saizai/Dropbox/android/sdk/platform-tools:/usr/local/mysql/bin:$PATH
export DYLD_LIBRARY_PATH=/usr/local/mysql/lib/:$DYLD_LIBRARY_PATH

alias bigfiles="du -m * | egrep $'[0-9]{3,}\t' | sort -n"
alias moshdh='mosh --server="LD_LIBRARY_PATH=/home/saizai1/lib /home/saizai1/bin/mosh-server" saizai1@saizai.com'
alias moshlocal='mosh --server="LD_LIBRARY_PATH=~/lib ~/bin/mosh-server"'

alias rmate_tunnels='ssh -CfNqR 52698:localhost:52698 makeyourlaws.org && ssh -CfNqR 52698:localhost:52698 root@mdtem.com'

export GIT_EDITOR="mate --name 'Git Commit Message' -w -l 1"
export EDITOR="mate"
export SSH_ASKPASS="/usr/libexec/ssh-askpass"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting


if [ -f ~/.keychain/${HOSTNAME}-sh  ]; then
     source ~/.keychain/${HOSTNAME}-sh
fi

if [ -f ~/.keychain/${HOSTNAME}-sh-gpg  ]; then
     source ~/.keychain/${HOSTNAME}-sh-gpg
fi