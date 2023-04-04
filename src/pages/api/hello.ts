// Next.js API route support: https://nextjs.org/docs/api-routes/introduction
import type { NextApiRequest, NextApiResponse } from "next";
import DBConnection from "../../db";

type Data = {
  name: string;
};

export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse<Data>
) {
  try {
    console.log("req nom", req.body);
    const query = "SELECT * from users";
    const result = await DBConnection.query(query);
    console.log("ttt", result.rows);
  } catch (error) {
    console.log(error);
  }
}
