import { Router, Request, Response } from "express";

export function greetingRouter(router: Router = Router()) {
  router.get('/', (req: Request, rsp: Response) => {
    const name = req.query && req.query.name ? req.query.name : 'John Doe';
    rsp.status(200).json({ message: `Well hello, ${name}!`});
  });
  return router;
}