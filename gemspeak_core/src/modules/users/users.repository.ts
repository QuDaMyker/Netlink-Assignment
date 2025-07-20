import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class UserRepository {
  constructor(private readonly prisma: PrismaService) {}

  async create(data: { email: string; password: string }) {
    return await this.prisma.users.create({
      data: {
        email: data.email,
        password_hash: data.password,
      },
    });
  }

  async findByEmail(email: string) {
    return await this.prisma.users.findUnique({
      where: { email },
    });
  }
}
