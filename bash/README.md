
# Links


* [minimal-safe-bash-script-template](https://betterdev.blog/minimal-safe-bash-script-template/)
* [minimal-safe-bash-script-template Hacker news discussion](https://news.ycombinator.com/item?id=25428621)


# Linter

* [Shell check](https://www.shellcheck.net/)



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
