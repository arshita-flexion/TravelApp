import 'package:codefest_travel_app/core/utils/app_exports.dart';
import 'package:codefest_travel_app/features/profile/bloc/profile_bloc.dart';
import 'package:codefest_travel_app/features/auth/bloc/auth_bloc.dart';
import 'package:codefest_travel_app/models/user.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(LoadProfileRequested());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          final user = state.user ?? context.watch<AuthBloc>().state.user;
          return SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(user, theme, state.bookingHistory.length),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24.0, 24, 24, 0),
                  child: Column(
                    children: [
                      _buildMenuSection(context, theme),
                      const SizedBox(height: 32),
                      _buildLogoutButton(context, theme),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(UserProfile? user, ThemeData theme, int bookingCount) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(24, 60, 24, 20),
          decoration: const BoxDecoration(
            color: Colors.black, // Changed from purple to black
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Profile',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Satoshi',
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      NavigatorService.pushNamed(AppRoutes.setProfileRoute, arguments: {'isEditing': true});
                    },
                    icon: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(50),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Image.asset(Assets.images.pngEdit, color: Colors.white, width: 20, height: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white.withAlpha(100), width: 2),
                    ),
                    child: CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage(
                        user?.fullProfileImageUrl ??
                            'https://t3.ftcdn.net/jpg/08/05/28/22/360_F_805282248_LHUxw7t2pnQ7x8lFEsS2IZgK8IGFXePS.jpg',
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.name ?? 'Traveler',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Satoshi',
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          user?.mobileNumber ?? '+1 555 012 3456',
                          style: TextStyle(
                            color: Colors.white.withAlpha(200),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Satoshi',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
        // Positioned(
        //   bottom: -40,
        //   left: 24,
        //   right: 24,
        //   child: Container(
        //     padding: const EdgeInsets.symmetric(vertical: 20),
        //     decoration: BoxDecoration(
        //       color: Colors.white,
        //       borderRadius: BorderRadius.circular(24),
        //       boxShadow: [BoxShadow(color: Colors.black.withAlpha(10), blurRadius: 20, offset: const Offset(0, 10))],
        //     ),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //       children: [
        //         _buildStatItem(bookingCount.toString(), 'Trips'),
        //         _buildStatItem('3', 'Reviews'),
        //         _buildStatItem('240', 'Points', isPoints: true),
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget _buildStatItem(String value, String label, {bool isPoints = false}) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.black, // Changed from purple to black
            fontSize: 20,
            fontWeight: FontWeight.w900,
            fontFamily: 'Satoshi',
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF999999),
            fontSize: 12,
            fontWeight: FontWeight.w600,
            fontFamily: 'Satoshi',
          ),
        ),
      ],
    );
  }

  Widget _buildMenuSection(BuildContext context, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.only(top: 60),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFEEEEEE).withAlpha(150)),
      ),
      child: Column(
        children: [
          _menuItem(
            imagePath: Assets.images.pngHistory,
            color: const Color(0xFFF5F5F5),
            iconColor: Colors.black,
            label: 'My Bookings',
            subtitle: 'View past & upcoming trips',
            onTap: () => NavigatorService.pushNamed(AppRoutes.bookingHistoryRoute),
          ),
          const Divider(height: 1, color: Color(0xFFF5F5F5), indent: 70),
          _menuItem(
            imagePath: Assets.images.pngMessages,
            color: const Color(0xFFF5F5F5),
            iconColor: Colors.black,
            label: 'FAQs',
            subtitle: 'Common questions & answers',
            onTap: () => NavigatorService.pushNamed(AppRoutes.faqRoute),
          ),
          const Divider(height: 1, color: Color(0xFFF5F5F5), indent: 70),
          _menuItem(
            imagePath: Assets.images.pngContact,
            color: const Color(0xFFF5F5F5),
            iconColor: Colors.black,
            label: 'Contact Us',
            subtitle: 'Get in touch with our team',
            onTap: () => NavigatorService.pushNamed(AppRoutes.contactUsRoute),
          ),
          const Divider(height: 1, color: Color(0xFFF5F5F5), indent: 70),
          _menuItem(
            imagePath: Assets.images.pngShield,
            color: const Color(0xFFF5F5F5),
            iconColor: Colors.black,
            label: 'Privacy Policy',
            subtitle: 'Security and data usage',
            onTap: () => NavigatorService.pushNamed(AppRoutes.privacyPolicyRoute),
          ),
          const Divider(height: 1, color: Color(0xFFF5F5F5), indent: 70),
          _menuItem(
            imagePath: Assets.images.pngTermsAndConditions,
            color: const Color(0xFFF5F5F5),
            iconColor: Colors.black,
            label: 'Terms & Conditions',
            subtitle: 'Usage rules and policies',
            onTap: () => NavigatorService.pushNamed(AppRoutes.termsAndConditionsRoute),
          ),
          // const Divider(height: 1, color: Color(0xFFF5F5F5), indent: 70),
          // _menuItem(
          //   icon: Icons.settings_rounded,
          //   color: const Color(0xFFF5F5F5),
          //   iconColor: Colors.black,
          //   label: 'Settings',
          //   subtitle: 'Notifications, privacy',
          //   onTap: () {},
          // ),
        ],
      ),
    );
  }

  Widget _menuItem({
    IconData? icon,
    String? imagePath,
    required Color color,
    required Color iconColor,
    required String label,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(16)),
              child: imagePath != null
                  ? Image.asset(imagePath, width: 22, height: 22, color: iconColor)
                  : Icon(icon, color: iconColor, size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900, fontFamily: 'Satoshi'),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF999999),
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Satoshi',
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Color(0xFFDDDDDD)),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context, ThemeData theme) {
    return InkWell(
      onTap: () => _showLogoutDialog(context),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: Theme.of(context).customColors.whiteColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Assets.images.pngLogout, width: 20, height: 20, color: Colors.red),
            const SizedBox(width: 10),
            Text(
              'Log Out',
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w900, fontSize: 16, fontFamily: 'Satoshi'),
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text('Log Out', style: TextStyle(fontWeight: FontWeight.w900)),
        content: const Text('Are you sure you want to log out of your account?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'CANCEL',
              style: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.bold),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<AuthBloc>().add(LogoutRequested());
              NavigatorService.pushNamedAndRemoveUntil(AppRoutes.loginRoute);
            },
            child: const Text(
              'LOG OUT',
              style: TextStyle(color: Color(0xFFEA4335), fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }
}
