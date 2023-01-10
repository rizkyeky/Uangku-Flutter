part of _utils;

class Shimmer extends StatelessWidget {
  
  const Shimmer({
    super.key,
    required this.height,
    required this.width,
    this.radius = 8,
  }): _isRound = false, size = 0;

  const Shimmer.round({
    super.key,
    required this.size,
    this.radius = 8,
  }) : _isRound = true, height = 0, width = 0;
  
  final double height;
  final double width;
  final double size;
  final double radius;
  final bool _isRound;
  
  @override
  Widget build(BuildContext context) {
    final brightness = CupertinoTheme.brightnessOf(context);
    final isDark = brightness == Brightness.dark;
    return _isRound ? FadeShimmer.round(
      size: size,
      fadeTheme: isDark ? FadeTheme.dark : FadeTheme.light,
    ) : FadeShimmer(
      height: height,
      width: width,
      radius: radius,
      fadeTheme: isDark ? FadeTheme.dark : FadeTheme.light,
    );
  }
}