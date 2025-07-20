import { MiddlewareConsumer, Module, NestModule } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { FeedbackModule } from './modules/feedback/feedback.module';
import { GeminiService } from './modules/gemini/gemini.service';
import { MulterModule } from '@nestjs/platform-express';
import { LogMiddleware } from './config/log/log.middleware';
import { SpeakingTopicsModule } from './modules/speaking_topics/speaking_topics.module';
import { QuestionsModule } from './modules/questions/questions.module';
import { PrismaModule } from './prisma/prisma.module';
import { PronnciationAssessmentAzureModule } from './modules/pronnciation_assessment_azure/pronnciation_assessment_azure.module';
import { HelloWorldModule } from './modules/hello_world/hello_world.module';
import { UserAnswersModule } from './modules/user_answers/user_answers.module';
import { AudioAssessmentsModule } from './modules/audio_assessments/audio_assessments.module';
import { AudioWordsModule } from './modules/audio_words/audio_words.module';
import { AudioSyllablesModule } from './modules/audio_syllables/audio_syllables.module';
import { AudioPhonemesModule } from './modules/audio_phonemes/audio_phonemes.module';
import { UsersModule } from './modules/users/users.module';
import { UserStatsModule } from './modules/user_stats/user_stats.module';
import { AuthModule } from './modules/auth/auth.module';
import { ConfigModule } from '@nestjs/config';

@Module({
  imports: [
    FeedbackModule,
    MulterModule.register({
      dest: './uploads',
    }),
    ConfigModule.forRoot({
      isGlobal: true,
    }),
    SpeakingTopicsModule,
    QuestionsModule,
    PrismaModule,
    PronnciationAssessmentAzureModule,
    HelloWorldModule,
    UserAnswersModule,
    AudioAssessmentsModule,
    AudioWordsModule,
    AudioSyllablesModule,
    AudioPhonemesModule,
    UsersModule,
    UserStatsModule,
    AuthModule,
  ],
  controllers: [AppController],
  providers: [AppService, GeminiService],
})
export class AppModule implements NestModule {
  configure(consumer: MiddlewareConsumer) {
    consumer.apply(LogMiddleware).forRoutes('*');
  }
}
