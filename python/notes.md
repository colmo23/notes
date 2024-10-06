```
Card = collections.namedtuple('Card', ['rank', 'suit'])
class FrenchDeck:
    ranks = [str(n) for n in range(2, 11)] + list('JQKA')
    suits = 'spades diamonds clubs hearts'.split()
    def __init__(self):
        self._cards = [Card(rank, suit) for suit in self.suits
            for rank in self.ranks]
    def __len__(self):
        return len(self._cards)
    def __getitem__(self, position):
        return self._cards[position]
```

# namedtuple
Use namedtuple to give meaning to tuple fields

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
