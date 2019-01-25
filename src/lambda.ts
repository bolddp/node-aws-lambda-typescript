import * as awsServerlessExpress from 'aws-serverless-express';
import app from './app';
import { Context } from 'aws-lambda';

const binaryMimeTypes: string[] = [
  'application/javascript',
  'application/json',
  'application/octet-stream',
  'application/xml',
  'font/eot',
  'font/opentype',
  'font/otf',
  'image/jpeg',
  'image/png',
  'image/svg+xml',
  'text/comma-separated-values',
  'text/css',
  'text/html',
  'text/javascript',
  'text/plain',
  'text/text',
  'text/xml'
]

const server = awsServerlessExpress.createServer(app(), null, binaryMimeTypes);

export const handler = (event = {}, context: Context) => {
  awsServerlessExpress.proxy(server, event, context);
};