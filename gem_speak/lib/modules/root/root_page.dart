import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gem_speak/locator.dart';
import 'package:gem_speak/modules/home/cubit/home_cubit.dart';
import 'package:gem_speak/modules/home/home_page.dart';
import 'package:gem_speak/modules/practice/cubit/practice_cubit.dart';
import 'package:gem_speak/modules/practice/practice_page.dart';
import 'package:gem_speak/modules/profile/cubit/profile_cubit.dart';
import 'package:gem_speak/modules/profile/profile_page.dart';
import 'package:gem_speak/modules/root/cubit/root_cubit.dart';
import 'package:tool_core/repositories/i_user_repository.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage>
    with SingleTickerProviderStateMixin {
  final List<Widget> pages = const [HomePage(), PracticePage(), ProfilePage()];
  final _currentIndex = ValueNotifier<int>(0);
  late final TabController _tabController = TabController(
    length: 3,
    vsync: this,
  );

  final userRepository = getIt<IUserRepository>();
  late final PracticeCubit practiceCubit;
  late final ProfileCubit profileCubit;
  late final HomeCubit homeCubit;

  @override
  void initState() {
    practiceCubit = PracticeCubit(userRepository)..fetchTopics();
    profileCubit = ProfileCubit(userRepository)..fetchUserAnswers();
    homeCubit = HomeCubit(userRepository)..init();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => RootCubit()),
        BlocProvider.value(value: homeCubit),
        BlocProvider.value(value: practiceCubit),
        BlocProvider.value(value: profileCubit),
      ],
      child: _buildScaffold(context),
    );
  }

  Widget _buildScaffold(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: pages,
        ),
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: _currentIndex,
        builder: (context, index, child) {
          return BottomNavigationBar(
            currentIndex: index,
            onTap: (newIndex) {
              onClickButtonNavigation(newIndex, context);
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'Practice',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          );
        },
      ),
    );
  }

  onClickButtonNavigation(int index, BuildContext context) {
    _currentIndex.value = index;
    _tabController.index = index;
    if (index == 0) {
      homeCubit.init();
    } else if (index == 1) {
      practiceCubit.fetchTopics();
    } else if (index == 2) {
      profileCubit.fetchUserAnswers();
    }
  }
}
