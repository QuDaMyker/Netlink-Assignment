import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gem_speak/common/constant/app_assets.dart';
import 'package:gem_speak/common/constant/app_colors.dart';
import 'package:gem_speak/common/widgets/loading_widget.dart';
import 'package:gem_speak/config/routers/app_router.dart';
import 'package:gem_speak/core/auth/bloc/auth_bloc.dart';
import 'package:gem_speak/modules/profile/cubit/profile_cubit.dart';
import 'package:gem_speak/modules/profile/widgets/user_answer_widget.dart';
import 'package:gem_speak/utils/extension/datetime_utils.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello Hero'),
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfo(context),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Your Challenges',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.humpback,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              Expanded(
                child: BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    if (state is ProfileLoading) {
                      return const Center(child: LoadingWidget());
                    } else if (state is ProfileLoaded) {
                      return RefreshIndicator(
                        onRefresh: () async {
                          context.read<ProfileCubit>().fetchUserAnswers();
                        },
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics(),
                          ),
                          itemCount: state.userAnswers.length,
                          itemBuilder: (context, index) {
                            final userAnswer = state.userAnswers[index];
                            return Builder(
                              builder: (innerContext) {
                                return UserAnswerWidget(
                                  userAnswer: userAnswer,
                                  onTap: () {
                                    innerContext.push(
                                      RoutePaths.reviewAnswer,
                                      extra: userAnswer,
                                    );
                                  },
                                );
                              },
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 2);
                          },
                        ),
                      );
                    } else if (state is ProfileError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(state.message),
                            ElevatedButton(
                              onPressed: () {
                                context.read<ProfileCubit>().fetchUserAnswers();
                              },
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildInfo(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.snow.withAlpha(200),
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(color: AppColors.maskGreen, width: 1),
          bottom: BorderSide(color: AppColors.maskGreen, width: 6),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.maskGreen.withAlpha(200),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: AppColors.snow,
            child: Lottie.asset(
              AppAssets.owlBirdAvatar,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    (context.read<AuthBloc>().state as AuthAuthenticated)
                        .userAuth
                        .email,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.humpback,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Joined: ${(context.read<AuthBloc>().state as AuthAuthenticated).userAuth.createdAt?.eeeddmmyyyy()}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.eel,
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(LoggedOut());
            },
            icon: Icon(Icons.logout, color: AppColors.humpback, size: 24),
          ),
        ],
      ),
    );
  }
}
