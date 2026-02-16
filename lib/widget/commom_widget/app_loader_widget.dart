import '../../core/utils/app_exports.dart';

class AppLoaderWidget extends StatelessWidget {
  final double size;
  final Color? color;
  final double? strokeWidth;

  const AppLoaderWidget({super.key, this.size = 25.0, this.color, this.strokeWidth});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitHourGlass(color: color ?? Theme.of(context).customColors.blackColor!, size: size),
    );
  }
}
