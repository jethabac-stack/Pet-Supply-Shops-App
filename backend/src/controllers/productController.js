const pool = require('../db');

async function getAllProducts(req, res, next) {
  try {
    const [rows] = await pool.query(
      'SELECT p.id, p.name, p.description, p.price, p.stock, p.image_url, p.category_id, c.name AS category_name FROM products p LEFT JOIN categories c ON p.category_id = c.id ORDER BY p.name'
    );
    res.json(rows);
  } catch (err) {
    next(err);
  }
}

async function getProductById(req, res, next) {
  try {
    const id = Number(req.params.id);
    const [rows] = await pool.query(
      'SELECT p.id, p.name, p.description, p.price, p.stock, p.image_url, p.category_id, c.name AS category_name FROM products p LEFT JOIN categories c ON p.category_id = c.id WHERE p.id = ?',
      [id]
    );
    if (!rows.length) return res.status(404).json({ message: 'Product not found' });
    res.json(rows[0]);
  } catch (err) {
    next(err);
  }
}

async function addProduct(req, res, next) {
  try {
    const { name, description, price, stock, image_url, category_id } = req.body;
    const [result] = await pool.query(
      'INSERT INTO products (category_id, name, description, price, stock, image_url) VALUES (?, ?, ?, ?, ?, ?)',
      [category_id || null, name || '', description || '', price || 0.0, stock || 0, image_url || '']
    );
    const insertId = result.insertId;
    const [rows] = await pool.query('SELECT * FROM products WHERE id = ?', [insertId]);
    res.status(201).json(rows[0]);
  } catch (err) {
    next(err);
  }
}

async function updateProduct(req, res, next) {
  try {
    const id = Number(req.params.id);
    const { name, description, price, stock, image_url, category_id } = req.body;
    await pool.query(
      'UPDATE products SET category_id = ?, name = ?, description = ?, price = ?, stock = ?, image_url = ? WHERE id = ?',
      [category_id || null, name || '', description || '', price || 0.0, stock || 0, image_url || '', id]
    );
    const [rows] = await pool.query('SELECT * FROM products WHERE id = ?', [id]);
    if (!rows.length) return res.status(404).json({ message: 'Product not found' });
    res.json(rows[0]);
  } catch (err) {
    next(err);
  }
}

async function deleteProduct(req, res, next) {
  try {
    const id = Number(req.params.id);
    await pool.query('DELETE FROM products WHERE id = ?', [id]);
    res.status(204).send();
  } catch (err) {
    next(err);
  }
}

module.exports = {
  getAllProducts,
  getProductById,
  addProduct,
  updateProduct,
  deleteProduct,
};
