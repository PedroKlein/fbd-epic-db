import type { NextApiRequest, NextApiResponse } from "next";
import { apiHandler } from "@/utils/api/api.handler";
import DBConnection from "@/db";

export type InactiveUsersRes = {
  region_id: number;
  name: string;
  user_id: number;
  nickname: string;
};

async function inactiveUsers(req: NextApiRequest, res: NextApiResponse) {
  const query = `select u.user_id, u.nickname, r.region_id, r.name
                from users u
                natural join regions r
                where not exists (
                    select user_id from purchases
                    where purchase_date > CURRENT_TIMESTAMP - interval '1 month' and user_id = u.user_id)`;
  const result = await DBConnection.query(query);
  return res.json(result.rows);
}

export default apiHandler({
  GET: inactiveUsers,
});
