import type { NextApiRequest, NextApiResponse } from "next";
import { apiHandler } from "@/utils/api/api.handler";
import DBConnection from "@/db";
import createHttpError from "http-errors";

export type RatingGameRes = {
  game_id: number;
  product_id: number;
  title: string;
  average: number;
};

async function ratingGames(req: NextApiRequest, res: NextApiResponse) {
  const { rating } = req.query;

  if (Array.isArray(rating)) throw new createHttpError.BadRequest();

  const query = `select g.game_id, p.product_id, p.title, avg(r.rating) as average from games g
                natural join reviews r
                natural join products p
                group by g.game_id, p.product_id, p.title
                having avg(r.rating) > $1`;
  const result = await DBConnection.query(query, [rating || 7]);
  return res.json(result.rows);
}

export default apiHandler({
  GET: ratingGames,
});
