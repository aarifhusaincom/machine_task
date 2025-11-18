import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../providers/user_navigation_provider.dart';
import '../../widgets/my_drawer.dart';
import 'navigation/home_nav_body.dart';

class NavScreen extends StatelessWidget {
  const NavScreen({super.key});

  static const List<Widget> _pages = [
    UserHomeScreenBody(),
    UserHomeScreenBody(),
    UserHomeScreenBody(),
    UserHomeScreenBody(),
    UserHomeScreenBody(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const MyDrawer(),
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: SvgPicture.asset("assets/icons/menu-variant.svg")),
        title: SvgPicture.asset("assets/icons/app_bar_title.svg"),
        centerTitle: true,

        /// action button
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('assets/icons/search.svg'),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('assets/icons/scan.svg'),
          ),
        ],
      ),
      body: Consumer<UserNavigationProvider>(
        builder: (context, userNavigationProvider, child) {
          return _pages[userNavigationProvider.currentIndex];
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: context.watch<UserNavigationProvider>().currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.orange,
        selectedLabelStyle:
            // Theme.of(context).textTheme.labelMedium,
            const TextStyle(
          color: Colors.orange,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: const TextStyle(color: Colors.black87),
        unselectedItemColor: Colors.black87,
        onTap: (index) {
          // Provider.of<UserNavigationProvider>(
          //   context,
          //   listen: false,
          // ).setCurrentIndex(index);
          context.read<UserNavigationProvider>().setCurrentIndex(index);
        },
        showUnselectedLabels: true,
        items: [
          _buildNavItem(context, Icons.home, "Home", 0),
          _buildNavItem(context, Icons.category, "Category", 1),
          _buildNavItem(context, Icons.message, "Message", 2),
          _buildNavItem(context, Icons.add_shopping_cart_outlined, "Cart", 3),
          _buildNavItem(context, Icons.person, "Profile", 4),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
    BuildContext context,
    IconData icon,
    String label,
    int index,
  ) {
    final bool isActive =
        context.watch<UserNavigationProvider>().currentIndex == index;

    // print(
    //   "Current index is ${context.watch<UserNavigationProvider>().currentIndex}. and isActive = $isActive",
    // );
    return BottomNavigationBarItem(
      icon: Container(
        padding: const EdgeInsets.fromLTRB(6, 16, 6, 16),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          // color: isActive ? const Color(0xFFFEE4D3) : Colors.transparent,
         
          //  border: isActive ? Border.all(color: Colors.orange, width: 2) : null,
        ),
        child: Icon(icon, color: isActive ? Colors.orange : Colors.black87),
      ),
      label: label,
    );
  }
}
