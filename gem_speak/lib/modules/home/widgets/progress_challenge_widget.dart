import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gem_speak/common/constant/app_colors.dart';
import 'package:tool_core/models/progress_challenge.dart';

class ProgressChallengeWidget extends StatelessWidget {
  final List<ProgressChallenge> data;
  const ProgressChallengeWidget({super.key, required this.data});

  List<FlSpot> getSpots(
    List<ProgressChallenge> data,
    double Function(ProgressChallenge) selector,
  ) {
    return data.asMap().entries.map((e) {
      return FlSpot(e.key.toDouble(), selector(e.value));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final accuracySpots = getSpots(
      data,
      (e) => double.tryParse(e.accuracy ?? '0') ?? 0,
    );
    final fluencySpots = getSpots(
      data,
      (e) => double.tryParse(e.fluency ?? '0') ?? 0,
    );
    final completenessSpots = getSpots(
      data,
      (e) => double.tryParse(e.completeness ?? '0') ?? 0,
    );
    final pronunciationSpots = getSpots(
      data,
      (e) => double.tryParse(e.pronunciation ?? '0') ?? 0,
    );

    return Container(
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.snow.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.maskGreen.withValues(alpha: 0.8),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 280,
              child: LineChart(
                LineChartData(
                  backgroundColor: AppColors.snow,
                  minY: 0,
                  maxY: 100,
                  gridData: FlGridData(
                    show: true,
                    getDrawingHorizontalLine:
                        (_) => FlLine(color: AppColors.wolf, strokeWidth: 1),
                    drawVerticalLine: false,
                  ),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index < 0 || index >= data.length) {
                            return const SizedBox.shrink();
                          }
                          final date =
                              data[index].progressDate ?? DateTime.now();
                          return Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: Text(
                              '${date.month}/${date.day}',
                              style: TextStyle(
                                fontSize: 10,
                                color: AppColors.textColor,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        interval: 20,
                        getTitlesWidget: (value, _) {
                          return Text(
                            '${value.toInt()}',
                            style: TextStyle(
                              fontSize: 10,
                              color: AppColors.textColor,
                            ),
                          );
                        },
                      ),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  lineBarsData: [
                    _buildLine(accuracySpots, AppColors.macaw, 'Accuracy'),
                    _buildLine(fluencySpots, AppColors.wingOverlay, 'Fluency'),
                    _buildLine(
                      completenessSpots,
                      Colors.orange,
                      'Completeness',
                    ),
                    _buildLine(
                      pronunciationSpots,
                      AppColors.cardinal,
                      'Pronunciation',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: [
                _buildLegend(AppColors.macaw, 'Accuracy'),
                _buildLegend(AppColors.wingOverlay, 'Fluency'),
                _buildLegend(AppColors.beakLower, 'Completeness'),
                _buildLegend(AppColors.cardinal, 'Pronunciation'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  LineChartBarData _buildLine(List<FlSpot> spots, Color color, String label) {
    return LineChartBarData(
      spots: spots,
      isCurved: true,
      color: color,
      barWidth: 2,
      dotData: FlDotData(show: true),
      belowBarData: BarAreaData(show: false),
    );
  }
}
