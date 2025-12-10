const express = require('express');
const router = express.Router({ mergeParams: true });
const controller = require('../controllers/petProfileController');

router.get('/', controller.getPetProfilesForUser);
router.get('/:id', controller.getPetProfileById);
router.post('/', controller.addPetProfile);
router.put('/:id', controller.updatePetProfile);
router.delete('/:id', controller.deletePetProfile);

module.exports = router;
