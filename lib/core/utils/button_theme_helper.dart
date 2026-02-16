import 'app_exports.dart';

class ButtonThemeHelper {
  static ButtonStyle outlineButtonStyle(BuildContext context) {
    return ElevatedButton.styleFrom(
      backgroundColor: Theme.of(context).customColors.transparentColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0.r),
        side: BorderSide(color: Theme.of(context).customColors.borderColor!),
      ),
      textStyle: Theme.of(context).textTheme.headlineLarge?.copyWith(
        color: Theme.of(context).customColors.whiteColor,
        fontSize: 18.0.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
