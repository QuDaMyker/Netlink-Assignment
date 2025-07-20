import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
} from '@nestjs/common';
import { HelloWorldService } from './hello_world.service';
import { CreateHelloWorldDto } from './dto/create-hello_world.dto';
import { UpdateHelloWorldDto } from './dto/update-hello_world.dto';
import { Public } from '../auth/decorator/public.decorator';

@Controller('hello-world')
export class HelloWorldController {
  constructor(private readonly helloWorldService: HelloWorldService) {}

  @Post()
  create(@Body() createHelloWorldDto: CreateHelloWorldDto) {
    return this.helloWorldService.create(createHelloWorldDto);
  }

  @Public()
  @Get()
  findAll() {
    return 'hello world';
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.helloWorldService.findOne(+id);
  }

  @Patch(':id')
  update(
    @Param('id') id: string,
    @Body() updateHelloWorldDto: UpdateHelloWorldDto,
  ) {
    return this.helloWorldService.update(+id, updateHelloWorldDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.helloWorldService.remove(+id);
  }
}
