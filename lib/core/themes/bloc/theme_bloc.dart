import 'package:codefest_travel_app/core/utils/app_exports.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> with WidgetsBindingObserver {
  ThemeBloc() : super(ThemeState(isDarkThemeOn: false, followSystemTheme: false)) {
    on<InitializeTheme>(_onInitializeTheme);
    on<ToggleTheme>(_onToggleTheme);
    on<SystemThemeChanged>(_onSystemThemeChanged);
    WidgetsBinding.instance.addObserver(this);
    _initializeTheme(); // Load initial theme asynchronously
  }

  Future<void> _initializeTheme() async {
    // Retrieve stored preferences asynchronously
    // final isDarkThemeOn =
    //     (await Prefobj.preferences?.get(Prefkeys.LIGHTDARK) as bool?) ?? false;
    final followSystemTheme = (await Prefobj.preferences?.get(Prefkeys.FOLLOW_SYSTEM) as bool?) ?? true;

    add(InitializeTheme(isDarkThemeOn: false, followSystemTheme: followSystemTheme));

    // If following system theme, set the initial system theme
    if (followSystemTheme) {
      // final isSystemDark =
      //     WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
      add(SystemThemeChanged(isDarkThemeOn: false));
    }
  }

  @override
  Future<void> close() {
    WidgetsBinding.instance.removeObserver(this);
    return super.close();
  }

  void _onInitializeTheme(InitializeTheme event, Emitter<ThemeState> emit) {
    emit(state.copyWith(isDarkThemeOn: false, followSystemTheme: event.followSystemTheme));
  }

  void _onToggleTheme(ToggleTheme event, Emitter<ThemeState> emit) {
    Prefobj.preferences?.put(Prefkeys.LIGHTDARK, false.toString());
    Prefobj.preferences?.put(Prefkeys.FOLLOW_SYSTEM, false.toString());

    emit(state.copyWith(isDarkThemeOn: false, followSystemTheme: false));
  }

  void _onSystemThemeChanged(SystemThemeChanged event, Emitter<ThemeState> emit) {
    if (state.followSystemTheme) {
      emit(state.copyWith(isDarkThemeOn: false));
    }
  }
}
