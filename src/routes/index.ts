import { getStores } from './../controllers/index.controller';
import {Router} from 'express';

const router = Router();

router.get('/stores', getStores);
router.get('/stores/:id', getStores);
router.post('/stores');

router.get('/users', getStores)
router.get('/users/:id', getStores)
router.post('/stores')

export default router;