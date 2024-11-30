Installation
------------
```
sudo apt update
sudo apt upgrade
sudo apt install curl

# Full install with errthang (default + i3wm, chrome, docker and other apps I use)
$ curl -LSs -H 'Cache-Control: no-cache' https://github.com/casonclagg/dotfiles-hyperfast/raw/master/setup | bash -s -- -f
```

Refreshing after changes
------------------------

    homeshick pull
    homeshick link
    mod + shift + c (refreshes i3)


Git Config
----------
Some standard configuration for git is included in `~/.gitconfig`
For your custom settings that wont be shared (like `name` and `email`) can be put in `~/.gitconfig_local` thusly:
```
[user]
    name = "Your Name"
    email = "your@email.com"
```


Local Files
-----------
There's a special local files folder somewhere secret! Use it after setup.


TODO
-----
1. Sound is absolute trash, not sure how to fix  
2. VirtualBox is broken and removed

    sudo ntfsfix /dev/nvmeXXXX