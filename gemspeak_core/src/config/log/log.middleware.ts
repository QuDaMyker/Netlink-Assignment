import { Injectable, NestMiddleware } from '@nestjs/common';

@Injectable()
export class LogMiddleware implements NestMiddleware {
  use(req: any, res: any, next: () => void) {
    const { method, originalUrl } = req;
    console.log(`Request: ${method} ${originalUrl}`);
    const start = Date.now();
    res.on('finish', () => {
      const duration = Date.now() - start;
      console.log(`Response: ${method} ${originalUrl} - ${res.statusCode} - ${duration}ms`);
    });
    next();
  }
}
