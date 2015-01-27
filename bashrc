# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

for profile in `ls $HOME/.profile.d/*`; do
  . $profile
done
