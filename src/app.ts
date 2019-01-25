import * as express from 'express';
import * as compression from 'compression';
import * as cors from 'cors';
import * as bodyParser from 'body-parser';
import * as awsServerlessExpressMiddleware from 'aws-serverless-express/middleware';
import { greetingRouter } from './routes/greetingRouter';

export default function(app = express()): express.Application {
  app.use(compression());
  app.use(cors());
  app.use(bodyParser.json({ strict: false }));
  app.use(bodyParser.urlencoded({ extended: true }));
  app.use(awsServerlessExpressMiddleware.eventContext());

  app.use('/greeting', greetingRouter());

  return app;
}