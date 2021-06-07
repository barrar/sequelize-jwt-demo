const router = module.exports = require('express').Router();
require('./seq');

global.ejwt = require('express-jwt')
global.jwt = require('jsonwebtoken')
global.jwtSecret = "hegeon4ebnjk5tsn9wg0"

router.use('/businesses', require('./businesses').router);
router.use('/reviews', require('./reviews').router);
router.use('/photos', require('./photos').router);
router.use('/users', require('./users').router);
