import createHttpError from "http-errors";
import { NextApiRequest, NextApiResponse } from "next";
import { ApiMethodHandlers, ErrorResponse } from "./types";
import { errorHandler } from "./error.handler";

export function apiHandler(handler: ApiMethodHandlers) {
  return async (req: NextApiRequest, res: NextApiResponse<ErrorResponse>) => {
    try {
      const method = req.method
        ? (req.method.toUpperCase() as keyof ApiMethodHandlers)
        : undefined;

      if (!method)
        throw new createHttpError.MethodNotAllowed(
          `No method specified on path ${req.url}!`
        );

      const methodHandler = handler[method];
      if (!methodHandler)
        throw new createHttpError.MethodNotAllowed(
          `Method ${req.method} Not Allowed on path ${req.url}!`
        );

      return methodHandler(req, res);
    } catch (err) {
      return errorHandler(err, res);
    }
  };
}
