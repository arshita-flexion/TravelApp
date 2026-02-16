import 'package:codefest_travel_app/core/utils/app_exports.dart';
import 'package:codefest_travel_app/features/splash/bloc/splash_bloc.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    context.read<SplashBloc>().add(SplashStarted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state.status == SplashStatus.navigateToOnboarding) {
          NavigatorService.pushNamedAndRemoveUntil(AppRoutes.onboardingRoute);
        } else if (state.status == SplashStatus.navigateToLogin) {
          NavigatorService.pushNamedAndRemoveUntil(AppRoutes.loginRoute);
        } else if (state.status == SplashStatus.navigateToHome) {
          NavigatorService.pushNamedAndRemoveUntil(AppRoutes.bottomNavigationView);
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [CustomImageView(imagePath: Assets.images.appLogoDark)],
          ),
        ),
      ),
    );
  }
}
