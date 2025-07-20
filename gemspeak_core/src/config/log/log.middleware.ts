/* eslint-disable @typescript-eslint/no-unsafe-member-access */
/* eslint-disable @typescript-eslint/no-unsafe-call */
/* eslint-disable @typescript-eslint/no-unsafe-assignment */
import { Injectable, Logger, NestMiddleware } from '@nestjs/common';

@Injectable()
export class LogMiddleware implements NestMiddleware {
  private readonly logger = new Logger(LogMiddleware.name);
  use(req: any, res: any, next: () => void) {
    const { method, originalUrl } = req;
    this.logger.verbose(`Request: ${method} ${originalUrl}`);
    const start = Date.now();
    res.on('finish', () => {
      const duration = Date.now() - start;
      this.logger.verbose(
        `Response: ${method} ${originalUrl} - ${res.statusCode} - ${duration}ms`,
      );
    });
    next();
  }
}
