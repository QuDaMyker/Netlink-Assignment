/* eslint-disable @typescript-eslint/no-unsafe-return */
import { Body, Controller, Post } from '@nestjs/common';
import { AuthService } from './auth.service';
import { SignInDto } from './dto/sign-in.dto';
import { Public } from './decorator/public.decorator';

@Public()
@Controller('auth')
export class AuthController {
  jwtService: any;
  constructor(private readonly authService: AuthService) {}

  @Post('sign-in')
  async signIn(@Body() signInDto: SignInDto) {
    const { email, password } = signInDto;
    return await this.authService.signIn(email, password);
  }

  @Post('refresh-tokens')
  async refreshTokens(@Body('refresh_token') refreshToken: string) {
    return await this.authService.refreshTokens(refreshToken);
  }

  @Post('validate-token')
  async checkToken(@Body('access_token') accessToken: string) {
    return await this.authService.validateAccessToken(accessToken);
  }
}
