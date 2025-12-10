Pet Supply Shops - Node.js + MySQL backend

This is a small scaffolded backend that exposes REST endpoints used by the Flutter app.

Quick start

- Install dependencies:

```bash
cd backend
npm install
```

- Create a MySQL database and user (see `schema.sql`).
- Copy `.env.example` to `.env` and fill in your DB credentials.
- Run in development:

```bash
npm run dev
```

API endpoints (implemented):

- Categories
  - GET  /api/categories
  - GET  /api/categories/:id
  - POST /api/categories
  - PUT  /api/categories/:id
  - DELETE /api/categories/:id

- Pet profiles
  - GET  /api/users/:userId/pets
  - GET  /api/users/:userId/pets/:id
  - POST /api/users/:userId/pets
  - PUT  /api/users/:userId/pets/:id
  - DELETE /api/users/:userId/pets/:id

- Products
  - GET  /api/products
  - GET  /api/products/:id
  - POST /api/products
  - PUT  /api/products/:id
  - DELETE /api/products/:id

The Flutter app expects the server at `http://localhost:3000` by default.
