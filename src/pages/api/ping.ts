// Next.js API route support: https://nextjs.org/docs/api-routes/introduction
import type { NextApiRequest, NextApiResponse } from "next";
import DBConnection from "@/db";
import { apiHandler } from "@/utils/api/api.handler";

type Data = {
  message: string;
  time: string;
};

async function ping(req: NextApiRequest, res: NextApiResponse<Data>) {
  const result = await DBConnection.query("SELECT NOW()");
  res.status(200).json({ message: "Pong!", time: result.rows[0].now });
}

export default apiHandler({
  GET: ping,
});
