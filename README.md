# Approach to design and implementation

### Choosing the technology

With limited experience in any server side technology, I spent some time looking at Node.js, Rails and Sinatra. Although there is more internet support for learning Node and Rails,
Sinatra was the eventual choice due to its lack of complexity and requirements for a set structure, ideal for building a single page application.


### Designing the data structure

The specification called for a story with a root story line that could branch up to four times on each iteration. The obvious choice to represent this was some kind of tree structure and I spent 
some time investigating Ruby libraries to represent a tree. I also considered a class containing a story line and an array of children, mimicking a pointer based tree. After further analysis
I concluded that the requirements could be met by a simpler object. This was made up of variables representing the story line inputted by the user, its position in the grid, and an id for its parent
story line. These objects were held in a session array to persist across http routes.


### Coding process

Writing the code was approached in a step by step way. Firstly, the view was designed and the initial routes for getting the page were written. The next step was to create
a POST route to submit user input, create a Line object and add it to the story. 

Once these initial steps were in place, the more complicated functionality was implemented. This involved taking the user input for each form then returning that input to the user in the 
form of a clickable link, which would then allow them to move on to the next step of the story.

At this point the code was refactored to create a sub array of the main story array which just contained the children of the current page. Depending on the contents of this array, the forms in the view were
generated conditionally to either allow the user to add another line, or click an existing one to make a new path. 

 
### Shortcuts

Some shortcuts were taken to facilitate completion of the task within a shorter time. These were as follows:

* User input was not parsed for validity or special characters
  The implication of this is that some non-alphanumeric characters may cause errors, specifically those used in URLS, for example percent, and leading question marks. Pairs of double quotes cause the story to reset to the start.
* Limited CSS
  A particular implication of this is that long words don't wrap within their grid square, and long sentences don't scroll or resize.
* Possible issue with repeated input
  If a user adds in the same string in more than one place, then clicks it, the application will take them to the view for the most recently added occurrence of that string.


### Further functionality

This has been an enjoyable challenge. As a further learning experience I am thinking of implementing more functionality as follows:

* Going back up one level.
* Option to generate and print a random path through the story from what has been created by the user.
* Randomising the starter sentence.
 

### What I think this test is testing

* Understanding of basic web application structure and how HTTP commands work.
* The ability to understand requirements from seeing a prototype.
* Coding ability.
* Understanding of data structures.
* Ability to choose suitable technology and learn new frameworks as required.