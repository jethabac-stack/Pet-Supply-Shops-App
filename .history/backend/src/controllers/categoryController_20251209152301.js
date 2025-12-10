const pool = require('../db');

async function getAllCategories(req, res, next) {
  try {
    const [rows] = await pool.query('SELECT id, name, icon, created_at, updated_at FROM categories ORDER BY name');
    res.json(rows);
  } catch (err) {
    next(err);
  }
}

async function getCategoryById(req, res, next) {
  try {
    const id = Number(req.params.id);
    const [rows] = await pool.query('SELECT id, name, icon, created_at, updated_at FROM categories WHERE id = ?', [id]);
    if (!rows.length) return res.status(404).json({ message: 'Category not found' });
    res.json(rows[0]);
  } catch (err) {
    next(err);
  }
}

async function addCategory(req, res, next) {
  try {
    const { name, icon } = req.body;
    const [result] = await pool.query('INSERT INTO categories (name, icon) VALUES (?, ?)', [name, icon || '']);
    const insertId = result.insertId;
    const [rows] = await pool.query('SELECT id, name, icon, created_at, updated_at FROM categories WHERE id = ?', [insertId]);
    res.status(201).json(rows[0]);
  } catch (err) {
    next(err);
  }
}

async function updateCategory(req, res, next) {
  try {
    const id = Number(req.params.id);
    const { name, icon } = req.body;
    await pool.query('UPDATE categories SET name = ?, icon = ? WHERE id = ?', [name, icon || '', id]);
    const [rows] = await pool.query('SELECT id, name, icon, created_at, updated_at FROM categories WHERE id = ?', [id]);
    if (!rows.length) return res.status(404).json({ message: 'Category not found' });
    res.json(rows[0]);
  } catch (err) {
    next(err);
  }
}

async function deleteCategory(req, res, next) {
  try {
    const id = Number(req.params.id);
    await pool.query('DELETE FROM categories WHERE id = ?', [id]);
    res.status(204).send();
  } catch (err) {
    next(err);
  }
}

module.exports = {
  getAllCategories,
  getCategoryById,
  addCategory,
  updateCategory,
  deleteCategory,
};
