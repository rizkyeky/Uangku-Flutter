part of _utils;

class Button extends StatelessWidget {
  const Button.filled({
    super.key,
    required this.onPressed,
    required this.child,
    this.padding,
    this.color,
  }): _filled = true, _outlined = false, _tinted = false;

  const Button.outlined({
    super.key,
    required this.onPressed,
    required this.child,
    this.padding,
    this.color,
  }) : _filled = false, _outlined = true, _tinted = false;

  const Button.texted({
    super.key,
    required this.onPressed,
    required this.child,
    this.padding,
    this.color,
  }) : _filled = false, _outlined = false, _tinted = false;

  const Button.tinted({
    super.key,
    required this.onPressed,
    required this.child,
    this.padding,
    this.color,
  }) : _filled = true, _outlined = false, _tinted = true;

  final Widget child;
  final FutureOr<void> Function() onPressed;
  final EdgeInsets? padding;
  final Color? color;

  final bool _filled;
  final bool _outlined;
  final bool _tinted;

  @override
  Widget build(BuildContext context) {
    final foregroundColor = color ?? CupertinoTheme.of(context).primaryColor;
    final brightness = CupertinoTheme.brightnessOf(context);
    final isDark = brightness == Brightness.dark;
    final loadingNotifier = ValueNotifier<bool>(false);
    final hasLoading = onPressed is Future<void> Function();
    final textColor = _filled 
      ? _tinted 
        ? foregroundColor 
        : TextColors.v100
      : _outlined && isDark
        ? TextColors.v100
        : foregroundColor;
    
    return TapOpacityEffect(
      onTap: () async {
        if (hasLoading) {
          loadingNotifier.value = true;
          await (onPressed.call() as Future<void>)
            .whenComplete(() {
              loadingNotifier.value = false;
            });
        } else {
          onPressed.call();
        }
      },
      child: Semantics(
        button: true,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: _outlined ? Border.all(
              color: foregroundColor,
              width: 2,
            ) : null,
            color: _filled ? _tinted 
              ? foregroundColor.withOpacity(brightness == Brightness.light ? 0.1 : 0.4) 
              : foregroundColor 
            : null,
          ),
          child: Padding(
            padding: padding ?? const EdgeInsets.symmetric(
              horizontal: 60,
              vertical: 12,
            ),
            child: Align(
              heightFactor: 1,
              widthFactor: 1,
              child: DefaultTextStyle(
                style: TextTheme.primaryButton.copyWith(
                  color: textColor
                ),
                child: IconTheme(
                  data: IconThemeData(
                    color: textColor,
                  ),
                  child: (hasLoading) ? ValueListenableBuilder<bool>(
                    valueListenable: loadingNotifier,
                    builder: (context, value, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          child ?? const SizedBox.shrink(),
                          if (value) ... [
                            Gap.w8,
                            CupertinoActivityIndicator(
                              color: textColor,
                              radius: 8.s,
                            ),
                          ]
                        ],
                      );
                    },
                    child: child,
                  ) : child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}