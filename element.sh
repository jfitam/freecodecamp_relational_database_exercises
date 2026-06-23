#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

# check if argument was passed
if [[ -z "$1" ]]; then
  echo "Please provide an element as an argument."
  exit 0
fi

# get the element
if [[ $1 =~ ^[0-9]+$ ]]; then
  RESULT=$($PSQL "SELECT atomic_number, symbol, name FROM elements WHERE atomic_number=$1")
else
  RESULT=$($PSQL "SELECT atomic_number, symbol, name FROM elements WHERE symbol='$1' OR name='$1'")
fi

# if not found
if [[ -z $RESULT ]]; then
  echo "I could not find that element in the database."
  exit 0
fi

# extract
IFS='|' read ATOMIC_NUMBER SYMBOL NAME <<< $RESULT

# get the characteristics
CHARACTERISTICS=$($PSQL "SELECT atomic_mass, melting_point_celsius, boiling_point_celsius, type_id FROM properties WHERE atomic_number=$ATOMIC_NUMBER")
IFS='|' read ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE_ID <<< $CHARACTERISTICS
TYPE=$($PSQL "SELECT type FROM types WHERE type_id=$TYPE_ID")

# output
echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."