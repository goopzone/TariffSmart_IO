#!/bin/bash

# TariffSmart Database Import Script
# This script helps import the TariffSmart database exports into a new PostgreSQL database

set -e

# Check if DATABASE_URL is set
if [ -z "$DATABASE_URL" ]; then
  echo "ERROR: DATABASE_URL environment variable is not set."
  echo "Please set your database URL first with:"
  echo "export DATABASE_URL=your_database_url"
  exit 1
fi

echo "TariffSmart Database Import"
echo "==========================="
echo ""

PS3="Select an import method: "
options=("Import full SQL dump" "Import using Node.js script" "Quit")
select opt in "${options[@]}"
do
  case $opt in
    "Import full SQL dump")
      echo "Importing full SQL dump from SETUP/tariff_smart_full_export.sql..."
      psql $DATABASE_URL < SETUP/tariff_smart_full_export.sql
      echo "Database import completed!"
      break
      ;;
    "Import using Node.js script")
      echo "Checking for required Node.js packages..."
      if ! npm list @neondatabase/serverless csv-parser > /dev/null 2>&1; then
        echo "Installing required packages..."
        npm install @neondatabase/serverless csv-parser
      fi
      
      echo "Running import script..."
      node SETUP/import_data.js
      echo "Database import completed!"
      break
      ;;
    "Quit")
      echo "Exiting without import."
      break
      ;;
    *) 
      echo "Invalid option $REPLY"
      ;;
  esac
done
