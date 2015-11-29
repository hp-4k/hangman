Hangman
=======

This is a Ruby implementation of the well-known [hangman](https://en.wikipedia.org/wiki/Hangman_(game)) game. The aim of the game is to guess a secret word by guessing the letters of alphabet that it contains. The player is allowed a certain number of wrong guesses. The game ends when either the player exceeds the allowed number of wrong guesses or guesses the word correctly.

The secret word is randomly chosen from a dictionary. The word is 5 to 12 characters long and is a proper noun.

The game allows for its state to be saved at any moment. This is implemented using YAML.