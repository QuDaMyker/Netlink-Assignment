import { Module } from '@nestjs/common';
import { HelloWorldService } from './hello_world.service';
import { HelloWorldController } from './hello_world.controller';

@Module({
  controllers: [HelloWorldController],
  providers: [HelloWorldService],
})
export class HelloWorldModule {}
