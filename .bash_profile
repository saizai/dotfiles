export SSH_ASKPASS="/usr/libexec/ssh-askpass"

#---------------------
# SSH Keychain
#----------------------
 
# keys to use
CERTFILES="sai-3ko"
 
# find the keychain script
KEYCHAIN=
[ -x /usr/bin/keychain  ] && KEYCHAIN=/usr/bin/keychain
[ -x /usr/local/bin/keychain  ] && KEYCHAIN=/usr/local/bin/keychain
[ -x ~/usr/bin/keychain  ] && KEYCHAIN=~/usr/bin/keychain
[ -x ~/bin/keychain  ] && KEYCHAIN=~/bin/keychain
 
HOSTNAME=`hostname`
if [ -n $KEYCHAIN ] ; then
    # If there's already a ssh-agent running, then we know we're on a desktop or laptop (i.e. a client),
	# so we should run keychain so that we can set up our keys, please.

	if [ ! "" = "$SSH_AGENT_PID" ]; then
		echo "Keychain: SSH_AGENT_PID is set, so running keychain to load keys."
		$KEYCHAIN $CERTFILES && source ~/.keychain/$HOSTNAME-sh && source ~/.keychain/$HOSTNAME-sh-gpg

	# Else no ssh-agent configured
    else     
		#  Offer to run keychain only if no SSH_AUTH_SOCK is set, and
		# only if we aren't at the end of a ssh connection with agent
		# forwarding enabled (since then we won't need ssh-agent here anyway)
		if [ -z $SSH_AUTH_SOCK ]; then
			echo "Keychain: Found no SSH_AUTH_SOCK, so running keychain to start ssh-agent & load keys."
			$KEYCHAIN $CERTFILES && source ~/.keychain/$HOSTNAME-sh && source ~/.keychain/$HOSTNAME-sh-gpg
		fi
	fi
fi
unset CERTFILES KEYCHAIN

if [ -f ~/.bashrc ]; then source ~/.bashrc ; fi
