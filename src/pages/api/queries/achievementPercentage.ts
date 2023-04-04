import type { NextApiRequest, NextApiResponse } from "next";
import { apiHandler } from "@/utils/api/api.handler";
import DBConnection from "@/db";
import createHttpError from "http-errors";

export type AchievementPercentageRes = {
  name: string;
  percentage: number;
};

async function achievementPercentage(
  req: NextApiRequest,
  res: NextApiResponse
) {
  const { game_id } = req.query;

  if (Array.isArray(game_id)) throw new createHttpError.BadRequest();

  const query = `select a.name, count(*)::decimal/sub.total as percentage
                from achievements a
                natural join trophies t
                natural join users u
                natural join 
                    (select count(*) as total, l.game_id 
                    from library l 
                    group by l.game_id) sub
                where a.game_id = $1
                group by a.name, sub.total`;
  const result = await DBConnection.query(query, [game_id || 1]);
  return res.json(result.rows);
}

export default apiHandler({
  GET: achievementPercentage,
});
