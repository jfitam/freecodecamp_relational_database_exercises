#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
SKIPLINES=1
cat games.csv | while IFS=',' read -r YEAR ROUND WINNER LOSER GOALS_W GOALS_L
do
  if (( $SKIPLINES ))
  then
    (( SKIPLINES-- ))
  else
    #get the teams id
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    LOSER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$LOSER'")

    #if does not exists, insert it
    if [[ -z $WINNER_ID ]]; then
      WINNER_ID=$($PSQL "
      INSERT INTO teams(name) 
      VALUES ('$WINNER') 
      RETURNING team_id
      " | grep -Eo "^[0-9]+")
    fi

    if [[ -z $LOSER_ID ]]; then
      LOSER_ID=$($PSQL "
      INSERT INTO teams(name) 
      VALUES ('$LOSER') 
      RETURNING team_id
      " | grep -Eo "^[0-9]+")
    fi

    #insert the row
    INSERT_GAME=$($PSQL "
    INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) 
    VALUES (${YEAR}, '${ROUND}', ${WINNER_ID}, ${LOSER_ID}, ${GOALS_W}, ${GOALS_L})
    ")

  fi
done 