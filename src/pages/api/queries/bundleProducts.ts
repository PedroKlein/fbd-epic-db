import type { NextApiRequest, NextApiResponse } from "next";
import { apiHandler } from "@/utils/api/api.handler";
import DBConnection from "@/db";
import createHttpError from "http-errors";

export type BundleProductsRes = {
  bundle_id: number;
  product_id: number;
  title: string;
  type: string;
};

async function bundleProducts(req: NextApiRequest, res: NextApiResponse) {
  const { bundle_id } = req.query;

  if (Array.isArray(bundle_id)) throw new createHttpError.BadRequest();

  const query = `select pa.bundle_id, pr.product_id, pr.title, pr.type 
                from packages pa
                inner join products pr on pr.product_id = pa.product_id
                inner join bundles b on b.product_id = pa.bundle_id
                where pa.bundle_id = $1;`;
  const result = await DBConnection.query(query, [bundle_id || 13]);
  return res.json(result.rows);
}

export default apiHandler({
  GET: bundleProducts,
});
