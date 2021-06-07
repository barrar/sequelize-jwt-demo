const router = require('express').Router()
exports.router = router
const validation = require('../lib/validation')

const userSchema = {
  name: { required: true },
  email: { required: true },
  password: { required: true },
  admin: { required: false }
}


// Route to list all of a user's businesses.
router.get('/:userid/businesses', ejwt({ secret: jwtSecret, algorithms: ['HS256'] }), async (req, res) => {
  if ((req.user && parseInt(req.user.id) == parseInt(req.params.userid) || req.user.admin == true)) {
    const userid = parseInt(req.params.userid);
    const userBusinesses = await seqBusiness.findAll({ where: { ownerid: userid } })
    res.status(200).json({
      businesses: userBusinesses
    });
  } else {
    res.status(401).json({ error: "Not authorized" });
  }
});

// Route to list all of a user's reviews.
router.get('/:userid/reviews', ejwt({ secret: jwtSecret, algorithms: ['HS256'] }), async (req, res) => {
  if ((req.user && parseInt(req.user.id) == parseInt(req.params.userid) || req.user.admin == true)) {
    const userid = parseInt(req.params.userid);
    const userReviews = await seqReview.findAll({ where: { userid: userid } })
    res.status(200).json({
      reviews: userReviews
    });
  } else {
    res.status(401).json({ error: "Not authorized" });
  }
});

// Route to list all of a user's photos.
router.get('/:userid/photos', ejwt({ secret: jwtSecret, algorithms: ['HS256'] }), async (req, res) => {
  if ((req.user && parseInt(req.user.id) == parseInt(req.params.userid) || req.user.admin == true)) {
    const userid = parseInt(req.params.userid);
    const userPhotos = await seqPhoto.findAll({ where: { userid: userid } })
    res.status(200).json({
      photos: userPhotos
    });
  } else {
    res.status(401).json({ error: "Not authorized" });
  }
});

// Create user
router.post('/', ejwt({ secret: jwtSecret, algorithms: ['HS256'] }), async (req, res) => {
  if (validation.validateAgainstSchema(req.body, userSchema)) {
    const user = validation.extractValidFields(req.body, userSchema);
    if (req.user && req.user.admin == true) {
      const existingUser = await seqUser.findOne({ where: { email: user.email } })
      if (existingUser) {
        res.status(400).json({ error: "Account already exists" });
      } else {
        if (!user.admin) {
          user.admin = false;
        }
        let createResult = await seqUser.create(user);
        console.log(createResult.id)
        res.status(201).json({
          id: createResult.id,
          links: {
            user: `/users/${createResult.id}`
          }
        })
      }
    } else {
      res.status(401).json({ error: "Not authorized" });
    }
  } else {
    res.status(400).json({ error: "Request body is not a valid user object" });
  }
});

// Login
router.get('/login', async (req, res) => {
  const user = await seqUser.scope("includePassword").findOne({ where: { email: req.body.email } })
  if (user && await user.checkPassword(req.body.password)) {
    const token = jwt.sign({
      id: user.id,
      admin: user.admin
    }, jwtSecret, { expiresIn: '5h' });
    res.status(200).json({ jwt: token });
  } else {
    res.status(401).json({ error: "Invalid login" });
  }
});

router.get('/:userid/', ejwt({ secret: jwtSecret, algorithms: ['HS256'] }), async (req, res) => {
  if ((req.user && parseInt(req.user.id) == parseInt(req.params.userid) || req.user.admin == true)) {
    const user = await seqUser.findOne({ where: { id: req.params.userid } })
    if (user) {
      res.status(200).json(user);
    } else {
      res.status(400).json({ error: "User not found" });
    }
  } else {
    res.status(401).json({ error: "Not authorized" });
  }
});