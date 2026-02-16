import 'package:codefest_travel_app/core/themes/custom_color_extension.dart';
import 'package:codefest_travel_app/core/utils/app_exports.dart';
import 'package:codefest_travel_app/core/utils/dimenson.dart';
import 'package:codefest_travel_app/widget/commom_widget/custom_button.dart';
import 'package:codefest_travel_app/widget/commom_widget/image_view.dart';

class ExceptionWidget extends StatefulWidget {
  final String imagePath;
  final String title;
  final String? subtitle;
  final bool? showButton;
  final String? buttonText;
  final VoidCallback? onButtonPressed;
  final bool? showGif;
  final String? gifPath;

  const ExceptionWidget({
    required this.imagePath,
    required this.title,
    this.subtitle,
    this.showButton = false,
    this.buttonText,
    this.onButtonPressed,
    this.showGif = false,
    this.gifPath,
    super.key,
  });

  @override
  State<ExceptionWidget> createState() => _ExceptionWidgetState();
}

class _ExceptionWidgetState extends State<ExceptionWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleButtonPress() {
    setState(() {
      _isLoading = true;
    });
    _controller.forward().then((_) {
      if (widget.onButtonPressed != null) {
        widget.onButtonPressed!();
      }
      // Simulate a delay to hide the progress indicator (e.g., after API call completes)
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });
        _controller.reverse();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomImageView(imagePath: widget.imagePath, height: 231.h, alignment: Alignment.center, fit: BoxFit.cover),
            buildSizedBoxH(20),
            Text(
              widget.title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600, fontSize: 20.0.sp),
              textAlign: TextAlign.center,
            ),
            buildSizedBoxH(16),
            Text(
              widget.subtitle ?? '',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 12.0.sp,
                color: ThemeData().customColors.blackColor,
              ),
              textAlign: TextAlign.center,
            ),
            if (widget.showButton == true) buildSizedBoxH(70),
            if (widget.showButton == true)
              CustomElevatedButton(
                onPressed: _handleButtonPress,
                text: widget.buttonText ?? "Try Again",
                isLoading: _isLoading,
              ),
            if (widget.showGif == true)
              CustomImageView(
                width: double.infinity,
                imagePath: widget.gifPath ?? '',
                alignment: Alignment.center,
                fit: BoxFit.cover,
              ),
          ],
        ),
      ),
    );
  }
}
