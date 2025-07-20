import { PartialType } from '@nestjs/mapped-types';
import { CreateHelloWorldDto } from './create-hello_world.dto';

export class UpdateHelloWorldDto extends PartialType(CreateHelloWorldDto) {}
