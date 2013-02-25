Games and Virtual Environment - Homework 3
=============

About
------
A text adventure game for University of Idaho CS428 Homework #3

Uses a supplied set of JSON files to create a story. The program first loads `intro.json` which 
contains what area to load first and describes what objects the player must aquire in order to win the game.
By using JSON files as a story package, a user can define their own story line and use this 
program to play through the story.

Requirements and Goals
------

###Assignment Requirements

- [x] Text Based Adventure
- [x] Navigate through different nodes (rooms, cities, etc)
- [x] Interact with objects
- [x] Have an inventory

###Personal Goals

- [x] Dynamically loaded stories
- [x] Choose from different stories without changing game code


Stories
------
The game loads `intro.json` for an introduction, and to initiate the first area.

###intro.json

`firstArea`: The file name of the first area without a file extention<br />
`objectives`: A list of strings that the user needs to find

```
{
    "intro": "Text to describe what the game is about and what to do",
    "firstArea": "fileName",
    "objectives": [
        "objective 1",
        "objective 2"
    ]
}
```

###area.json

`description`: A description of the area the player is in<br />
`objects`: A list of objects that the area<br />
`attachedAreas`: A list of areas that the user can go to from this area with `go to`

```
{
    "description": "You begin to focus better, and realize you are in a strange house",
    "objects": [
        {
            "title": "Computer",
            "description": "A Green Dell Inspiron with a broken hinge",
            "canTake": false
        },
        {
            "title": "Couch",
            "description": "A blue recliner couch",
            "canTake": false
        },
        {
            "title": "Dog Bed",
            "description": "A tan with dog bed with brown stripes.",
            "canTake": false
        }
    ],
    "attachedAreas": [
        {
            "goto": "the kitchen",
            "fileName": "area02"
        },
        {
            "goto": "the bathroom",
            "fileName": "area03"

        }
    
    ]
}
```


Platform
-------
- <b>Language</b>: Objective-C
- <b>Operating System</b>: OSX 10.8
