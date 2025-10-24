/**
 * Database Import Script for TariffSmart
 * 
 * This script imports data from CSV files into the PostgreSQL database.
 * Run this script after setting up a new database in a forked repository.
 * 
 * Usage: node import_data.js
 */

const fs = require('fs');
const path = require('path');
const { Pool } = require('@neondatabase/serverless');
const { parse } = require('csv-parser');

// Check if DATABASE_URL is set
if (!process.env.DATABASE_URL) {
  console.error('DATABASE_URL environment variable is not set. Please set it before running this script.');
  process.exit(1);
}

// Create a database connection pool
const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
});

// Helper function to parse CSV files
async function parseCSV(filePath) {
  return new Promise((resolve, reject) => {
    const results = [];
    fs.createReadStream(filePath)
      .pipe(parse())
      .on('data', (data) => results.push(data))
      .on('end', () => resolve(results))
      .on('error', (error) => reject(error));
  });
}

// Helper function to format values for SQL insertion
function formatValue(value) {
  if (value === null || value === undefined || value === '') {
    return 'NULL';
  }
  
  // Check if the value is a JSON string (starts and ends with brackets or braces)
  if ((value.startsWith('[') && value.endsWith(']')) || 
      (value.startsWith('{') && value.endsWith('}'))) {
    return `'${value.replace(/'/g, "''")}'`;
  }
  
  return `'${value.replace(/'/g, "''")}'`;
}

