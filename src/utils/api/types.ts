import { Method } from "axios";
import { NextApiHandler } from "next";

export interface ErrorResponse {
  error: {
    message: string;
    err?: any;
  };
  status?: number;
}

export type ApiMethodHandlers = {
  [key in Uppercase<Method>]?: NextApiHandler;
};
