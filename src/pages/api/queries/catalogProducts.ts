import type { NextApiRequest, NextApiResponse } from "next";
import { apiHandler } from "@/utils/api/api.handler";
import DBConnection from "@/db";
import createHttpError from "http-errors";

export type CatalogProductsRes = {
  region_id: number;
    currency_symbol: string;
    price: number;
    net_price: number;
    discount: number;
    end_date: Date;
    title: string;
    type: string;
};

async function catalogProducts(req: NextApiRequest, res: NextApiResponse) {
  const { user_id } = req.query;

  if (Array.isArray(user_id)) throw new createHttpError.BadRequest();

  const query = `select r.region_id, r.currency_symbol, dp.price, dp.net_price,dp.discount, dp.end_date, p.title, p.type
                from users u 
                natural join regions r
                natural join discounted_prices dp
                natural join products p
                where u.user_id = $1`;
  const result = await DBConnection.query(query, [user_id || 13]);
  return res.json(result.rows);
}

export default apiHandler({
  GET: catalogProducts,
});
