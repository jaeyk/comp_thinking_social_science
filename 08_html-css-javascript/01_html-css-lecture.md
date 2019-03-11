Source Code for Websites: HTML, CSS, and Javascript
========================================================
author: PS239T
date: Spring 2019
autosize: TRUE



[Mozila Foundation](https://developer.mozilla.org/en-US/docs/Learn/HTML/Introduction_to_HTML/Getting_started) have amazing tutorials on Web fundamentals. I use some of their contents for this section. 


Again, How the Web Works 
===========================================================================================

Computers connected to the web are **clients** and **servers**.

- Clients: the typical web user's internet-connected devices 

- Servers: computers that store webpages, sites, or apps.

  

![client-server](https://mdn.mozillademos.org/files/8973/Client-server.jpg)





[The TCP/IP model](https://en.wikipedia.org/wiki/Internet_protocol_suite) has 4 components (for more information, see the post by [Karl Dubost](https://dev.opera.com/articles/http-basic-introduction/)). 

1. **Link** describes the access to physical media (e.g. using the network card)
2. **Internet** describes the envelope and routing of data — how it is packaged (IP)
3. **Transport** describes the way the data is delivered from the starting point to the final destination (TCP, UDP)
4. **Application** describes the meaning or format of the transferred messages (HTTP)



When using an API, we don't need to worry about how web content is organized. Since that information is provided by the API documentation (key-value pairs). As long as you know how HTTP (Hyptertext Transfer Protocol) works, then it's fine. Unfortunately, that's not the case for web scraping. 

![web-history](https://upload.wikimedia.org/wikipedia/commons/thumb/3/39/Internet_Key_Layers.png/525px-Internet_Key_Layers.png)



What is a Website?
========================================================

Some combination of codebase, database

The "front end" product is HTML + CSS stylesheets + Javascript
- HTML (structure + semantics): 
  - Provides the structure of the website (aka, the "tree") 
  - Starts with call to `<html>` tag, ends with `</html>` tag
  - Note: tags are case-sensitive. `<html>` not `HTML`.
- CSS (styles + layout): 
  - Fleshes out the website (provides color, shape, styling, etc.)
  - Uses *.css files or code embedded in `<style>` `</style>` or `<link>` `</link>` tags
- Javascript (all the dynamic and interactive stuff):
  - Brings the website to life (dynamic or interactive content)
  - *.js files or code embedded in `<script>` `</script>` tags



![layered-website](https://www.lifewire.com/thmb/ifaXMe5Av9OPfcUIJGyWJl0PGKI=/768x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/content-56a1462b3df78cf7726914d7.jpg)



This is a Website
========================================================
![html](img/html.png)

Your browser turns that into a tidy layout...

This is What You Think a Website Is
========================================================
![layout](img/layout.png)

Voila!

HTML: Basic Structure
========================================================

```html
<!DOCTYPE html>
<html>
	<head>
		<title>Page title</title>
	</head>
 	<body>
 		<p>Hello world!</p>
 	</body>
</html>
```

<!DOCTYPE html>: The doctype was a documentation standard in the early 1990s when HTML was young. It's now a historical artifact that shows that the document is a valid docttype.



HTML is a Tree
========================================================

![tree](http://www.openbookproject.net/tutorials/getdown/css/images/lesson4/HTMLDOMTree.png)

 

This tree structure makes sense since that's how most documents are structured.

![document-example](https://mdn.mozillademos.org/files/12371/newspaper_small.jpg)



Document Object Model
========================================================

- Most modern browsers have a parser that reads in the HTML document, parses it into a DOM (Document Object Model) structure, and then renders the DOM structure.

- Much like HTTP, the DOM is an agreed-upon standard.

- The DOM is much more than what I've described, but for our purposes, what is most important to understand is that the text is only one part of an HTML element. (This will be important to remember when you get to writing your scrapers next week!)

Example of a Document Object Model
========================================================

Note that the DOM retains the tree structure: 
![dom](http://www.cs.toronto.edu/~shiva/cscb07/img/dom/treeStructure.png)

HTML Elements
========================================================

HTML works through elements. 

1. Tags: the opening and closing tag. Failing to include either one of those two tags will cause an error.
2. The element: the opening tag + the closing tag + the content 
3. The content: the content of the the element 

![elements](https://mdn.mozillademos.org/files/9347/grumpy-cat-small.png)


Common HTML Tags
========================================================

| Tag        | Meaning           |
| ------------- |-------------  |
| `<head>`     | page header (metadata, etc |
| `<body>`     | holds all of the content |
| `<p>` | regular text (paragraph) |
| `<h1>`,`<h2>`,`<h3>` | header text, levels 1, 2, 3  |
| `<ol>,`,`<ul>`,`<li>` | ordered list, unordered list, list item |
| `<a href="page.html">` | link to "page.html" |
| `<table>`,`<tr>`,`<td>`  | table, table row, table item |
| `<div>`,`<span` | general containers |

HTML Attributes
========================================================

- Elements can have attributes. 
  - Attributes contain information about the element which you don't want to appear in the actual content. In this case, `class` attribute allows you to target the element with style information and other things. One of the most famous attributes would be `href`, which specifies the web address you want the link to point to. Something like `<a href=https://www.mozilla.org/ title=The Mozilla homepage>favorite website</a>`
  - Syntax 
    - A space between it and the element name.
    - The attribute name, followed by an equal sign.
    - An attribute value, with opening and closing quote marks wrapped around it. 

![html-attributes](https://mdn.mozillademos.org/files/9345/grumpy-cat-attribute-small.png)

CSS
========================================================

- CSS = Cascading Style Sheet. 
- CSS defines how HTML elements are to be displayed
- HTML came first. But it was only meant to define content, not format it. While HTML contains tags like `<font>` and `<color>`, this is a very inefficient way to develop a website.
- To solve this problem, CSS was created to display content on a webpage. Now, one can change the look of an entire website just by changing one file.
- Most web designers litter the HTML markup with tons of `class`s and `id`s to provide "hooks" for their CSS.
- You can piggyback on these to jump to the parts of the markup that contain the data you need.

CSS Anatomy
======================================

CSS contains rules with two parts: **selectors** and **properties**

![css-syntax](https://www.w3schools.com/css/selector.gif)

A selector identifies what part of your web page gets styled. The property tells the browser what to change, and the value lets the browser know what the change should be.

* Selectors
    * Element selector: `p`
    * Class selector:  `p class="blue"`(class can be applied to more than one element)
    * I.D. selector: `p id="blue"`(id for one element; should be unique within a page)
* Declarations
    - Selector: `p`
    - Property: `background-color`
    - Value: `yellow`
* Hooks

***
![css-rule](img/css-rule-2.png)

CSS + HTML
========================================================

```html
<body>
	<table id="content">
    	<tr class='name'>
        	<td class='firstname'>
         		Ernesto
        	</td>
        	<td class='lastname'>
          		Rojas
        	</td>
    	</tr>
    	<tr class='name'>
      		<td class='firstname'>
          		Elisabeth
        	</td>
        	<td class='lastname'>
          		Earley
     		</td>
    	</tr>
 	</table>
</body>
```

Javascript
========================================================

- Where have we seen Javascript before?
  - .json = **J**ava**s**cript **O**bject **N**otation
  - Note: Javascript and Java are two entirely separate languages
- Javascript is added into existing HTML code (either in head or in body)
- JS adds actions to sites: every time you "interact" with a button, image, or graphic, or you see something change live, you're probably looking at Javascript 

Javascript Example 1 
========================================================

Javascript can be added explicitly in code, or by calling a separate script file (.js)
- Added explicitly: 
![js-example](img/javascript-example.png)
<small>[Image credit](https://www.w3schools.com/js/js_output.asp)</small>

Javascript Example 2
========================================================

Javascript can also be written as a separate script, just like we do with R (and it looks fairly similar!)

```javascript
var x, y;
x = 5;
y = 'string' // This is a string
z = x + y; 
```
What will z print? 

Return of the Javascript
========================================================

We'll come back to Javascript when we get to Qualtrics, in a few weeks!

For now, it's time for a challenge...

Assemble Your Tools
========================================================

1. Get the [Selector Gadget](http://selectorgadget.com/)
    - this is a Chrome extension that lets us select everything on a page of a certain type (typically, by looking for objects of the same class)
2. Head to the [New York Times](http://www.nytimes.com/)
3. Prepare your right fingers (aka, find your right-click functionality using a mouse or trackpad!)


Inspect Element
========================================================

Google Chrome comes with great developer tools to help parse a webpage. (For more information, click this [link](https://developers.google.com/web/tools/chrome-devtools/).)  To use DevTools, press Command+Option+C (Mac) or Control+Shift+C (Windows, Linux, Chrome OS).

![inspect element](img/inspect-element.png)

The inspector gives you the HTML tree, as well as all the CSS selectors and style information.

Challenges
========================================================

1. What tags uniquely define the byline? What is the CSS selector for the byline? 

2. What tags uniquely define the section headers? Is there a CSS selector for all the section headers?

3. Using the styles tab in your inspector, change all headlines to a "blueviolet" color. Change the page background color to "bisque."

4. Change the font size of the summaries to be smaller. Change the font family of the text for the summaries. Then, change it for the entire page.

5. What tags define links to the articles?

6. What is the first instance of Javascript on the webpage?
