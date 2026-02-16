import 'package:codefest_travel_app/core/utils/app_exports.dart';

class BackgroundImage extends StatelessWidget {
  final Widget child;
  final String imagePath;
  final double? height;
  final double? width;

  const BackgroundImage({super.key, required this.child, required this.imagePath, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomImageView(imagePath: imagePath, fit: BoxFit.cover, height: height, width: width),
        child,
      ],
    );
  }
}
