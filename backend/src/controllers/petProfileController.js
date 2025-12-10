const pool = require('../db');

async function getPetProfilesForUser(req, res, next) {
  try {
    const userId = Number(req.params.userId);
    const [rows] = await pool.query(
      'SELECT id, user_id, name, type, breed, birthday, created_at, updated_at FROM pet_profiles WHERE user_id = ? ORDER BY created_at',
      [userId]
    );
    res.json(rows);
  } catch (err) {
    next(err);
  }
}

async function getPetProfileById(req, res, next) {
  try {
    const userId = Number(req.params.userId);
    const id = Number(req.params.id);
    const [rows] = await pool.query(
      'SELECT id, user_id, name, type, breed, birthday, created_at, updated_at FROM pet_profiles WHERE user_id = ? AND id = ?',
      [userId, id]
    );
    if (!rows.length) return res.status(404).json({ message: 'Pet profile not found' });
    res.json(rows[0]);
  } catch (err) {
    next(err);
  }
}

async function addPetProfile(req, res, next) {
  try {
    const userId = Number(req.params.userId);
    const { name, type, breed, birthday } = req.body;
    const [result] = await pool.query(
      'INSERT INTO pet_profiles (user_id, name, type, breed, birthday) VALUES (?, ?, ?, ?, ?)',
      [userId, name || '', type || '', breed || '', birthday || null]
    );
    const insertId = result.insertId;
    const [rows] = await pool.query(
      'SELECT id, user_id, name, type, breed, birthday, created_at, updated_at FROM pet_profiles WHERE id = ?',
      [insertId]
    );
    res.status(201).json(rows[0]);
  } catch (err) {
    next(err);
  }
}

async function updatePetProfile(req, res, next) {
  try {
    const userId = Number(req.params.userId);
    const id = Number(req.params.id);
    const { name, type, breed, birthday } = req.body;
    await pool.query(
      'UPDATE pet_profiles SET name = ?, type = ?, breed = ?, birthday = ? WHERE user_id = ? AND id = ?',
      [name || '', type || '', breed || '', birthday || null, userId, id]
    );
    const [rows] = await pool.query(
      'SELECT id, user_id, name, type, breed, birthday, created_at, updated_at FROM pet_profiles WHERE id = ?',
      [id]
    );
    if (!rows.length) return res.status(404).json({ message: 'Pet profile not found' });
    res.json(rows[0]);
  } catch (err) {
    next(err);
  }
}

async function deletePetProfile(req, res, next) {
  try {
    const userId = Number(req.params.userId);
    const id = Number(req.params.id);
    await pool.query('DELETE FROM pet_profiles WHERE user_id = ? AND id = ?', [userId, id]);
    res.status(204).send();
  } catch (err) {
    next(err);
  }
}

module.exports = {
  getPetProfilesForUser,
  getPetProfileById,
  addPetProfile,
  updatePetProfile,
  deletePetProfile,
};
