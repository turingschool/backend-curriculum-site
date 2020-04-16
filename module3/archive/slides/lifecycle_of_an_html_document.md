# The lifecycle of an HTML document

- Three important Events in the lifecycle of an HTML page:
1. *DOMContentLoaded* - the browser has fully loaded the HTML, and the DOM tree is built, but external resources like pictures <img> and stylesheets may not be loaded yet.
2. *load* - the browser has fully loaded the HTML, DOM tree, and external resources i.e. images, stylesheets
3. *beforeunload/unload* - the user is leaving the page

---

```
document.addEventListener("DOMContentLoaded", function(event){
  doSomeThings();
});
```

```
window.onload = function() {
  doAllTheThings();
}
```

```
window.onunload = function() {
  doSomethingElse();
}
```

---
