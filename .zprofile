# # Order; if ZDOTDIR is unset, HOME is used instead:
# 1. /etc/zshenv
# 2. $ZDOTDIR/.zshenv
# 3. (login) /etc/zprofile
# 4. (login) $ZDOTDIR/.zprofile
# 5. (interactive) /etc/zshrc
# 6. (interactive) $ZDOTDIR/.zshrc
# 7. (login) /etc/zlogin
# 8. (login) $ZDOTDIR/.zlogin
# [logout]
# 1. $ZDOTDIR/.zlogout
# 2. /etc/zlogout

# export SSH_ASKPASS="/usr/libexec/ssh-askpass"

# if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
#     . /opt/local/etc/profile.d/bash_completion.sh
# fi

# HOSTNAME=`hostname`
export HOSTNAME="Sail"

# To add: security add-generic-password -a "$USER" -s 'Homebrew GitHub Token' -w  # either token goes here, or leave blank and get security prompt
# export HOMEBREW_GITHUB_API_TOKEN=$(security find-generic-password -s 'Homebrew GitHub Token' -w)
# OSX only.

export HAKIRI_AUTH_TOKEN=$(security find-generic-password -s 'Hakiri Auth Token' -w)
export MUCKROCK_TOKEN=$(security find-generic-password -s 'Muckrock Auth Token' -w)

export DYLD_LIBRARY_PATH=/usr/local/mysql/lib/:$DYLD_LIBRARY_PATH

export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# brew stuff
export PATH="/usr/local/opt/apr-util/bin:$PATH"
export PATH="/usr/local/opt/apr/bin:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/e2fsprogs/bin:$PATH"
export PATH="/usr/local/opt/e2fsprogs/sbin:$PATH"
export PATH="/usr/local/opt/gettext/bin:$PATH"
export PATH="/usr/local/opt/gnu-getopt/bin:$PATH"
export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/icu4c/sbin:$PATH"
export MANPATH="/usr/local/opt/inetutils/libexec/gnuman:$MANPATH"
export PATH="/usr/local/opt/inetutils/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/libpq/bin:$PATH"
export PATH="/usr/local/opt/libxml2/bin:$PATH"
export PATH="/usr/local/opt/libxslt/bin:$PATH"
export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="/usr/local/opt/sqlite/bin:$PATH"

# export PATH="/usr/local/mysql/bin:$PATH"
# export PATH="/usr/local/git/bin:$PATH"

export PATH="/Users/saizai/Downloads/apps/android/platform-tools/:$PATH"
# /Users/saizai/Dropbox/android/sdk/tools:/Users/saizai/Dropbox/android/sdk/platform-tools
# export PATH=/opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin:$PATH

export PATH="/usr/local/opt/llvm/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib"
export CPPFLAGS="-I/usr/local/opt/llvm/include"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/saizai/src/google-cloud-sdk/path.bash.inc' ]; then . '/Users/saizai/src/google-cloud-sdk/path.bash.inc'; fi
# source /Users/saizai/src/google-cloud-sdk/path.bash.inc

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# export PATH="/Users/saizai/.rvm/gems/default/bin:$PATH"

# if [ -f ~/.bashrc ]; then source ~/.bashrc ; fi
