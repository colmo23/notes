
# Links


* [minimal-safe-bash-script-template](https://betterdev.blog/minimal-safe-bash-script-template/)
* [minimal-safe-bash-script-template Hacker news discussion](https://news.ycombinator.com/item?id=25428621)


# Linter

* [Shell check](https://www.shellcheck.net/)


# Note from "How Linux works" book
Note that * is the same as $(ls), eg the following populates files variable with directory contents:
files=*

Use single quotes to escape $variable and globs
Use double quotes to only escape globs

First argument: $1
Second argument: $2
Number of arguments: $#
All arguments: $@
Program name: $0
Process id: $$
Last exit code: $?

The [ character means test. Hence you need to put the space after it in if statements as follows:
```
if [ "$1" = 'hi' ]; then
  echo "first argument is 'hi'"
else
  echo "first argument is not 'hi'"
fi
```
Note to quote the $1 so that it will expand to empty string if it does not exist

Handling errors use || as an "OR":
```
ls /kjkj || echo "Directory /kjkj does not exist"
```
Handling success case use && as an "AND":
```
ls /kjkj && echo "Directory /kjkj does exist"
```

Testing conditionals:
-f regular file
-d directory
-h link
-r readable
-w writable
-x executable
-z empty string
-n not empty string
eg
```
if [ -d "/tmp/" ]; then
   echo "/tmp directory exists"
fi
if [ -z "$file" ]; then
   echo '$file is empty'
fi

for loop
```
for file in $(ls); do
  echo "file is $file"
done
```
while:
```
myvar=""
while [ -z $myvar ]; do
  myvar="here"
done
```
case
```
case $f in
   fpu)  MSG="value is fpu"
         ;;
   *)    MSG="value is unknown"
         ;; 
esac
echo "$f: $MSG"
```
Here document
```
long_string=$(cat <<EOF
line 1
line 2
EOF
)
echo "$long_string"
```
aws - get 5th word from line, eg file size from ls:
```
ls -l | awk '{print $5}'
```
Subshells - define temporary variable or cd into directory to run a command:
```
(cd some-dir; ./some-file.sh)
```



# Misc
## bashrc samples
pipe output of tshark over a network into a local wireshark:
```
wireshark -k -i <(ssh adaptive@10.10.12.100 "sudo tshark -i any -w - sctp")
```

## ripgrep
```
# Find all python files where I used the requests library
rg -t py 'import requests'
# Find all files (including hidden files) without a shebang line
rg -u --files-without-match "^#!"
# Find all matches of foo and print the following 5 lines
rg foo -A 5
# Print statistics of matches (# of matched lines and files )
rg --stats PATTERN
```


## Log file summarise
Strip out all number. Sort by count
```
cat file.log | sed 's/[0-9]//g' | sort | uniq -c | sort -nr
```
## grep commands:

grep regex /var/log/logfile -A5 #To view the next 5 lines
grep regex /var/log/logfile -B5 #To view the previous 5 lines
grep regex /var/log/logfile -05 #To view the 5 lines before *and* after the match
grep regex /var/log/logfile -05 #To view the 5 lines before *and* after the match

Exclude multiple things from a file
egrep -v 'THING1|THING2|THING3|THING4' file
