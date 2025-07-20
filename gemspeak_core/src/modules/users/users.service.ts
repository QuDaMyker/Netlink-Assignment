import { Injectable } from '@nestjs/common';
import { UserRepository } from './users.repository';

@Injectable()
export class UsersService {
  constructor(private readonly usersRepository: UserRepository) {}
  async findByEmail(email: string) {
    return await this.usersRepository.findByEmail(email);
  }

  async createUser(data: { email: string; password: string }) {
    return await this.usersRepository.create(data);
  }
}
