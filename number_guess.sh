#!/bin/bash

# game of guessing. guess a number between 1 and 1000

# constant 
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

# get the username
echo "Enter your username:"
read USERNAME
USERNAME=${USERNAME,,}

# retrieve the user data
RESULT=$($PSQL "SELECT games_played, best_score FROM users WHERE username='$USERNAME'")

if [[ -z $RESULT ]]; then
  # if does not exist, welcome
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  GAMES_PLAYED=0
  NEW_PLAYER=true
else
  # if found, print the information
  IFS='|' read GAMES_PLAYED BEST_SCORE <<< "$RESULT"
  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_SCORE guesses."
  NEW_PLAYER=false
fi

# guess loop
GUESS=0
TARGET=$(( RANDOM % 1000 + 1 ))
SCORE=0

echo "Guess the secret number between 1 and 1000:"
while (( GUESS != TARGET)); do
  read GUESS

  # check if integer
  if ! [[ $GUESS =~ ^[0-9]+$ ]]; then
    echo "That is not an integer, guess again:"
    continue
  else
    ((SCORE++))
  fi

  # compare
  if [[ $GUESS -lt $TARGET ]]; then
   echo "It's higher than that, guess again:"
  elif [[ $GUESS -gt $TARGET ]]; then
    echo "It's lower than that, guess again:"
  else
    echo "You guessed it in $SCORE tries. The secret number was $TARGET. Nice job!"
  fi
done

# save the info
if [[ $NEW_PLAYER == true ]]; then
  $PSQL "INSERT INTO users(username, games_played, best_score) VALUES('$USERNAME', 1, $SCORE)" > /dev/null
else
  if [[ $SCORE -lt $BEST_SCORE ]]; then
    BEST_SCORE=$SCORE
  fi
  $PSQL "UPDATE users SET games_played=$((GAMES_PLAYED+1)), best_score=$BEST_SCORE WHERE username='$USERNAME'" > /dev/null
fi

