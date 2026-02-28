import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class BottomNavigation extends StatelessWidget {
  final int currentIndex;

  const BottomNavigation({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
        ),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.1),
        //     blurRadius: 10,
        //     offset: const Offset(0, -2),
        //   ),
        // ],
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/training');
              break;
            case 1:
              context.go('/job');
              break;
            case 2:
              context.go('/profile');
              break;
          }
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),

        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/training_profile.svg',
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(
                currentIndex == 0
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/training_profile.svg',
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(
                Theme.of(context).primaryColor,
                BlendMode.srcIn,
              ),
            ),
            label: 'Trainings',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/job.svg',
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(
                currentIndex == 1
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/job.svg',
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(
                Theme.of(context).primaryColor,
                BlendMode.srcIn,
              ),
            ),
            label: 'Jobs',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/account.svg',
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(
                currentIndex == 2
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
                BlendMode.srcIn,
              ),
            ),
            activeIcon: SvgPicture.asset(
              'assets/icons/account.svg',
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(
                Theme.of(context).primaryColor,
                BlendMode.srcIn,
              ),
            ),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
