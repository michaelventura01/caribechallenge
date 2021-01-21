import express from "express";
import indexRoute from './routes/index';

const app = express();

//middlewares
app.use(express.json());
app.use(express.urlencoded({extended: false}));

app.use(indexRoute);
app.listen(3000);