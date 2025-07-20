import { Module } from '@nestjs/common';
import { HelloWorldController } from './hello_world.controller';

@Module({
  controllers: [HelloWorldController],
})
export class HelloWorldModule {}
