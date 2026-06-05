#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=salon -t --no-align -c "

function MAIN_MENU {

  if [[ $1 ]]; then
    echo -e $1
  else
    echo -e "\nWelcome to My Salon, how can I help you?\n"
  fi

  #options
  $PSQL "SELECT service_id, name FROM services" |
  while IFS="|" read -r SERVICE_ID NAME; do
    echo "$SERVICE_ID) $NAME"
  done 

  #select
  read SERVICE_ID_SELECTED
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id='$SERVICE_ID_SELECTED'")

  #not found
  if [[ -z $SERVICE_NAME ]]; then
    MAIN_MENU "\nI could not find that service. What would you like today?"
  else
    # get phone number
    echo -e "\nWhat's your phone number?"
    read CUSTOMER_PHONE

    IFS="|" read CUSTOMER_ID CUSTOMER_NAME <<< $($PSQL "SELECT customer_id, name FROM customers WHERE phone='$CUSTOMER_PHONE'")

    # not found
    if [[ -z $CUSTOMER_ID ]]; then
      echo -e "\nI don't have a record for that phone number, what's your name?"
      read CUSTOMER_NAME
      CUSTOMER_ID=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE') RETURNING customer_id" | grep -E "^[0-9]+")
    fi

    # get time
    echo -e "\nWhat time would you like your cut, $CUSTOMER_NAME?"
    read SERVICE_TIME

    # register
    INSERT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES ($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")

    if [[ ! -z $INSERT ]]; then
      echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
    fi
  fi
}

# header
echo -e "\n~~~~~ MY SALON ~~~~~"

MAIN_MENU

