# TariffSmart Setup Guide

This SETUP directory contains exports of the TariffSmart database for use with a fork of the repository. These files capture the state of the database at the time of export and can be used to initialize a new database with the same data.

## Contents

The following data exports are included:

1. `countries.csv` - Contains data about countries and their tariff rates
2. `feature_flags.csv` - Contains feature flag settings
3. `product_categories.csv` - Contains product category information
4. `products.csv` - Contains product information
5. `tariff_smart_full_export.sql` - Complete SQL dump of the PostgreSQL database
6. `v2_dictionary_terms.csv` - Contains dictionary terms for the v2 educational platform
7. `v2_learning_modules.csv` - Contains learning modules for the v2 educational platform
8. `import_data.js` - A script to import the CSV data into a new database

## How to Use These Exports

### Option 1: Using the Interactive Import Script

The easiest way to import the data is using the provided shell script:

```bash
# First set your database URL
# PostgreSQL connection string format:
# postgresql://[user[:password]@][host][:port][/database][?parameter=value&...]
#
# Example for local PostgreSQL:
export DATABASE_URL=postgresql://postgres:password@localhost:5432/tariff_smart
#
# Example for Neon database:
# export DATABASE_URL=postgresql://[user]:[password]@[endpoint]/[database]

# Then run the interactive script
./SETUP/import.sh
```

This interactive script will guide you through the import process and let you choose between importing the full SQL dump or using the Node.js script to import the CSV files.

### Option 2: Using the SQL Dump Directly

If you want to directly restore the complete database, you can use the SQL dump file:

```bash
# Replace with your actual PostgreSQL connection string
psql postgresql://postgres:password@localhost:5432/tariff_smart < SETUP/tariff_smart_full_export.sql
```

This will restore the complete database structure and data.

### Option 3: Using the Node.js Import Script

For more control over the import process, you can use the provided Node.js script to import the CSV data:

1. Make sure your fork has the necessary dependencies installed:
   ```bash
   npm install @neondatabase/serverless csv-parser
   ```

2. Make sure your database URL is configured in the environment:
   ```bash
   # PostgreSQL connection string format:
   # postgresql://[user[:password]@][host][:port][/database][?parameter=value&...]
   # Example for local PostgreSQL:
   export DATABASE_URL=postgresql://postgres:password@localhost:5432/tariff_smart
   # Example for Neon database:
   export DATABASE_URL=postgresql://[user]:[password]@[endpoint]/[database]
   ```

3. Run the import script:
   ```bash
   node SETUP/import_data.js
   ```

   This script will import all the CSV data into your database, maintaining the relationships between tables.

### Option 4: Manual Import

If you prefer to manually import specific data, you can use the CSV files with SQL commands or database management tools of your choice.

## Database Schema

The data in these exports matches the schema defined in `shared/schema.ts` for the main application and the v2 schema defined in the v2 directory.

## Notes

- The SQL dump contains the complete database state, including table structures, indexes, and constraints.
- The CSV files contain just the data, requiring the schema to be created separately.
- If you're forking the repository for development or testing, consider using the in-memory storage option (`MemStorage`) instead of a real database for simplicity.
- For production use, make sure to properly secure your database credentials and connection string.

## License

This data is provided under the same license as the TariffSmart application.