import { Injectable, OnModuleInit, OnModuleDestroy } from '@nestjs/common';
import { PrismaClient } from '@prisma/client';
// import { PrismaClient } from 'generated/prisma';
// const PrismaClient =
//   process.env.NODE_ENV === 'production'
//     ? require('@prisma/client').PrismaClient
//     : require('generated/prisma').PrismaClient;

@Injectable()
export class PrismaService
  extends PrismaClient
  implements OnModuleInit, OnModuleDestroy
{
  async onModuleInit() {
    await this.$connect();
  }

  async onModuleDestroy() {
    await this.$disconnect();
  }
}
