import type { NextApiRequest, NextApiResponse } from "next";
import { apiHandler } from "@/utils/api/api.handler";
import DBConnection from "@/db";
import createHttpError from "http-errors";

export type GameCompleteRes = {
  game_id: number;
  title: string;
  developer: string;
  publisher: string;
  feature_name: string;
  genre_name: string;
  achievement_name: string;
  os: string;
};

async function gameComplete(req: NextApiRequest, res: NextApiResponse) {
  const { bundle_id: game_id } = req.query;

  if (Array.isArray(game_id)) throw new createHttpError.BadRequest();

  const query = `select p.title, g.*, f.name as feature_name, ge.name as genre_name, a.name as achievement_name, r.os
                from games g
                natural join products p
                inner join classifications c on c.game_id = g.game_id
                inner join features f on f.feature_id = c.feature_id
                inner join categories ca on ca.game_id = g.game_id
                inner join genres ge on ge.genre_id = ca.genre_id
                inner join achievements a on a.game_id = g.game_id
                inner join requirements r on r.game_id = g.game_id
                where g.game_id = $1`;
  const result = await DBConnection.query(query, [game_id || 1]);
  return res.json(result.rows);
}

export default apiHandler({
  GET: gameComplete,
});