// Import data from CSV files into the database
async function importData() {
  try {
    // Connect to the database
    const client = await pool.connect();
    console.log('Connected to database successfully.');
    
    try {
      // Import countries
      console.log('Importing countries...');
      const countriesData = await parseCSV(path.join(__dirname, 'countries.csv'));
      
      for (const country of countriesData) {
        const query = `
          INSERT INTO countries (id, name, base_tariff, reciprocal_tariff, effective_date, impact_level)
          VALUES (${country.id}, ${formatValue(country.name)}, ${country.base_tariff}, 
                  ${country.reciprocal_tariff}, ${formatValue(country.effective_date)}, 
                  ${formatValue(country.impact_level)})
          ON CONFLICT (id) DO UPDATE 
          SET name = ${formatValue(country.name)},
              base_tariff = ${country.base_tariff},
              reciprocal_tariff = ${country.reciprocal_tariff},
              effective_date = ${formatValue(country.effective_date)},
              impact_level = ${formatValue(country.impact_level)};
        `;
        
        await client.query(query);
      }
      console.log(`Imported ${countriesData.length} countries.`);
      
      // Import feature flags
      console.log('Importing feature flags...');
      const featureFlagsData = await parseCSV(path.join(__dirname, 'feature_flags.csv'));
      
      for (const flag of featureFlagsData) {
        const isEnabled = flag.is_enabled === 't' || flag.is_enabled === 'true' ? true : false;
        
        const query = `
          INSERT INTO feature_flags (id, name, is_enabled, description)
          VALUES (${flag.id}, ${formatValue(flag.name)}, ${isEnabled}, ${formatValue(flag.description)})
          ON CONFLICT (id) DO UPDATE 
          SET name = ${formatValue(flag.name)},
              is_enabled = ${isEnabled},
              description = ${formatValue(flag.description)};
        `;
        
        await client.query(query);
      }
      console.log(`Imported ${featureFlagsData.length} feature flags.`);
      
      // Import product categories
      console.log('Importing product categories...');
      const categoriesData = await parseCSV(path.join(__dirname, 'product_categories.csv'));
      
      for (const category of categoriesData) {
        const query = `
          INSERT INTO product_categories (id, name, description, primary_countries)
          VALUES (${category.id}, ${formatValue(category.name)}, ${formatValue(category.description)}, 
                  ${formatValue(category.primary_countries)})
          ON CONFLICT (id) DO UPDATE 
          SET name = ${formatValue(category.name)},
              description = ${formatValue(category.description)},
              primary_countries = ${formatValue(category.primary_countries)};
        `;
        
        await client.query(query);
      }
      console.log(`Imported ${categoriesData.length} product categories.`);
      
      // Import products
      console.log('Importing products...');
      const productsData = await parseCSV(path.join(__dirname, 'products.csv'));
      
      for (const product of productsData) {
        const query = `
          INSERT INTO products (id, name, description, category_id, origin_country, current_price, 
                               estimated_increase, impact_level)
          VALUES (${product.id}, ${formatValue(product.name)}, ${formatValue(product.description)}, 
                  ${product.category_id}, ${formatValue(product.origin_country)}, 
                  ${product.current_price}, ${product.estimated_increase}, 
                  ${formatValue(product.impact_level)})
          ON CONFLICT (id) DO UPDATE 
          SET name = ${formatValue(product.name)},
              description = ${formatValue(product.description)},
              category_id = ${product.category_id},
              origin_country = ${formatValue(product.origin_country)},
              current_price = ${product.current_price},
              estimated_increase = ${product.estimated_increase},
              impact_level = ${formatValue(product.impact_level)};
        `;
        
        await client.query(query);
      }
      console.log(`Imported ${productsData.length} products.`);
      
      // Import v2 dictionary terms
      console.log('Importing v2 dictionary terms...');
      const v2DictionaryTermsData = await parseCSV(path.join(__dirname, 'v2_dictionary_terms.csv'));
      
      for (const term of v2DictionaryTermsData) {
        const query = `
          INSERT INTO v2_dictionary_terms (id, term, slug, definition, category, examples, related_terms)
          VALUES (${term.id}, ${formatValue(term.term)}, ${formatValue(term.slug)}, 
                  ${formatValue(term.definition)}, ${formatValue(term.category)}, 
                  ${formatValue(term.examples)}, ${formatValue(term.related_terms)})
          ON CONFLICT (id) DO UPDATE 
          SET term = ${formatValue(term.term)},
              slug = ${formatValue(term.slug)},
              definition = ${formatValue(term.definition)},
              category = ${formatValue(term.category)},
              examples = ${formatValue(term.examples)},
              related_terms = ${formatValue(term.related_terms)};
        `;
        
        await client.query(query);
      }
      console.log(`Imported ${v2DictionaryTermsData.length} v2 dictionary terms.`);
      
      // Import v2 learning modules
      console.log('Importing v2 learning modules...');
      const v2LearningModulesData = await parseCSV(path.join(__dirname, 'v2_learning_modules.csv'));
      
      for (const module of v2LearningModulesData) {
        const featured = module.featured === 't' || module.featured === 'true' ? true : false;
        
        const query = `
          INSERT INTO v2_learning_modules (id, title, slug, description, category, difficulty, 
                                         estimated_minutes, featured, "order")
          VALUES (${module.id}, ${formatValue(module.title)}, ${formatValue(module.slug)}, 
                  ${formatValue(module.description)}, ${formatValue(module.category)}, 
                  ${formatValue(module.difficulty)}, ${module.estimated_minutes}, 
                  ${featured}, ${module.order})
          ON CONFLICT (id) DO UPDATE 
          SET title = ${formatValue(module.title)},
              slug = ${formatValue(module.slug)},
              description = ${formatValue(module.description)},
              category = ${formatValue(module.category)},
              difficulty = ${formatValue(module.difficulty)},
              estimated_minutes = ${module.estimated_minutes},
              featured = ${featured},
              "order" = ${module.order};
        `;
        
        await client.query(query);
      }
      console.log(`Imported ${v2LearningModulesData.length} v2 learning modules.`);
      
      console.log('All data imported successfully!');
    } catch (error) {
      console.error('Error importing data:', error);
    } finally {
      client.release();
    }
  } catch (error) {
    console.error('Error connecting to database:', error);
  } finally {
    await pool.end();
  }
}

// Run the import process
importData().catch(console.error);
