import 'package:codefest_travel_app/core/utils/app_exports.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Color? shadowColor;
  final Color? iconColor;
  final double elevation;
  final bool? centerTitle;
  final double? toolbarHeight;
  final ShapeBorder? shape;
  final bool isPrimary;
  final Widget? leading;
  final double? leadingWidth;

  const CommonAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.showBackButton = true,
    this.onBackPressed,
    this.actions,
    this.backgroundColor,
    this.shadowColor,
    this.iconColor,
    this.elevation = 0.0,
    this.centerTitle = false,
    this.toolbarHeight,
    this.shape,
    this.isPrimary = true,
    this.leading,
    this.leadingWidth,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0.0,
      toolbarHeight: toolbarHeight,
      surfaceTintColor: Colors.transparent,
      backgroundColor: backgroundColor ?? Colors.transparent,
      automaticallyImplyLeading: false,
      centerTitle: centerTitle,
      leadingWidth: leadingWidth,
      leading:
          leading ??
          (showBackButton
              ? Center(
                  child: IconButton(
                    onPressed: onBackPressed ?? () => NavigatorService.goBack(),
                    icon: Icon(Icons.arrow_back, color: iconColor),
                  ),
                )
              : null),
      elevation: elevation,
      shadowColor:
          shadowColor?.withValues(alpha: 0.18) ?? Theme.of(context).customColors.greyColor?.withValues(alpha: 0.12),
      shape: shape,
      titleSpacing: 10.w,
      title:
          titleWidget ??
          (title != null
              ? Text(
                  title!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 20.0.sp,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).customColors.whiteColor,
                  ),
                )
              : null),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight ?? kToolbarHeight);
}
