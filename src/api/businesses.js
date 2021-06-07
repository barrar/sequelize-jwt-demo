const router = require('express').Router();
const validation = require('../lib/validation');
exports.router = router;

// Schema describing required/optional fields of a business object.
const businessSchema = {
  ownerid: { required: true },
  name: { required: true },
  address: { required: true },
  city: { required: true },
  state: { required: true },
  zip: { required: true },
  phone: { required: true },
  category: { required: true },
  subcategory: { required: true },
  website: { required: false },
  email: { required: false }
};

// Route to return a list of businesses.
router.get('/', async (req, res) => {
  // Compute page number based on optional query string parameter `page`.
  // Make sure page is within allowed bounds.
  let page = parseInt(req.query.page) || 1;
  const numPerPage = 10;
  const businessesLength = await seqBusiness.count()
  const lastPage = Math.ceil(businessesLength / numPerPage);
  page = page > lastPage ? lastPage : page;
  page = page < 1 ? 1 : page;
  // Calculate starting and ending indices of businesses on requested page and
  // slice out the corresponsing sub-array of busibesses.
  const start = (page - 1) * numPerPage;
  const end = start + numPerPage;
  const pageBusinesses = await seqBusiness.findAll({ offset: start, limit: numPerPage });
  // Generate HATEOAS links for surrounding pages.
  const links = {};
  if (page < lastPage) {
    links.nextPage = `/businesses?page=${page + 1}`;
    links.lastPage = `/businesses?page=${lastPage}`;
  }
  if (page > 1) {
    links.prevPage = `/businesses?page=${page - 1}`;
    links.firstPage = '/businesses?page=1';
  }
  res.status(200).json({
    businesses: pageBusinesses,
    pageNumber: page,
    totalPages: lastPage,
    pageSize: numPerPage,
    totalCount: businessesLength,
    links: links
  });

});

// Route to create a new business.
router.post('/', ejwt({ secret: jwtSecret, algorithms: ['HS256'] }), async (req, res) => {
  if (validation.validateAgainstSchema(req.body, businessSchema)) {
    const business = validation.extractValidFields(req.body, businessSchema);
    if (req.user && parseInt(req.user.id) == parseInt(business.ownerid || req.user.admin == true)) {
      let createResult = await seqBusiness.create(business);
      console.log(createResult.id)
      res.status(201).json({
        id: createResult.id,
        links: {
          business: `/businesses/${createResult.id}`
        }
      })
    } else {
      res.status(401).json({ error: "Not authorized" });
    }
  } else {
    res.status(400).json({ error: "Request body is not a valid business object" });
  }
});

// Route to fetch info about a specific business.
router.get('/:businessid', async (req, res) => {
  const businessid = parseInt(req.params.businessid);
  findResult = await seqBusiness.findByPk(businessid, { include: [seqReview, seqPhoto] })
  if (findResult) {
    res.status(200).json(findResult);
  } else {
    res.status(404).json({ error: `id ${businessid} not found` });
  }
});

// Route to replace data for a business.
router.put('/:businessid', ejwt({ secret: jwtSecret, algorithms: ['HS256'] }), async (req, res) => {
  const businessid = parseInt(req.params.businessid);
  findResult = await seqBusiness.findByPk(businessid)
  if (findResult) {
    if (validation.validateAgainstSchema(req.body, businessSchema)) {
      business = validation.extractValidFields(req.body, businessSchema);
      if (req.user && parseInt(req.user.id) == parseInt(business.ownerid || req.user.admin == true)) {
        findResult.update(business)
        res.status(200).json({
          links: {
            business: `/businesses/${businessid}`
          }
        });
      } else {
        res.status(401).json({ error: "Not authorized" });
      }
    } else {
      res.status(400).json({ error: "Request body is not a valid business object" })
    }

  } else {
    res.status(400).json({ error: `id ${businessid} does not exist` })
  }
});

// Route to delete a business.
router.delete('/:businessid', ejwt({ secret: jwtSecret, algorithms: ['HS256'] }), async (req, res) => {
  const businessid = parseInt(req.params.businessid);
  findResult = await seqBusiness.findByPk(businessid)
  if (findResult) {
    if (req.user && parseInt(req.user.id) == parseInt(findResult.ownerid || req.user.admin == true)) {
      findResult.destroy();
      res.status(204).end();
    } else {
      res.status(401).json({ error: "Not authorized" });
    }
  } else {
    res.status(400).json({ error: `id ${businessid} does not exist` })
  }
});
