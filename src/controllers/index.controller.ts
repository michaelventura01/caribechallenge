import { Request, Response } from 'express';
import { QueryResult } from 'pg';
import { pool } from '../data/database';
export const getStores = async (req: Request, res: Response) => {
    const response : QueryResult = await pool.query('select * from seeusersvw');
    console.log(response.rows);
    res.send("mandado");
}