/* eslint-disable @typescript-eslint/no-unsafe-assignment */
/* eslint-disable @typescript-eslint/no-unsafe-argument */

/* eslint-disable @typescript-eslint/no-unsafe-member-access */
/* eslint-disable @typescript-eslint/no-unsafe-call */
/* eslint-disable @typescript-eslint/no-unsafe-return */
import * as bcrypt from 'bcrypt';
import { Injectable, Logger, UnauthorizedException } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { AuthRepository } from './repository/auth.repository';
import { UsersService } from '../users/users.service';

@Injectable()
export class AuthService {
  constructor(
    private readonly usersService: UsersService,
    private readonly jwtService: JwtService,
    private readonly authRepository: AuthRepository,
  ) {}

  private readonly logger = new Logger(AuthService.name);

  async signIn(email: string, password: string): Promise<any> {
    try {
      let user = await this.usersService.findByEmail(email);

      if (user == null) {
        const hashedPassword = await this.hashPassword(password);
        user = await this.usersService.createUser({
          email,
          password: hashedPassword,
        });
      }

      const isValid = await this.comparePassword(password, user.password_hash);
      if (!isValid) {
        throw new UnauthorizedException('Invalid email or password');
      }

      const payload = { userId: user.id, email: user.email };
      const accessToken = await this.signToken(payload, '1h');
      const refreshToken = await this.signToken(payload, '7d');

      return {
        user: {
          id: user.id,
          email: user.email,
          created_at: user.create_at,
        },
        access_token: accessToken,
        refresh_token: refreshToken,
      };
    } catch (error) {
      this.logger.error('Error signing in', error);
      throw new UnauthorizedException('Invalid email or password');
    }
  }

  private async hashPassword(password: string): Promise<string> {
    const saltRounds = 10;
    return await bcrypt.hash(password, saltRounds);
  }

  private async comparePassword(
    plain: string,
    hashed: string,
  ): Promise<boolean> {
    return await bcrypt.compare(plain, hashed);
  }

  private async signToken(payload: any, expiresIn: string): Promise<string> {
    return await this.jwtService.signAsync(payload, {
      expiresIn,
      algorithm: 'HS256',
      secret: process.env.JWT_SECRET,
      notBefore: '0s',
    });
  }

  private async verifyToken(token: string): Promise<any> {
    return await this.jwtService.verifyAsync(token, {
      secret: process.env.JWT_SECRET,
    });
  }

  async refreshTokens(refreshToken: string): Promise<any> {
    try {
      const decoded = await this.verifyToken(refreshToken);

      const { userId, email } = decoded;

      const payload = { userId, email };
      const newAccessToken = await this.signToken(payload, '1h');

      return {
        access_token: newAccessToken,
      };
    } catch {
      throw new UnauthorizedException('Invalid or expired refresh token');
    }
  }

  async validateAccessToken(accessToken: string): Promise<any> {
    try {
      await this.jwtService.verifyAsync(accessToken, {
        secret: process.env.JWT_SECRET,
      });

      return true;
    } catch {
      throw new UnauthorizedException('Invalid or expired access token');
    }
  }
}
