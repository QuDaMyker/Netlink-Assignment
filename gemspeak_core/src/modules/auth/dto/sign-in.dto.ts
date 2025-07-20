import { IsString, IsNotEmpty } from 'class-validator';
import { Expose } from 'class-transformer';

export class SignInDto {
  @IsString()
  @IsNotEmpty()
  email: string;

  @IsString()
  @IsNotEmpty()
  fullname: string;

  @IsString()
  @IsNotEmpty()
  @Expose({ name: 'paswword' })
  password: string;
}
