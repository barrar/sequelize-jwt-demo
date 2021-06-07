const router = require('express').Router();
const validation = require('../lib/validation');
exports.router = router;

// Schema describing required/optional fields of a photo object.
const photoSchema = {
  userid: { required: true },
  businessid: { required: true },
  caption: { required: false }
};

// Route to create a new photo.
router.post('/', ejwt({ secret: jwtSecret, algorithms: ['HS256'] }), async (req, res) => {
  if (validation.validateAgainstSchema(req.body, photoSchema)) {
    const photo = validation.extractValidFields(req.body, photoSchema);
    if (req.user && parseInt(req.user.id) == parseInt(photo.userid || req.user.admin == true)) {
      let createResult = await seqPhoto.create(photo);
      res.status(201).json({
        id: createResult.id,
        links: {
          photo: `/photos/${createResult.id}`,
          business: `/businesses/${createResult.businessid}`
        }
      });
    } else {
      res.status(401).json({ error: "Not authorized" });
    }
  } else {
    res.status(400).json({ error: "Request body is not a valid photo object" });
  }
});

// Route to fetch info about a specific photo.
router.get('/:photoID', async (req, res) => {
  const photoID = parseInt(req.params.photoID);
  findResult = await seqPhoto.findByPk(photoID)
  if (findResult) {
    res.status(200).json(findResult);
  } else {
    res.status(404).json({ error: `id ${photoID} not found` });
  }
});

// Route to update a photo.
router.put('/:photoID', ejwt({ secret: jwtSecret, algorithms: ['HS256'] }), async (req, res) => {
  const photoID = parseInt(req.params.photoID);
  findResult = await seqPhoto.findByPk(photoID)
  if (findResult) {
    if (validation.validateAgainstSchema(req.body, photoSchema)) {
      // Make sure the updated photo has the same businessid and userid as the existing photo.
      const updatedPhoto = validation.extractValidFields(req.body, photoSchema);
      if (req.user && parseInt(req.user.id) == parseInt(updatedPhoto.userid || req.user.admin == true)) {
        if (updatedPhoto.businessid === findResult.businessid && updatedPhoto.userid === findResult.userid) {
          findResult.update(updatedPhoto)
          res.status(200).json({
            links: {
              photo: `/photos/${photoID}`,
              business: `/businesses/${updatedPhoto.businessid}`
            }
          });
        } else {
          res.status(403).json({ error: "Updated photo cannot modify businessid or userid" });
        }
      } else {
        res.status(401).json({ error: "Not authorized" });
      }
    } else {
      res.status(400).json({ error: "Request body is not a valid photo object" });
    }
  } else {
    res.status(404).json({ error: `id ${photoID} not found` });
  }
});

// Route to delete a photo.
router.delete('/:photoID', ejwt({ secret: jwtSecret, algorithms: ['HS256'] }), async (req, res) => {
  const photoID = parseInt(req.params.photoID);
  findResult = await seqPhoto.findByPk(photoID)
  if (findResult) {
    if (req.user && parseInt(req.user.id) == parseInt(findResult.userid || req.user.admin == true)) {
      findResult.destroy();
      res.status(204).end();
    } else {
      res.status(401).json({ error: "Not authorized" });
    }
  } else {
    res.status(404).json({ error: `id ${photoID} not found` });
  }
});
