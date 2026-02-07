# TariffSmart

An educational platform helping consumers understand and navigate the impact of international trade policies, tariffs, and global commerce.

## Overview

TariffSmart is a dual-platform application that empowers consumers with knowledge about international trade and its effects on their purchasing power. The platform combines practical tools for calculating tariff impacts with comprehensive educational resources for building trade literacy.

The application is not being maintained any more.
This project was the first in my "Adventures in Vibecoding" series - a collection of experiments and learning projects where I explore new tools, techniques, and workflows in software development.

### Platform Versions

**V1 - Tariff Impact Tracker**
The main application provides data-driven tools for understanding how tariffs affect consumer budgets and product prices.

**V2 - Education Platform**
An interactive learning experience focused on building foundational knowledge about international trade, tariffs, and global commerce through gamified content.

---

*The following screenshot shows the visual appearance of the application when it was live:*

![TariffSmart Homepage Screenshot](attached_assets/homepage-screenshot.png)

## Features

### V1: Tariff Impact Tracker

- **Tariff Calculator**: Input your typical purchases and estimate how tariffs impact your monthly budget
- **Product Browser**: Explore products by category with detailed tariff information and country-of-origin data
- **Country Tariff Rates**: Browse and compare tariff rates by country with impact level indicators (High/Medium/Low)
- **Implementation Timeline**: Visualize when tariffs take effect and understand expected retail price changes
- **Interactive Filtering**: Filter products by category, country, and tariff rate ranges

### V2: Education Platform

- **Interactive Learning Modules**: Complete short modules on topics like "What is a Tariff?" and "Why do countries trade?"
- **Gamified Trade Dictionary**: Search and explore trade terms, agreements, and concepts with engaging activities
- **Knowledge Quizzes**: Test your understanding with multiple choice, true/false, and "Myth vs. Fact" quizzes
- **Mini-Simulations**: See potential tariff impacts visually through interactive examples
- **Daily Challenges**: Participate in gamified activities to make learning more engaging
- **Progress Tracking**: Visual progress indicators to track your learning journey

## Tech Stack

### Frontend
- **React** - UI library for building interactive user interfaces
- **TypeScript** - Type-safe JavaScript for better code quality
- **Tailwind CSS** - Utility-first CSS framework for rapid styling
- **Radix UI** - Unstyled, accessible component primitives
- **TanStack Query** - Data fetching and state management
- **Wouter** - Lightweight routing library
- **Recharts** - Charting library for data visualization
- **Framer Motion** - Animation library

### Backend
- **Node.js** - JavaScript runtime environment
- **Express.js** - Web application framework
- **Drizzle ORM** - TypeScript ORM for database interactions
- **Passport.js** - Authentication middleware (Google OAuth & local strategy)
- **Express Session** - Session management

### Database
- **PostgreSQL** - Relational database (Neon-hosted)

### Development Tools
- **Vite** - Fast build tool and dev server
- **ESBuild** - JavaScript bundler
- **Drizzle Kit** - Database migration tool
- **TSX** - TypeScript execution environment

## Getting Started

### Prerequisites

- Node.js (v18 or higher recommended)
- PostgreSQL database (or use Replit's built-in database)

### Installation

1. Clone the repository:
```bash
git clone <your-repo-url>
cd tariffsmart
```

2. Install dependencies:
```bash
npm install
```

3. Set up environment variables:
```bash
# Required environment variable
export DATABASE_URL=postgresql://user:password@host:port/database
```

4. Initialize the database:

**Option A: Using the SQL dump**
```bash
psql $DATABASE_URL < SETUP/tariff_smart_full_export.sql
```

**Option B: Using the interactive import script**
```bash
./SETUP/import.sh
```

**Option C: Push schema and import CSV data**
```bash
npm run db:push
node SETUP/import_data.js
```

5. Start the development server:
```bash
npm run dev
```

The application will be available at `http://localhost:5000`

## Available Scripts

- `npm run dev` - Start the development server
- `npm run build` - Build the application for production
- `npm start` - Run the production build
- `npm run check` - Type-check TypeScript files
- `npm run db:push` - Push database schema changes (uses Drizzle Kit)

## Project Structure

```
tariffsmart/
├── client/                 # V1 Frontend application
│   ├── src/
│   │   ├── components/    # React components
│   │   ├── lib/          # Utility functions and configurations
│   │   ├── pages/        # Page components
│   │   └── main.tsx      # Entry point
│   └── index.html
│
├── v2/                    # V2 Education Platform
│   ├── client/           # V2 Frontend
│   │   └── src/
│   ├── server/           # V2 Backend
│   │   └── routes/
│   └── shared/           # Shared schemas and types
│
├── server/               # Main backend application
│   ├── auth/            # Authentication configuration
│   ├── routes.ts        # API route definitions
│   ├── storage.ts       # Database interaction layer
│   └── index.ts         # Server entry point
│
├── shared/              # Shared schemas and types
│   └── schema.ts        # Drizzle database schema
│
├── SETUP/               # Database setup and exports
│   ├── countries.csv
│   ├── products.csv
│   ├── tariff_smart_full_export.sql
│   └── import.sh
│
├── scripts/             # Utility scripts
│   ├── export_countries.js
│   └── import_countries.js
│
└── data_exports/        # Data export destination
```

## Database Schema

The application uses Drizzle ORM with PostgreSQL. Key tables include:

- `countries` - Country information and tariff rates
- `products` - Product catalog with category and origin data
- `product_categories` - Product category definitions
- `feature_flags` - Feature toggle configuration
- `v2_learning_modules` - Educational content modules
- `v2_dictionary_terms` - Trade terminology and definitions
- `users` - User accounts and authentication
- `user_progress` - Learning progress tracking

### Making Database Changes

1. Update the schema in `shared/schema.ts`
2. Run `npm run db:push` to apply changes to the database
3. If you encounter data-loss warnings, use `npm run db:push -- --force`

**Note**: Never write manual SQL migrations. Always use Drizzle Kit for schema changes.

## Authentication

TariffSmart supports multiple authentication strategies:

- **Local Authentication** - Email and password-based signup/login
- **Google OAuth** - Sign in with Google account

Authentication is managed through Passport.js with session-based storage.

## Data Management

### Exporting Data

Export country data to CSV:
```bash
node scripts/export_countries.js
```

### Importing Data

Import country data from CSV:
```bash
node scripts/import_countries.js
```

### Complete Database Export

The `SETUP/` directory contains a complete database export including:
- SQL dump (`tariff_smart_full_export.sql`)
- CSV exports for all major tables
- Interactive import script (`import.sh`)

## Development Workflow

1. Start the development server: `npm run dev`
2. Make changes to the code
3. The application will hot-reload automatically
4. For database changes, update `shared/schema.ts` and run `npm run db:push`
5. Run type checking with `npm run check` before committing

## Production Build

1. Build the application:
```bash
npm run build
```

2. Start the production server:
```bash
npm start
```

The production build:
- Bundles the frontend with Vite
- Bundles the backend with ESBuild
- Serves static files from the build output

## Environment Variables

Required:
- `DATABASE_URL` - PostgreSQL connection string

Optional:
- `GOOGLE_CLIENT_ID` - For Google OAuth authentication
- `GOOGLE_CLIENT_SECRET` - For Google OAuth authentication
- `SESSION_SECRET` - For session encryption (auto-generated if not provided)
- `NODE_ENV` - Set to `production` for production builds

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License.

## Support

For questions, issues, or feature requests, please open an issue on GitHub.

---

Built with ❤️ to help consumers understand international trade and make informed purchasing decisions.
