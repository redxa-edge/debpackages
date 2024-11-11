# edge.repo




## to add a new repo  only first time.

before adding a new repo we need to setup GPG keys for security  on the machine which is going to update the packages to the computer.


### process to generate and use gpg keys.

#### to generate GPG keys..

to generate GPG keys do 

```bash
gpg --full-generate-key
```

chose  (1) RSA and RSA (default) option

add required name and email.

there they will ask to enter  pass phrase  remember the pass phrase as it will be used to sign The release file .

once the GPG key is generated we need to export a public key .


to get the private key
```bash
gpg --export-secret-key -a "abhisheksatyam123@gmail.com" > private.key
```

to get the public key

```bash
gpg --export -a "abhisheksatyam123@gmail.com" > public.key
```

the public key we need to upload to the repo. which is same name as public.key



## adding a new package and signing the Release file (everytime when you need to add a new package)

- create a new folder say home 
- add new folder in home say packagedir 
- add python file deb-apt-repo.py in home folder
- clone the repo in same home folder say  its cloned as debpackage.
```bash
git clone git@github.com:redxa-edge/debpackages.git
```
- copy the public key to cloned debpackage

- then run the python script to create the repo folder say debpackage and bullseye is distro and main is the branch name 

```bash
python deb-apt-repo.py packagedir debpackages bullseye main
```

- now go to debpackage/dist/bullseye here you will find a  Release file.
- sign the release file using 

```bash
gpg --clear-sign Release
```
rename the output file as Inrelease

```bash
 mv Release.asc InRelease
```

enter the same passphrase

- now you can copy newly created 


####
demo apt repository for edge 

run the shell script to install any application present in the repo like:

```bash
sudo addRepo.sh 

```

you can get the shell script like:

```bash
wget https://raw.githubusercontent.com/redxa-edge/debpackages/main/addRepo.sh
```

before runnig the script we need to set the priority this is optinal if you want to prefer this repo packages over others.

```bash
sudo vi /etc/apt/preferences.d/redxa-repo.pref
```

then add

```bash
Package: *
Pin: origin "redxa-edge.github.io"
Pin-Priority: 700
```

then update using

```bash
sudo apt update
```

to check install a available..

```bash
sudo apt install blueman
```
