import type { NextApiRequest, NextApiResponse } from "next";
import { apiHandler } from "@/utils/api/api.handler";
import DBConnection from "@/db";

export type InsertPurchaseReq = {
  user_id: number;
  product_id: number;
};

async function insertPurchase(req: NextApiRequest, res: NextApiResponse) {
  const { user_id, product_id }: InsertPurchaseReq = req.body;

  const query = `INSERT INTO purchases (user_id, product_id) VALUES ($1, $2)`;
  await DBConnection.query(query, [user_id || 1, product_id || 1]);

  return res.status(200).end();
}

export default apiHandler({
  POST: insertPurchase,
});
