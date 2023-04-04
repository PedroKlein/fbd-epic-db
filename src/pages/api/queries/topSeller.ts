import type { NextApiRequest, NextApiResponse } from "next";
import { apiHandler } from "@/utils/api/api.handler";
import DBConnection from "@/db";

export type TopSellerRes = {
  region_id: number;
  name: string;
  product_id: number;
  title: string;
};

async function topSeller(req: NextApiRequest, res: NextApiResponse) {
  const query = `select r.region_id, r.name, p.product_id, p.title
                from regions r
                JOIN products p ON  p.product_id = (
                        select pu.product_id
                        from purchases pu
                        natural join users u
                        where u.region_id = r.region_id
                        group by pu.product_id, u.region_id
                        order by count(*) desc
                        LIMIT 1)`;
  const result = await DBConnection.query(query);
  return res.json(result.rows);
}

export default apiHandler({
  GET: topSeller,
});
