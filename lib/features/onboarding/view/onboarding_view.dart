import 'package:codefest_travel_app/core/utils/app_exports.dart';
import 'package:codefest_travel_app/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:codefest_travel_app/features/onboarding/bloc/onboarding_bloc.dart';
import 'package:codefest_travel_app/core/routes/app_routes.dart';
import 'package:codefest_travel_app/core/utils/navigator_service.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();

  final List<OnboardingData> _onboardingPages = [
    OnboardingData(
      title: 'Plan Your Trip',
      description: 'Find the best destinations and plan your perfect getaway with ease.',
      imageUrl: Assets.images.onboardingImage1,
    ),
    OnboardingData(
      title: 'Book with Ease',
      description: 'Secure your bookings instantly and pay later. Simple and fast.',
      imageUrl: Assets.images.onboardingImage2,
    ),
    OnboardingData(
      title: 'Travel Further',
      description: 'Explore hidden gems and create memories that last a lifetime.',
      imageUrl: Assets.images.onboardingImage3,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _onboardingPages.length,
            onPageChanged: (index) {
              context.read<OnboardingBloc>().add(OnboardingPageChanged(index));
            },
            itemBuilder: (context, index) {
              final data = _onboardingPages[index];
              return OnboardingPageWidget(data: data);
            },
          ),
          Positioned(
            top: 60,
            right: 20,
            child: GestureDetector(
              onTap: () => _finishOnboarding(context),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  'Skip',
                  style: TextStyle(
                    color: Theme.of(context).customColors.whiteColor,
                    fontSize: 16,
                    fontFamily: 'Satoshi',
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: BlocBuilder<OnboardingBloc, OnboardingState>(
              builder: (context, state) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _onboardingPages.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: state.currentIndex == index ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: state.currentIndex == index ? Colors.white : Colors.white.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        minimumSize: const Size(double.infinity, 56),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: () {
                        if (state.currentIndex < _onboardingPages.length - 1) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          _finishOnboarding(context);
                        }
                      },
                      child: Text(
                        state.currentIndex == _onboardingPages.length - 1 ? 'GET STARTED' : 'CONTINUE',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Satoshi',
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _finishOnboarding(BuildContext context) {
    context.read<OnboardingBloc>().add(OnboardingFinished());
    NavigatorService.pushNamedAndRemoveUntil(AppRoutes.loginRoute);
  }
}

class OnboardingData {
  final String title;
  final String description;
  final String imageUrl;

  OnboardingData({required this.title, required this.description, required this.imageUrl});
}

class OnboardingPageWidget extends StatelessWidget {
  final OnboardingData data;

  const OnboardingPageWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(image: AssetImage(data.imageUrl), fit: BoxFit.cover),
      ),
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(flex: 3),
          Text(
            data.title.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.w900,
              fontFamily: 'Satoshi',
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            data.description,
            style: TextStyle(color: Colors.white..withValues(alpha: 0.7), fontSize: 18, fontFamily: 'Satoshi'),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
