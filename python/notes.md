
# use enumerate to get an index while iterating through a list

```
for i, color in enumerate(colors):
    print i, '--->', color
```

# Use izip to iterative over two collections
```
for name, color in izip(names, colors):
    print name, '--->', color
```

# Looping in custom order
```
print sorted(colors, key=len)
```

# Looping over dictionary
```
for k, v in d.iteritems():
    print k, '--->', v
```

# Construct dictionary from pairs
```
names = ['raymond', 'rachel', 'matthew']
colors = ['red', 'green', 'blue']

d = dict(zip(names, colors))
```

#  Use get to return a default value from a dictionary
```
d = {}
for color in colors:
    d[color] = d.get(color, 0) + 1
```

# Adding dictionaries together

Use ChainMap to link dictionaries.

# namedtuple
Use namedtuple to return meaningful tuples a function return codes

```
# importing "collections" for namedtuple()
import collections

# Declaring namedtuple()
Student = collections.namedtuple('Student', ['name', 'age', 'DOB'])

# Adding values
S = Student('Nandini', '19', '2541997')

# Access using index
print("The Student age using index is : ", end="")
print(S[1])
```

# defaultdict

Never raises a KeyError
Argumnet can be list, int or set

```
from collections import defaultdict

# Create a defaultdict with a default value of an empty list
my_dict = defaultdict(list)

# Add elements to the defaultdict
my_dict['fruits'].append('apple')
my_dict['vegetables'].append('carrot')

# Print the defaultdict
print(my_dict)
```


# Avoid temporary values by using unpacking

Eg swap to variables
```
x,y = (y * 2, x + 10)
```

# Use cache decorator to return cached value
```
@cache
def factorial(n):
    return n * factorial(n-1) if n else 1
```

# Ignore some exceptions
```
with ignored(OSError):
    os.remove('somefile.tmp')
```

# Beautiful, idomatic python

<https://gist.github.com/0x4D31/f0b633548d8e0cfb66ee3bea6a0deff9>

