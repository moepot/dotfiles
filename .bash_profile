# some parts come from:
# https://github.com/geerlingguy/dotfiles/blob/master/.bash_profile


# add home-binary to path
export PATH=$HOME/bin:$PATH


# Nicer prompt.
#export PS1="\[\e[0;32m\]\]\[\] \[\e[1;32m\]\]\t \[\e[0;2m\]\]\w \[\e[0m\]\]\[$\] "

# Use colors.
#export CLICOLOR=1
#export LSCOLORS=ExFxCxDxBxegedabagacad

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
# Usage: dockrun, or dockrun [organization/image]
dockrun() {
  docker run -v "`pwd`:/media/volume/" -it "${1:-geerlingguy/docker-centos7-ansible}" /bin/bash
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

# Set default editor
export EDITOR=vi

# Makes new Dir and jumps inside
mcd () { mkdir -p "$1" && cd "$1"; }

# Moves a file to the MacOS trash
trash () { command mv "$@" ~/.Trash ; }

# Opens any file in MacOS Quicklook Preview
ql () { qlmanage -p "$*" >& /dev/null; }

# Print public facing IP address
alias myip='curl ifconfig.co'


# Ask for confirmation when 'prod' is in a command string.
#prod_command_trap () {
#  if [[ $BASH_COMMAND == *prod* ]]
#  then
#    read -p "Are you sure you want to run this command on prod [Y/n]? " -n 1 -r
#    if [[ $REPLY =~ ^[Yy]$ ]]
#    then
#      echo -e "\nRunning command \"$BASH_COMMAND\" \n"
#    else
#      echo -e "\nCommand was not run.\n"
#      return 1
#    fi
#  fi
#}
#shopt -s extdebug
#trap prod_command_trap DEBUG
# initializes a buildenv environment (mimacom)
buildenv() { curl -o- "https://raw.githubusercontent.com/mimacom/buildenv/master/init-docker-buildenv.sh?unique=$(uuidgen)" | /bin/bash }

# changes ansible vault password file
setvault() { ln -f -s ~/.ansible/vault_password_file.$1 ~/.ansible/vault_password_file }

# geoip lookip
geoip() { curl -o- https://ip-api.io/json/${1}\?api_key\=328585c4-dcbc-4c77-b1b2-442484a1ff8d | jq '.' }

export VAULT_PASSWORD=`cat ~/.ansible/vault_password_file`
export bamboo_VAULT_PASSWORD=`cat ~/.ansible/vault_password_file`
export bamboo_shortJobName="production"


# KUBERNETES
# see: https://github.com/kubernetes/website/issues/674

export KUBE_EDITOR="vim"
alias k8sdash='kubectl -n kube-system port-forward svc/kubernetes-dashboard 8080:80'
#alias kubedebug='kubectl run -it kubedebug --image=donch/net-tools --restart=Never --rm -- bash'
alias kubedebug='kubectl run -it kubedebug --image=centos:7 --restart=Never --rm -- bash'
#alias k8stoken="kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep eks-admin | awk '{print $1}') | grep token: | awk '{ print \$2 }'"
alias k8stoken="kubectl -n kube-system get secret -oname | grep eks-admin-token- | xargs kubectl -nkube-system describe | grep token: | awk '{ print \$2 }' | pbcopy"
alias kss-aws='kubeseal --token $(aws-iam-authenticator token -i kubernetes-infra | jq -r '.status.token') < '
alias kss='kubeseal --format=yaml'
alias wkgp='watch kubectl get pods -owide'


alias backup='restic -r s3:s3.amazonaws.com/backup-remowenger --exclude-file=.restic-exclude --verbose backup /Users/remo.wenger'
#terraform() { docker run -ti --rm -v "`pwd`:/media/volume/" hashicorp/terraform:0.11.13 terraform $* }

alias f='fluxctl --k8s-fwd-ns=infra-mgmt'
alias flog='klf -ninfra-mgmt $(kgp -ninfra-mgmt -l"app=flux" -oname)'
alias fhlog='klf -ninfra-mgmt $(kgp -ninfra-mgmt -l"app=flux-helm-operator" -oname)'


# GOLANG
export GOPATH=$HOME/Documents/go


# LANGUAGE SETTINGS
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
