import type { NextApiRequest, NextApiResponse } from "next";
import { apiHandler } from "@/utils/api/api.handler";
import DBConnection from "@/db";
import createHttpError from "http-errors";

export type PriceProductsRes = {
    region_id: number;
    product_id: number;
    product_title: string;
    region_name: string;
    price: number;
};

async function priceProducts(req: NextApiRequest, res: NextApiResponse) {
  const { price, region_id } = req.query;

  if (Array.isArray(price) || Array.isArray(region_id))
    throw new createHttpError.BadRequest();

  const query = `select dp.region_id, dp.product_id, pr.title as product_title, r.name as region_name, net_price as price
                from discounted_prices dp 
                natural join products pr
                natural join regions r
                where dp.net_price > $1
                and dp.region_id = $2`;
  const result = await DBConnection.query(query, [price || 80, region_id || 1]);
  return res.json(result.rows);
}

export default apiHandler({
  GET: priceProducts,
});
