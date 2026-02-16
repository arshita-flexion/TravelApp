import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:codefest_travel_app/features/splash/bloc/splash_bloc.dart';
import 'package:codefest_travel_app/features/onboarding/bloc/onboarding_bloc.dart';
import 'package:codefest_travel_app/features/auth/bloc/auth_bloc.dart';
import 'package:codefest_travel_app/features/home/bloc/home_bloc.dart';
import 'package:codefest_travel_app/features/profile/bloc/profile_bloc.dart';
import 'package:codefest_travel_app/services/api_service.dart';
import 'package:codefest_travel_app/repository/auth_repository.dart';
import 'package:codefest_travel_app/repository/travel_repository.dart';
import 'package:codefest_travel_app/core/themes/bloc/theme_bloc.dart';
import 'package:codefest_travel_app/core/check_connection/check_connection_cubit.dart';
import 'package:codefest_travel_app/core/l10n/bloc/locale_bloc.dart';

import 'package:codefest_travel_app/core/api_config/client/api_client.dart';

class BlocProviders extends StatelessWidget {
  final Widget child;
  const BlocProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ApiClient>(
          create: (context) => ApiClient(),
        ),
        RepositoryProvider<ApiService>(
          create: (context) => ApiService(),
        ),
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(apiClient: context.read<ApiClient>()),
        ),
        RepositoryProvider<TravelRepository>(
          create: (context) => TravelRepository(
            apiService: context.read<ApiService>(),
            apiClient: context.read<ApiClient>(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ThemeBloc>(
            create: (context) => ThemeBloc(),
          ),
          BlocProvider<LocaleBloc>(
            create: (context) => LocaleBloc(),
          ),
          BlocProvider<CheckConnectionCubit>(
            create: (context) => CheckConnectionCubit(),
          ),
          BlocProvider<SplashBloc>(
            create: (context) => SplashBloc(),
          ),
          BlocProvider<OnboardingBloc>(
            create: (context) => OnboardingBloc(),
          ),
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(authRepository: context.read<AuthRepository>()),
          ),
          BlocProvider<HomeBloc>(
            create: (context) => HomeBloc(travelRepository: context.read<TravelRepository>()),
          ),
          BlocProvider<ProfileBloc>(
            create: (context) => ProfileBloc(travelRepository: context.read<TravelRepository>()),
          ),
        ],
        child: child,
      ),
    );
  }
}
