import { Controller, Get } from '@nestjs/common';
import { Public } from '../auth/decorator/public.decorator';
import { ApiExcludeController } from '@nestjs/swagger';

@ApiExcludeController()
@Controller('hello-world')
export class HelloWorldController {
  @Public()
  @Get()
  findAll() {
    return 'hello world';
  }
}
