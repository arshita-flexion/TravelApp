import 'package:codefest_travel_app/core/utils/app_exports.dart';
import 'package:toastification/toastification.dart';

import '../utils/local_storage/sqflite_storage_box.dart';

class TriplooApp extends StatelessWidget {
  const TriplooApp({super.key, required this.prefs});
  final KeyValueStore prefs;

  @override
  Widget build(BuildContext context) {
    Prefobj.preferences = prefs;
    return BlocProviders(
      child: MultiBlocListener(
        listeners: [
          BlocListener<CheckConnectionCubit, CheckConnectionStates>(
            listener: (context, state) {
              if (state is InternetDisconnected) {
                CheckConnectionCubit.get(context).isNetDialogShow = true;
                Logger.lOG('InternetDisconnected');
                Future.delayed(const Duration(milliseconds: 500), () {});
              }
              if (state is InternetConnected) {
                if (CheckConnectionCubit.get(context).isNetDialogShow) {
                  Logger.lOG('InternetConnected');

                  CheckConnectionCubit.get(context).isNetDialogShow = false;
                }
              }
            },
          ),
        ],
        child: BlocBuilder<LocaleBloc, LocaleState>(
          builder: (context, localeState) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                highContrast: true,
                displayFeatures: MediaQuery.of(context).displayFeatures,
                gestureSettings: MediaQuery.of(context).gestureSettings,
                textScaler: TextScaler.noScaling,
                invertColors: false,
                boldText: false,
              ),
              child: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle(
                  statusBarColor: Theme.of(context).customColors.transparentColor,
                  statusBarIconBrightness: Brightness.dark,
                  systemNavigationBarIconBrightness: Brightness.dark,
                  systemNavigationBarColor: Theme.of(context).customColors.whiteColor,
                ),
                child: GestureDetector(
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: ScreenUtilInit(
                    designSize: Size(375, 812),
                    minTextAdapt: true,
                    splitScreenMode: true,

                    child: ToastificationWrapper(
                      child: Container(
                        color: Platform.isIOS
                            ? Theme.of(context).customColors.transparentColor
                            : Theme.of(context).customColors.primaryColor,
                        child: SafeArea(
                          top: false,
                          bottom: Platform.isIOS ? false : true,
                          left: false,
                          right: false,
                          child: MaterialApp(
                            title: 'TRIPLOO',
                            debugShowCheckedModeBanner: false,
                            localizationsDelegates: const [
                              AppLocalizations.delegate,
                              GlobalMaterialLocalizations.delegate,
                              GlobalWidgetsLocalizations.delegate,
                              GlobalCupertinoLocalizations.delegate,
                            ],
                            supportedLocales: AppLocalizations.supportedLocales,
                            navigatorKey: NavigatorService.navigatorKey,
                            locale: localeState.locale,
                            theme: MyAppThemeHelper.darkTheme,
                            themeMode: ThemeMode.dark,
                            initialRoute: AppRoutes.initialRoute,
                            routes: AppRoutes.routes,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
