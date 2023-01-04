part of _utils;

class TapOpacityEffect extends StatefulWidget {
  const TapOpacityEffect({
    super.key,
    required this.onTap,
    required this.child,
    this.opacity,
  });

  final Widget child;
  final void Function() onTap;
  final double? opacity;

  @override
  State<TapOpacityEffect> createState() => _TapOpacityEffectState();
}

class _TapOpacityEffectState extends State<TapOpacityEffect> with SingleTickerProviderStateMixin {

  final Tween<double> _opacityTween = Tween<double>(begin: 1.0);

  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      value: 0.0,
      vsync: this,
    );
    _opacityAnimation = _animationController
      .drive(CurveTween(curve: Curves.decelerate))
      .drive(_opacityTween);
    _setTween();
  }

  @override
  void didUpdateWidget(TapOpacityEffect old) {
    super.didUpdateWidget(old);
    _setTween();
  }

  void _setTween() {
    _opacityTween.end = widget.opacity ?? 0.4;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool _buttonHeldDown = false;

  void _handleTapDown(TapDownDetails event) {
    if (!_buttonHeldDown) {
      _buttonHeldDown = true;
      _animate();
    }
  }

  void _handleTapUp(TapUpDetails event) {
    if (_buttonHeldDown) {
      _buttonHeldDown = false;
      _animate();
    }
  }

  void _handleTapCancel() {
    if (_buttonHeldDown) {
      _buttonHeldDown = false;
      _animate();
    }
  }

  void _animate() {
    if (_animationController.isAnimating) {
      return;
    }
    final bool wasHeldDown = _buttonHeldDown;
    final TickerFuture ticker = _buttonHeldDown
        ? _animationController.animateTo(1.0, 
          duration: const Duration(milliseconds: 120), 
          curve: Curves.easeInCubic
        )
        : _animationController.animateTo(0.0, 
          duration: const Duration(milliseconds: 180), 
          curve: Curves.easeOutCubic
        );
    ticker.then<void>((void value) {
      if (mounted && wasHeldDown != _buttonHeldDown) {
        _animate();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: widget.onTap,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: widget.child
      ),
    );
  }
}