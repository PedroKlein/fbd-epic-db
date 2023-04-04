import type { NextApiRequest, NextApiResponse } from "next";
import { apiHandler } from "@/utils/api/api.handler";
import DBConnection from "@/db";

export type AllMediasRes = {
  game_id: number;
  product_id: number;
  url: string;
};

async function allMedias(req: NextApiRequest, res: NextApiResponse) {
  const query = `select g.game_id, p.product_id, m.url
                from medias m
                natural join products p
                natural join games g
                where p.type = 'GAME'`;
  const result = await DBConnection.query(query);
  return res.json(result.rows);
}

export default apiHandler({
  GET: allMedias,
});
