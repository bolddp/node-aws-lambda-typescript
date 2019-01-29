import { Router, Request, Response } from "express";
import greetingService from "../service/greetingService";

export function greetingRouter(router: Router = Router()) {
  router.get('/', (req: Request, rsp: Response) => {
    rsp.status(200).send(greetingService.getGreetingMessage(req.query.name));
  });
  return router;
}