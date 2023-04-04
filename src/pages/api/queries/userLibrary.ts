import type { NextApiRequest, NextApiResponse } from "next";
import { apiHandler } from "@/utils/api/api.handler";
import DBConnection from "@/db";
import createHttpError from "http-errors";

export type UserLibraryRes = {
  title: string;
  cover_img: string;
  favourite: string;
};

async function userLibrary(req: NextApiRequest, res: NextApiResponse) {
  const { user_id } = req.query;

  if (Array.isArray(user_id)) throw new createHttpError.BadRequest();

  const query = `SELECT title, cover_img, favourite 
                FROM users NATURAL JOIN library NATURAL JOIN games NATURAL JOIN products
                WHERE user_id = $1;`;
  const result = await DBConnection.query(query, [user_id || 1]);
  return res.json(result.rows);
}

export default apiHandler({
  GET: userLibrary,
});
