import 'package:flutter/material.dart';
import 'package:codefest_travel_app/features/home/view/home_view.dart';
import 'package:codefest_travel_app/features/profile/view/booking_history_view.dart';
import 'package:codefest_travel_app/features/profile/view/profile_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:codefest_travel_app/features/profile/bloc/profile_bloc.dart';

class BottomNavigationView extends StatefulWidget {
  const BottomNavigationView({super.key});

  @override
  State<BottomNavigationView> createState() => _BottomNavigationViewState();
}

class _BottomNavigationViewState extends State<BottomNavigationView> {
  int _currentIndex = 0;

  final List<Widget> _screens = [const HomeView(), const BookingHistoryView(), const ProfileView()];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Color(0xFFEEEEEE), width: 1)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() => _currentIndex = index);
            if (index == 1) {
              context.read<ProfileBloc>().add(LoadProfileRequested());
            }
          },
          selectedItemColor: Colors.black,
          unselectedItemColor: const Color(0xFF999999),
          backgroundColor: theme.scaffoldBackgroundColor,
          elevation: 0,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w900, fontSize: 11, fontFamily: 'Satoshi'),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 11, fontFamily: 'Satoshi'),
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/png/others/png_home.png',
                width: 22,
                height: 22,
                color: const Color(0xFF999999),
              ),
              activeIcon: Image.asset(
                'assets/images/png/others/png_home.png',
                width: 22,
                height: 22,
                color: Colors.black,
              ),
              label: 'HOME',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/png/others/png_history.png',
                width: 22,
                height: 22,
                color: const Color(0xFF999999),
              ),
              activeIcon: Image.asset(
                'assets/images/png/others/png_history.png',
                width: 22,
                height: 22,
                color: Colors.black,
              ),
              label: 'BOOKINGS',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/images/png/others/png_profile.png',
                width: 22,
                height: 22,
                color: const Color(0xFF999999),
              ),
              activeIcon: Image.asset(
                'assets/images/png/others/png_profile.png',
                width: 22,
                height: 22,
                color: Colors.black,
              ),
              label: 'PROFILE',
            ),
          ],
        ),
      ),
    );
  }
}
