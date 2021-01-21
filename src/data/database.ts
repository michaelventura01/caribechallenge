import { Pool } from 'pg';

//Server=tcp:caribechallenge.database.windows.net,1433;Initial Catalog=challenge;Persist Security Info=False;User ID=developer;Password={your_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;
export const pool = new Pool({
    user: 'postgres',
    host:'localhost',
    password: '',
    database: 'caribechallenge',    
    port: 5432
});
