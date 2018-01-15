# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
- [x] Use ActiveRecord for storing information in a database
- [x] Include more than one model class (list of model class names e.g. User, Post, Category)
  Owner, Move, Box, and Item models
- [x] Include at least one has_many relationship (x has_many y e.g. User has_many Posts)
  Owners have many moves, boxes, and items.
  Moves have many boxes and items.
  Boxes have many items.
- [x] Include user accounts
  Must signup/login to use app
- [x] Ensure that users can't modify content created by other users
  Must be logged in to use the app
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
  Every model has CRUD
- [x] Include user input validations
  User cant login without valid information. All forms must be filled out
- [x] Display validation failures to user with error message (example form URL e.g. /posts/new)
  Flash messages
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
