#/usr/bin/bash
alreadyInstalled=false
installation=false
uninstallation=false
PREFIX=/data/data/com.termux/files/usr
packages=()

function validateUsr() {
  pathOfCurrentDir=$(pwd)
  if [[ $pathOfCurrentDir == *'com.termux'* ]]; then
    :
  else
    printf "Your system is not compatible for this repository!\n"; exit 1
  fi
}
function checkAlreadyInstalled() {
  if [[ -f $PREFIX/etc/apt/sources.list.d/edge.repo.list ]]; then
    alreadyInstalled=true
  else
    alreadyInstalled=false
  fi
}
function installRepository() {
  if [[ ! -d $PREFIX/etc/apt/sources.list.d ]]; then
    mkdir -p $PREFIX/etc/apt/sources.list.d
  fi
  echo "deb [trusted=yes] https://redxa-edge.github.io/edge.repo/ edge main" >$PREFIX/etc/apt/sources.list.d/edge.repo.list
  rm -rf public.key >/dev/null 2>&1
  wget -q https://raw.githubusercontent.com/BHUTUU/edge.repo/main/public.key
  apt-key add public.key
  cp -r $PREFIX/etc/apt/trusted.gpg~ $PREFIX/etc/apt/trusted.gpg.d/edge.gpg
  apt-get update -yq --silent
  printf "Installation successful\n"
}
function removeRepository() {
  rm -rf $PREFIX/etc/apt/sources.list.d/edge.repo.list >/dev/null 2>&1
  printf "Removing successful!\n"
}

#<<<<----Main section---->>>
while true; do
  args=$1
  if [[ ! -z $args ]]; then
    case $args in
      -i|--install) installation=true;;
      -r|--remove) uninstallation=true;;
      -*|--*) printf "Invalid argument: $args\n"; exit 1;;
      *) packages+=($args);;
    esac
    shift
  else
    break
  fi
done
validateUsr
if [[ $installation == true ]]; then
  if [[ $uninstallation == true ]]; then
    printf "Dont use both of -i and -r argunment\n"
    exit 1
  fi
  checkAlreadyInstalled
  if [[ $alreadyInstalled == true ]]; then
    printf " Repository is already installed\n"; exit 0
  else
    installRepository
  fi
fi

if [[ $uninstallation == true ]]; then
  checkAlreadyInstalled
  if [[ $alreadyInstalled == true ]]; then
    removeRepository
  else
    printf "Repository not found to remove\n"; exit 1
  fi
fi

if [[ ! -z $packages ]]; then
  for i in ${packages[@]}; do
    apt install $i -y
  done
fi
