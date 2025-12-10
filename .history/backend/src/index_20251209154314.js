const express = require('express');
const bodyParser = require('express').json;
const dotenv = require('dotenv');

dotenv.config();

const categoriesRouter = require('./routes/categories');
const petProfilesRouter = require('./routes/petProfiles');
const productsRouter = require('./routes/products');

const app = express();
app.use(bodyParser());

app.get('/', (req, res) => res.json({ status: 'ok', name: 'Pet Supply Backend' }));

app.use('/api/categories', categoriesRouter);
app.use('/api/users/:userId/pets', petProfilesRouter);
app.use('/api/products', productsRouter);

// error handler
app.use((err, req, res, next) => {
  console.error(err);
  res.status(500).json({ message: 'Internal server error' });
});

const port = process.env.PORT || 3000;
app.listen(port, () => console.log(`Server listening on port ${port}`));
