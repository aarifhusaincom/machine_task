import 'package:flutter/material.dart';

class UserTabBar extends StatelessWidget {
  const UserTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.bottomCenter,
      child: TabBar(
        padding: EdgeInsets.zero,
        dividerColor: Colors.transparent,
        isScrollable: true,
        indicatorColor: const Color(0xFFFFAF00),
        labelColor: Colors.black,
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: [
          Tab(
            icon: Text(
              "Recommend",
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              )
                  .textTheme
                  .labelMedium
                  ?.copyWith(height: 1.11, fontWeight: FontWeight.w800),
            ),
          ),
          Tab(
            icon: Text(
              "Cell Phone",
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              )
                  .textTheme
                  .labelMedium
                  ?.copyWith(height: 1.11, fontWeight: FontWeight.w800),
            ),
          ),
          Tab(
            icon: Text(
              'Car Products',
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              )
                  .textTheme
                  .labelMedium
                  ?.copyWith(height: 1.11, fontWeight: FontWeight.w800),
            ),
          ),
          Tab(
            icon: Text(
              'Department Store',
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              )
                  .textTheme
                  .labelMedium
                  ?.copyWith(height: 1.11, fontWeight: FontWeight.w800),
            ),
          ),
          Tab(
            icon: Text(
              'Computer',
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              )
                  .textTheme
                  .labelMedium
                  ?.copyWith(height: 1.11, fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}
