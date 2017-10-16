# some parts come from:
# https://github.com/geerlingguy/dotfiles/blob/master/.bash_profile


# Nicer prompt.
export PS1="\[\e[0;32m\]\]\[\] \[\e[1;32m\]\]\t \[\e[0;2m\]\]\w \[\e[0m\]\]\[$\] "

# Use colors.
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# Include alias file (if present) containing aliases for ssh, etc.
if [ -f ~/.bash_aliases ]
then
  source ~/.bash_aliases
fi


# Include bashrc file (if present).
if [ -f ~/.bashrc ]
then
  source ~/.bashrc
fi


# Super useful Docker container oneshots.
# Usage: dockrun, or dockrun [centos7|fedora24|debian8|ubuntu1404|etc.]
dockrun() {
  docker run -it geerlingguy/docker-"${1:-centos7}"-ansible /bin/bash
}


# Enter a running Docker container.
function denter() {
  if [[ ! "$1" ]] ; then
      echo "You must supply a container ID or name."
      return 0
  fi

  docker exec -it $1 bash
  return 0
}

# Delete a given line number in the known_hosts file.
knownrm() {
  re='^[0-9]+$'
  if ! [[ $1 =~ $re ]] ; then
    echo "error: line number missing" >&2;
  else
    sed -i '' "$1d" ~/.ssh/known_hosts
  fi
}


# Ask for confirmation when 'prod' is in a command string.
prod_command_trap () {
  if [[ $BASH_COMMAND == *prod* ]]
  then
    read -p "Are you sure you want to run this command on prod [Y/n]? " -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
      echo -e "\nRunning command \"$BASH_COMMAND\" \n"
    else
      echo -e "\nCommand was not run.\n"
      return 1
    fi
  fi
}
shopt -s extdebug
trap prod_command_trap DEBUG


