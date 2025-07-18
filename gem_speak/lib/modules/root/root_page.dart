import 'package:flutter/material.dart';
import 'package:gem_speak/modules/home/home_page.dart';
import 'package:gem_speak/modules/practice/practice_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage>
    with SingleTickerProviderStateMixin {
  final List<Widget> pages = const [
    HomePage(),
    PracticePage(),
    Center(child: Text('Profile Page')),
  ];
  final _currentIndex = ValueNotifier<int>(0);
  late final TabController _tabController = TabController(
    length: 3,
    vsync: this,
  );

  @override
  void initState() {
    // final layoutService = getIt<LayoutService>();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: pages,
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: _currentIndex,
        builder: (context, index, child) {
          return BottomNavigationBar(
            currentIndex: index,
            onTap: (newIndex) {
              _currentIndex.value = newIndex;
              _tabController.index = newIndex;
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
}
