import 'dart:ui';

import 'package:codefest_travel_app/core/themes/custom_color_extension.dart';
import 'package:codefest_travel_app/core/utils/app_exports.dart';
import 'package:toastification/toastification.dart';

/// A wrapper widget that provides double-press-to-exit functionality
/// Can be used to wrap any screen where you want exit-on-back-press behavior
class DoublePressToExitWrapper extends StatefulWidget {
  final Widget child;
  final String? message;
  final Duration? exitTimeGap;
  final Color? snackBarBackgroundColor;
  final Color? snackBarTextColor;

  const DoublePressToExitWrapper({
    super.key,
    required this.child,
    this.message,
    this.exitTimeGap,
    this.snackBarBackgroundColor,
    this.snackBarTextColor,
  });

  @override
  State<DoublePressToExitWrapper> createState() => _DoublePressToExitWrapperState();
}

class _DoublePressToExitWrapperState extends State<DoublePressToExitWrapper> {
  DateTime? _lastPressedAt;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        final now = DateTime.now();
        final exitTimeGap = widget.exitTimeGap ?? const Duration(seconds: 2);

        // If last press was within the specified duration, exit the app
        if (_lastPressedAt != null && now.difference(_lastPressedAt!) < exitTimeGap) {
          SystemNavigator.pop();
          return;
        }

        // Otherwise, update the last pressed time and show snackbar
        setState(() {
          _lastPressedAt = now;
        });

        toastification.showCustom(
          builder: (context, holder) {
            return Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: widget.snackBarBackgroundColor ?? Theme.of(context).customColors.rectangleColor,
                      borderRadius: BorderRadius.circular(100.0),
                      border: Border.all(color: Theme.of(context).customColors.borderColor!),
                    ),
                    child: Text(
                      widget.message ?? 'Press back again to exit',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(color: Theme.of(context).customColors.whiteColor),
                    ),
                  ),
                ),
              ),
            );
          },
          alignment: Alignment.bottomCenter,
          autoCloseDuration: const Duration(seconds: 3),
        );
      },
      child: widget.child,
    );
  }
}
