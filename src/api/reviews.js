const router = require('express').Router();
const validation = require('../lib/validation');
exports.router = router;

// Schema describing required/optional fields of a review object.
const reviewSchema = {
  userid: { required: true },
  businessid: { required: true },
  dollars: { required: true },
  stars: { required: true },
  review: { required: false }
};

// Route to create a new review.
router.post('/', ejwt({ secret: jwtSecret, algorithms: ['HS256'] }), async (req, res) => {
  if (validation.validateAgainstSchema(req.body, reviewSchema)) {
    const review = validation.extractValidFields(req.body, reviewSchema);
    if (req.user && parseInt(req.user.id) == parseInt(review.userid) || req.user.admin == true) {
      // Make sure the user is not trying to review the same business twice.
      if (await seqReview.findOne({ where: { businessid: review.businessid, userid: review.userid } })) {
        res.status(403).json({ error: "User has already posted a review of this business" });
      } else {
        let createResult = await seqReview.create(review);
        res.status(201).json({
          id: createResult.id,
          links: {
            review: `/reviews/${createResult.id}`,
            business: `/businesses/${review.businessid}`
          }
        });
      }
    } else {
      res.status(401).json({ error: "Not authorized" });
    }
  } else {
    res.status(400).json({ error: "Request body is not a valid review object" });
  }
});

// Route to fetch info about a specific review.
router.get('/:reviewID', async (req, res) => {
  const reviewID = parseInt(req.params.reviewID);
  findResult = await seqReview.findByPk(reviewID)
  if (findResult) {
    res.status(200).json(findResult);
  } else {
    res.status(404).json({ error: `id ${reviewID} not found` });
  }
});

// Route to update a review.
router.put('/:reviewID', ejwt({ secret: jwtSecret, algorithms: ['HS256'] }), async (req, res) => {
  const reviewID = parseInt(req.params.reviewID);
  findResult = await seqReview.findByPk(reviewID)
  if (findResult) {
    if (validation.validateAgainstSchema(req.body, reviewSchema)) {
      let updatedReview = validation.extractValidFields(req.body, reviewSchema);
      if (req.user && parseInt(req.user.id) == parseInt(updatedReview.userid) || req.user.admin == true) {
        // Make sure the updated review has the same businessid and userid as the existing review.
        if (updatedReview.businessid === findResult.businessid && updatedReview.userid === findResult.userid) {
          findResult.update(updatedReview)
          res.status(200).json({
            links: {
              review: `/reviews/${reviewID}`,
              business: `/businesses/${updatedReview.businessid}`
            }
          });
        } else {
          res.status(403).json({ error: "Updated review cannot modify businessid or userid" });
        }
      } else {
        res.status(401).json({ error: "Not authorized" });
      }
    } else {
      res.status(400).json({ error: "Request body is not a valid review object" });
    }

  } else {
    res.status(404).json({ error: `id ${reviewID} not found` });
  }
});

// Route to delete a review.
router.delete('/:reviewID', ejwt({ secret: jwtSecret, algorithms: ['HS256'] }), async (req, res) => {
  const reviewID = parseInt(req.params.reviewID);
  findResult = await seqReview.findByPk(reviewID)
  if (findResult) {
    if (req.user && parseInt(req.user.id) == parseInt(findResult.userid) || req.user.admin == true) {
      findResult.destroy();
      res.status(204).end();
    } else {
      res.status(401).json({ error: "Not authorized" });
    }
  } else {
    res.status(404).json({ error: `id ${reviewID} not found` });
  }
});
