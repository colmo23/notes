# Sample go project setup

1. Install RHEL version of go:
```
sudo yum install golang -y
```


2. Create workspace directory, eg:
```
mkdir /home/colm/go
```

3. Set GOPATH env variable to that directory, eg
```
export GOPATH=/home/colm/go
```

4. Go to workspace directory
```
cd $GOPATH
```

5. Create go src directory
```
mkdir src
mkdir src/github.com/colmo23
```

5. Go cd src directory and clone repo into it
```
cd src/
git clone gitlab@github.com:colmo23/myproject.git
```

6. Install library dependencies (the 2nd command will take about 1 minutes to run - it may also print some warnings)
```
cd $GOPATH
go get ./...
```

7. Run scripts from $GOPATH directory:
```
cd $GOPATH
go run src/github.com/colmo23/test.go -h
```





# VIM golang steps

Install go libraries for vim if you want to edit source files.


1. Install vim-go
```
sudo yum install vim-go -y
```

2. Configure vim-go
2.1 Add the following to ~/.vimrc
```
set nocompatible
set shell=/bin/sh
syntax on
filetype plugin on
let g:go_disable_autoinstall = 0
```

2.2 Load vim-go dependencies
Start vim and run the following vim command (it will take about a minute to run)
```
:GoInstallBinaries
```

2.3 Update path for vim-go dependencies
```
export PATH=$PATH:$GOPATH/bin
```




