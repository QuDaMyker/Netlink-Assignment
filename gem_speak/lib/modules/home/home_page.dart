import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gem_speak/common/constant/app_colors.dart';
import 'package:gem_speak/common/widgets/loading_widget.dart';
import 'package:gem_speak/modules/home/cubit/home_cubit.dart';
import 'package:gem_speak/modules/home/widgets/progress_challenge_widget.dart';
import 'package:gem_speak/modules/home/widgets/summary_item_widget.dart';
import 'package:tool_core/models/top_mistake.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: false,
        scrolledUnderElevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<HomeCubit>().init();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                BlocBuilder<HomeCubit, HomeState>(
                  buildWhen:
                      (previous, current) =>
                          previous.isLoadingSummary != current.isLoadingSummary,
                  builder: (context, state) {
                    return _buildSummary(context, state);
                  },
                ),
                BlocBuilder<HomeCubit, HomeState>(
                  buildWhen:
                      (previous, current) =>
                          previous.isLoadingTopMistakes !=
                          current.isLoadingTopMistakes,
                  builder: (context, state) {
                    if (state.isLoadingTopMistakes == false &&
                        state.topMistake == null) {
                      return const SizedBox.shrink();
                    }
                    return _buildTopMistake(context, state);
                  },
                ),
                BlocBuilder<HomeCubit, HomeState>(
                  buildWhen:
                      (previous, current) =>
                          previous.isLoadingProgressChallenges !=
                          current.isLoadingProgressChallenges,
                  builder: (context, state) {
                    return _buildProgressOvertime(state);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressOvertime(HomeState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Progress Over Time',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          if (state.isLoadingProgressChallenges)
            const Center(child: LoadingWidget(backgroundColor: AppColors.snow))
          else ...[
            const SizedBox(height: 12),
            ProgressChallengeWidget(data: state.progressChallenges ?? []),
          ],
        ],
      ),
    );
  }

  Widget _buildTabViewMistake(BuildContext context, TopMistake topMistake) {
    return SizedBox(
      height: 550,
      child: Column(
        children: [
          TabBar(
            controller: tabController,
            labelColor: AppColors.greenShader,
            indicatorColor: AppColors.macaw,
            tabs: const [Tab(text: 'Words'), Tab(text: 'Phonemes')],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: IntrinsicHeight(
              child: TabBarView(
                controller: tabController,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        if (topMistake.wordMistakes?.isNotEmpty ?? false)
                          ...topMistake.wordMistakes!.map(
                            (word) =>
                                _buildWordItem(word.word, word.mistakeCount),
                          ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        if (topMistake.phonemeMistakes?.isNotEmpty ?? false)
                          ...topMistake.phonemeMistakes!.map(
                            (phoneme) => _buildWordItem(
                              phoneme.phoneme,
                              phoneme.mistakeCount,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopMistake(BuildContext context, HomeState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Text(
            'Top Mistakes',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          if (state.isLoadingTopMistakes)
            const Center(child: LoadingWidget(backgroundColor: AppColors.snow))
          else
            _buildTabViewMistake(context, state.topMistake!),
        ],
      ),
    );
  }

  Widget _buildSummary(BuildContext context, HomeState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Summary',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          if (state.isLoadingSummary)
            const Center(child: LoadingWidget(backgroundColor: AppColors.snow))
          else
            Column(
              children: [
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: SummaryItemWidget(
                          height: 200,
                          title: 'Questions',
                          progress:
                              state.summaryLearning?.totalAnswers?.toDouble() ??
                              0.0,
                          backgroundColor: AppColors.maskGreen,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: SummaryItemWidget(
                          height: 200,
                          title: 'Fluency',
                          progress:
                              state
                                  .summaryLearning
                                  ?.averageScore
                                  ?.fluencyScore ??
                              0.0,
                          backgroundColor: AppColors.macaw,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: SummaryItemWidget(
                          height: 200,
                          title: 'Accuracy',
                          progress:
                              state
                                  .summaryLearning
                                  ?.averageScore
                                  ?.accuracyScore ??
                              0.0,
                          backgroundColor: AppColors.tonguePink,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: SummaryItemWidget(
                          height: 200,
                          title: 'Completeness',
                          progress:
                              state
                                  .summaryLearning
                                  ?.averageScore
                                  ?.completenessScore ??
                              0.0,
                          backgroundColor: AppColors.fox,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildWordItem(String word, int accuracyScore) {
    final Color wordColor = switch (accuracyScore) {
      null => AppColors.cardinal,
      > 85 => AppColors.featherGreen,
      > 70 => AppColors.beetle,
      > 50 => AppColors.cardinal,
      _ => AppColors.cardinal,
    };
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.snow.withAlpha(200),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: wordColor.withAlpha(200),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            word,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Row(children: [Text('Score: $accuracyScore')]),
          const SizedBox(height: 6),
        ],
      ),
    );
  }
}
