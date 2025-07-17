import { MiddlewareConsumer, Module, NestModule } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { FeedbackModule } from './modules/feedback/feedback.module';
import { GeminiService } from './modules/gemini/gemini.service';
import { MulterModule } from '@nestjs/platform-express';
import { LogMiddleware } from './config/log/log.middleware';

@Module({
  imports: [FeedbackModule,
    MulterModule.register({
      dest: './uploads',
    }),
  ],
  controllers: [AppController],
  providers: [AppService, GeminiService],
})
export class AppModule implements NestModule {
  configure(consumer: MiddlewareConsumer) {
    consumer
      .apply(LogMiddleware)
      .forRoutes('*');
  }
}
