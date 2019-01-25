import * as express from 'express';
import { greetingRouter } from './routes/greetingRouter';

export default function(app = express()): express.Application {
  app.use('/greeting', greetingRouter());

  return app;
}