part of _utils;

enum SnackBarType {
  error,
  success,
  warning,
}

class SnackBar {
  
  static final backgroundColors = <SnackBarType, Color>{
    SnackBarType.error: SemanticColors.error,
    SnackBarType.success: SemanticColors.green,
    SnackBarType.warning: SemanticColors.orange,
  };
  static final foregroundColors = <SnackBarType, Color>{
    SnackBarType.error: TextColors.v100,
    SnackBarType.success: TextColors.v100,
    SnackBarType.warning: TextColors.v100,
  };
  static show(BuildContext context, String message, {
    SnackBarType type = SnackBarType.error,
    bool autoDismiss = false,
  }) {
    showFlash(
      context: context,
      transitionDuration: const Duration(milliseconds: 480),
      duration: autoDismiss ? const Duration(seconds: 3) : null,
      builder: (context, controller) {
        return Flash(
          controller: controller,
          behavior: FlashBehavior.floating,
          position: FlashPosition.bottom,
          brightness: CupertinoTheme.brightnessOf(context),
          backgroundColor: backgroundColors[type], 
          child: FlashBar(
            content: Text(message.toString(),
              style: TextTheme.bodySm.copyWith(
                color: foregroundColors[type],
                fontWeight: FontWeight.w500,
              ),
            )
          ),
        );
      }
    );
  }
}