https://www.tutorialsteacher.com/jquery/start-using-jquery


"$" is a alias for jQuery. So all the following are identical:
```
window.jQuery = window.$ = jQuery = $
```

To select all div elements do:
```
$('div')
```


It is advisable to use jQuery after DOM is loaded fully. Use jQuery ready() function to make sure that DOM is loaded fully.


```
$('p').append('This is paragraph.'); // appends text to all p elements 
```
by id
```
$('#impPrg').append('This element\'s id is "impPrg"');
```

