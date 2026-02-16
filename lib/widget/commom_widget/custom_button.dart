import 'package:codefest_travel_app/core/utils/app_exports.dart';
import 'package:codefest_travel_app/widget/commom_widget/app_loader_widget.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    this.decoration,
    this.leftIcon,
    this.rightIcon,
    this.margin,
    this.onPressed,
    this.buttonStyle,
    this.alignment,
    this.buttonTextStyle,
    this.isDisabled = false,
    this.height,
    this.width,
    this.iconSpacing,
    this.isLoading = false,
    this.secondary = false,
    this.borderRadius,
    required this.text,
    this.showRightIcon = false,
    this.isFullWidthButton = true,
  });

  final BoxDecoration? decoration;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onPressed;
  final ButtonStyle? buttonStyle;
  final Alignment? alignment;
  final TextStyle? buttonTextStyle;
  final bool isDisabled;
  final double? height;
  final double? width;
  final double? iconSpacing;
  final bool isLoading;
  final String text;
  final bool secondary;
  final double? borderRadius;
  final bool? showRightIcon;
  final bool? isFullWidthButton;

  @override
  Widget build(BuildContext context) {
    final double buttonHeight = height ?? 52.h;

    return Opacity(
      opacity: isDisabled ? 0.7 : 1,
      child: Container(
        height: buttonHeight,
        width: width ?? (isFullWidthButton == true ? 1.sw : null),
        margin: margin,
        decoration: decoration,
        child: ElevatedButton(
          style:
              buttonStyle ??
              ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).customColors.primaryColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius ?? 12)),
                padding: EdgeInsets.zero,
                textStyle: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                  color: Theme.of(context).customColors.blackColor,
                ),
              ),
          onPressed: isDisabled
              ? () {}
              : () {
                  HapticFeedback.selectionClick();
                  if (onPressed != null) onPressed!();
                },
          child: isLoading
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.0.w),
                      child: AppLoaderWidget(key: const ValueKey('loading')),
                    ),
                  ],
                )
              : Row(
                  key: const ValueKey('content'),
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (leftIcon != null) leftIcon!,
                    if (leftIcon != null && iconSpacing != null) SizedBox(width: iconSpacing),
                    if (isFullWidthButton == true)
                      Expanded(child: _buildTitleWidget(context))
                    else
                      Flexible(child: _buildTitleWidget(context)),
                    if (rightIcon != null && iconSpacing != null) SizedBox(width: iconSpacing),
                    if (rightIcon != null) rightIcon! else if (showRightIcon == true) Icon(Icons.arrow_forward),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildTitleWidget(BuildContext context) {
    return Padding(
      padding: leftIcon != null
          ? const EdgeInsets.only(left: 10.0, right: 22.0)
          : rightIcon != null || showRightIcon == true
          ? const EdgeInsets.only(left: 22.0, right: 10.0)
          : EdgeInsets.symmetric(horizontal: 19.w),
      child: Text(
        text,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: secondary
            ? Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
                color: Theme.of(context).customColors.whiteColor,
              )
            : buttonTextStyle ??
                  Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                    color: Theme.of(context).customColors.blackColor,
                  ),
      ),
    );
  }
}
