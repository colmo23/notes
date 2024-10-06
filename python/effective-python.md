# 10 - use assignment expressions


```
if (count := fresh_fruit.get('banana', 0)) >= 2:
 pieces = slice_bananas(count)
else:
 pieces = 0
```
# 13 -unpacking a list using a starred expression                     
                                                                  
```                                                               
l = [1,2,3,4,5]                                                   
first, seconds, *others = l                                       
o
```                                                               

# 14 - sort by complex criteria using key
f you have a list of objects then you can sort them using "key" argument to sort

```
power_tools.sort(key=lambda x: x.name)
```

# 16 - prefer get for dictionries
Use get to return value or a default if it does not exist:

```
x = {1:2}
x.get(10,0)
0
```

20 - prefer raising exceptions to returning None

22 - use variable positional arguments

```
def log(message, *values):
```
