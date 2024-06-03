# edge.repo
demo apt repository for edge

run the shell script to install any application present in the repo like:

```bash
sudo addRepo.sh 

```

you can get the shell script like:

```bash
wget https://raw.githubusercontent.com/redxa-edge/debpackages/main/addRepo.sh
```

befroe runnig the script we need to set the priority this is optinal if you want to prefer this repo packages over others.

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
