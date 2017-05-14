# Playtest Inc. - A Set Game
Simple, Heroku-friendly Rails app configuration build on Ruby.
Build Status: 
[![Build Status](https://travis-ci.org/lil-boat/playtest-set-game.svg?branch=development)](https://travis-ci.org/lil-boat/playtest-set-game)

## Members
* Fei Li: lifangfei
* Harini : hariniGB
* Brian Wong: lil-boat
* Denise Duffy: duffydduffyd
* Eli Berger: erberger22

## Description of Project
Deploying a basic version of the traditional set game using Ruby on Rails and Javascript.
Instructions and a description of the game can be found here:
* http://www.setgame.com/set/puzzle
* http://www.setgame.com/set/puzzle_rules

## How to Install Code Locally
1. install ruby 2.3.1
2. bundle install
3. be rails db:create
4. be rails db:migrate
5. be rails db:seed
6. bin/rails server

## How to Use the App
1. Create an account or login to your existing account
2. Select **Play Set** option to go the game page.
3. Select **New Game** option to start the game.
4. Read the instructions to play the game and click the **New Game**
5. The *Add 3 Cards* option is used to add 3 more cards.
6. The *Find Set* option is used to help the player to find a set.
7. The game ends when all the 81 cards are used.
8. Game page displays the top ten points with the user name and game played date.
9. User details can be updated using **Update** option in *profile page*.
10. User can delete their account using **Delete** option in  *profile page*.
