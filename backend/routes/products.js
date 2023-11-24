const router=require('express').Router();
const { default: mongoose } = require('mongoose');
const productController=require('../controllers/productsControllers')

router.get('/',productController.getAllProducts);
router.get('/:id',productController.getProduct);
router.get('/search/:key',productController.searchProducts);
router.post('/',productController.createProduct)

module.exports= router;