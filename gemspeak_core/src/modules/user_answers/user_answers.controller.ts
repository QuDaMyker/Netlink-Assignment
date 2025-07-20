import { Controller, Get, ParseUUIDPipe, Query } from '@nestjs/common';
import { UserAnswersService } from './user_answers.service';

@Controller('user-answers')
export class UserAnswersController {
  constructor(private readonly userAnswersService: UserAnswersService) {}

  @Get()
  async findAllByUserId(
    @Query('userId', ParseUUIDPipe) userId: string,
    @Query('page') page = 1,
    @Query('limit') limit = 10,
    @Query('sort') sort = 'created_at',
    @Query('order') order: 'asc' | 'desc' = 'desc',
  ) {
    return await this.userAnswersService.findAll(
      userId,
      +page,
      +limit,
      sort,
      order,
    );
  }
}
