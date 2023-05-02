import 'package:Array_App/bloc/search/item_search_cubit.dart';
import 'package:Array_App/bloc/search/look_search_cubit.dart';
import 'package:Array_App/core/route/route.dart';
import 'package:Array_App/l10n/l10n.dart';
import 'package:Array_App/presentation/screen/home/home_screen.dart';
import 'package:Array_App/presentation/screen/item_profile/item_profile_screen.dart';
import 'package:Array_App/presentation/screen/look_book/look_book_screen.dart';
import 'package:Array_App/presentation/screen/wardrobe/wardrobe_screen.dart';
import 'package:Array_App/presentation/widget/custom_app_bar.dart';
import 'package:Array_App/rest/util/number_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key, this.initialScreenIndex = 0});

  final Object? initialScreenIndex;

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  late int currentScreenIndex;
  final List<Widget> screens = const [
    HomeScreen(),
    LookBookScreen(),
    WardrobeScreen(),
    ItemProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    currentScreenIndex = parseToIntOrDefault(widget.initialScreenIndex);
  }

  // Fallback because CameraScreen appears on top of everything in the stack
  bool isCameraButtonPressed(int index) {
    if (index == 3) {
      AppNavigator.push<AppRoute>(AppRoute.camera);
      return true;
    }
    return false;
  }

  void refreshBloc(BuildContext context, int index) {
    if (index == 1) {
      context.read<LookSearchCubit>().refresh(context);
    }
    if (index == 2) {
      context.read<ItemSearchCubit>().refresh(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: const CustomAppBar(
        height: 0,
      ),
      body: SafeArea(
        child: IndexedStack(
          index: currentScreenIndex,
          children: screens,
        ),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          if (isCameraButtonPressed(index)) return;
          setState(() {
            currentScreenIndex = index;
          });
          refreshBloc(context, index);
        },
        selectedIndex: currentScreenIndex,
        destinations: [
          NavigationDestination(
            selectedIcon: const Icon(Icons.home),
            icon: const Icon(Icons.home_outlined),
            label: l10n.appBarHome,
          ),
          NavigationDestination(
            selectedIcon: const Icon(Icons.book),
            icon: const Icon(Icons.book_outlined),
            label: l10n.appBarLookBook,
          ),
          NavigationDestination(
            selectedIcon: const Icon(Icons.checkroom),
            icon: const Icon(Icons.checkroom_outlined),
            label: l10n.appBarWardrobe,
          ),
          NavigationDestination(
            selectedIcon: const Icon(Icons.add_a_photo),
            icon: const Icon(
              Icons.add_a_photo_outlined,
            ),
            label: l10n.appBarAdd,
          ),
        ],
      ),
    );
  }
}
