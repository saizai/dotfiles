alias bigfiles="du -m * | egrep $'[0-9]{3,}\t' | sort -n"
alias moshdh='mosh --server="LD_LIBRARY_PATH=/home/saizai1/lib /home/saizai1/bin/mosh-server" saizai1@saizai.com'
alias moshlocal='mosh --server="LD_LIBRARY_PATH=~/lib ~/bin/mosh-server"'

alias git_prune="git branch -r --merged | grep -v master | sed 's/origin\///' | xargs -n 1 git push --delete origin"
# alias git_prune='git branch --merged | grep -v "\*" | xargs -n 1 git branch -d'

alias ls="ls --color --almost-all --author --escape --classify --group-directories-first --human-readable  --hyperlink=auto --quoting-style=shell-escape --time-style=full-iso"

export GIT_EDITOR="atom --name 'Git Commit Message' -w -l 1"
export EDITOR="mate"
export SSH_ASKPASS="/usr/local/bin/ssh-askpass"

# per man gpg-agent
GPG_TTY=$(tty)
export GPG_TTY

# https://spaces.seas.harvard.edu/display/USERDOCS/Storing+Your+Keys+-+SSH-Agent,+Agent+Forwarding,+and+Keychain
#---------------------
# SSH Keychain
#----------------------

# keys to use
SSHFILES="/Users/saizai/.ssh/sai_new_ssh CEC0B77B09160904"

# find the keychain script
KEYCHAIN=
[ -x /usr/bin/keychain  ] && KEYCHAIN=/usr/bin/keychain
[ -x /usr/local/bin/keychain  ] && KEYCHAIN=/usr/local/bin/keychain
[ -x ~/usr/bin/keychain  ] && KEYCHAIN=~/usr/bin/keychain
[ -x ~/bin/keychain  ] && KEYCHAIN=~/bin/keychain

if [ -n $KEYCHAIN ] ; then
    # If there's already a ssh-agent running, then we know we're on a desktop or laptop (i.e. a client),
	# so we should run keychain so that we can set up our keys, please.

	if [ ! "" = "$SSH_AGENT_PID" ]; then
		echo "Keychain: SSH_AGENT_PID is set, so running keychain to load keys."
		$KEYCHAIN --host $HOSTNAME --agents "ssh,gpg" $CERTFILES
    if [ -f ~/.keychain/$HOSTNAME-sh ]; then source ~/.keychain/$HOSTNAME-sh ; fi
    if [ -f ~/.keychain/$HOSTNAME-sh-gpg ]; then source ~/.keychain/$HOSTNAME-sh-gpg ; fi

	# Else no ssh-agent configured
  else
		#  Offer to run keychain only if no SSH_AUTH_SOCK is set, and
		# only if we aren't at the end of a ssh connection with agent
		# forwarding enabled (since then we won't need ssh-agent here anyway)
		if [ -z $SSH_AUTH_SOCK ]; then
			echo "Keychain: Found no SSH_AUTH_SOCK, so running keychain to start ssh-agent & load keys."
  		$KEYCHAIN --host $HOSTNAME --agents "ssh,gpg" $CERTFILES
      if [ -f ~/.keychain/$HOSTNAME-sh ]; then source ~/.keychain/$HOSTNAME-sh ; fi
      if [ -f ~/.keychain/$HOSTNAME-sh-gpg ]; then source ~/.keychain/$HOSTNAME-sh-gpg ; fi
		fi
	fi
fi
unset CERTFILES KEYCHAIN

if [ -f ~/.keychain/$HOSTNAME-sh ]; then source ~/.keychain/$HOSTNAME-sh ; fi
if [ -f ~/.keychain/$HOSTNAME-sh-gpg ]; then source ~/.keychain/$HOSTNAME-sh-gpg ; fi

# Various shell completions
test -e ${HOME}/.iterm2_shell_integration.bash && source ${HOME}/.iterm2_shell_integration.bash
source /Users/saizai/src/google-cloud-sdk/completion.bash.inc
if [ -f '/Users/saizai/src/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/saizai/src/google-cloud-sdk/completion.bash.inc'; fi
# added by travis gem
[ -f /Users/saizai/.travis/travis.sh ] && source /Users/saizai/.travis/travis.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pip bash completion start
_pip_completion()
{
    COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
                   COMP_CWORD=$COMP_CWORD \
                   PIP_AUTO_COMPLETE=1 $1 ) )
}
complete -o default -F _pip_completion pip
# pip bash completion end

[ -s "/Users/saizai/.rvm/scripts/extras/completion.bash" ] && \. "/Users/saizai/.rvm/scripts/extras/completion.bash"
[[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion

# cf http://vvv.tobiassjosten.net/bash/dynamic-prompt-with-git-and-ansi-colors/
# and https://gist.github.com/tobiassjosten/828432

# Configure colors, if available.
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    c_reset='\[\e[0m\]'
    c_user='\[\e[0;32m\]'
    c_path='\[\e[1;34m\]'
    c_git_clean='\[\e[0;37m\]'
    c_git_staged='\[\e[0;32m\]'
    c_git_unstaged='\[\e[0;31m\]'
else
    c_reset=
    c_user=
    c_path=
    c_git_clean=
    c_git_staged=
    c_git_unstaged=
fi

# Add the titlebar information when it is supported.
case $TERM in
xterm*|rxvt*)
    TITLEBAR='\[\e]0;\u@\h: \w\a\]';
    ;;
*)
    TITLEBAR="";
    ;;
esac

# Function to assemble the Git parsingart of our prompt.
git_prompt ()
{
    GIT_DIR=`git rev-parse --git-dir 2>/dev/null`
    if [ -z "$GIT_DIR" ]; then
        return 0
    fi
    GIT_HEAD=`cat "$GIT_DIR/HEAD"`
    GIT_BRANCH=${GIT_HEAD##*/}
    if [ ${#GIT_BRANCH} -eq 40 ]; then
        GIT_BRANCH="(no branch)"
    fi
    STATUS=`git status --porcelain`
    if [ -z "$STATUS" ]; then
        git_color="${c_git_clean}"
    else
        echo -e "$STATUS" | grep -q '^ [A-Z\?]'
        if [ $? -eq 0 ]; then
            git_color="${c_git_unstaged}"
        else
            git_color="${c_git_staged}"
        fi
    fi
    echo "[$git_color$GIT_BRANCH$c_reset]"
}

# Thy holy prompt.
PROMPT_COMMAND="$PROMPT_COMMAND PS1=\"${TITLEBAR}${c_user}\u${c_reset}@${c_user}\h${c_reset}:${c_path}\w${c_reset}\$(git_prompt)\$ \" ;"

POWERLINE_REPO="$HOME/src/powerline"
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. $POWERLINE_REPO/powerline/bindings/bash/powerline.sh

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
