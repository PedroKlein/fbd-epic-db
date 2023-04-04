import { Pool } from "pg";

let DBConnection!: Pool;

if (!DBConnection) {
  DBConnection = new Pool({
    user: process.env.PGSQL_USER,
    password: process.env.PGSQL_PASSWORD,
    host: process.env.PGSQL_HOST,
    port: process.env.PGSQL_PORT ? +process.env.PGSQL_PORT : 54320,
    database: process.env.PGSQL_DATABASE,
  });
}

export default DBConnection as Pool;
