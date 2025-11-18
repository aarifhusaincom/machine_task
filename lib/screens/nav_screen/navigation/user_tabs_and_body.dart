import 'package:flutter/material.dart';
import 'package:luxeloft/screens/nav_screen/navigation/user_service_tab_body/recommended_items.dart';

import '../../../widgets/user_tab_bar.dart';

class UserTabAndBody extends StatelessWidget {
  const UserTabAndBody({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Column(
        children: [
          const UserTabBar(),
          Expanded(child: tabBarView(context)),
        ],
      ),
    );
  }

  Widget tabBarView(BuildContext context) {
    return const TabBarView(
      children: [
        RecommendedItems(),
        RecommendedItems(),
        RecommendedItems(),
        RecommendedItems(),
        RecommendedItems(),
      ],
    );
  }
}
