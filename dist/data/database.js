"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.pool = void 0;
const pg_1 = require("pg");
//Server=tcp:caribechallenge.database.windows.net,1433;Initial Catalog=challenge;Persist Security Info=False;User ID=developer;Password={your_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;
exports.pool = new pg_1.Pool({
    user: 'postgres',
    host: 'localhost',
    password: '',
    database: 'caribechallenge',
    port: 5432
});
