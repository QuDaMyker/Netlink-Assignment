import { Controller, Get, Param, ParseUUIDPipe } from '@nestjs/common';
import { UserStatsService } from './user_stats.service';

@Controller('user-stats')
export class UserStatsController {
  constructor(private readonly userStatsService: UserStatsService) {}
  @Get(':userId/summary')
  async getSummaryByUserId(@Param('userId', ParseUUIDPipe) userId: string) {
    return await this.userStatsService.getSummaryByUserId(userId);
  }

  @Get(':userId/progress')
  async getProgress(@Param('userId') userId: string) {
    return await this.userStatsService.getScoreAverageDayByUserId(userId);
  }

  @Get(':userId/top-mistakes')
  async getTopMistakesByUserId(@Param('userId', ParseUUIDPipe) userId: string) {
    return await this.userStatsService.getTopMistakesByUserId(userId);
  }
}
