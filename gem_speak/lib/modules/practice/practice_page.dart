import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gem_speak/common/widgets/loading_widget.dart';
import 'package:gem_speak/config/routers/app_router.dart';
import 'package:gem_speak/modules/practice/cubit/practice_cubit.dart';
import 'package:gem_speak/modules/practice/widgets/topic_widget.dart';
import 'package:go_router/go_router.dart';

class PracticePage extends StatelessWidget {
  const PracticePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const Text('Practice'),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: BlocBuilder<PracticeCubit, PracticeState>(
          builder: (context, state) {
            if (state is PracticeLoading) {
              return const Center(child: LoadingWidget());
            } else if (state is PracticeLoaded) {
              return _buildLoadedView(context, state);
            } else if (state is PracticeError) {
              return Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        context.read<PracticeCubit>().fetchTopics();
                      },
                      child: const Text('Try Again'),
                    ),
                    Text(state.message),
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildLoadedView(BuildContext context, PracticeLoaded state) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<PracticeCubit>().fetchTopics();
        },
        child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          physics: BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          itemCount: state.topics.length,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          itemBuilder: (context, index) {
            final topic = state.topics[index];
            return TopicWidget(
              topic: topic,
              onTap: () {
                context.push(RoutePaths.checkPronunciation, extra: topic);
              },
            );
          },
        ),
      ),
    );
  }
}
