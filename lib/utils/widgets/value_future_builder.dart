part of _utils;

class ValueFutureBuilder<T> extends StatelessWidget {
  
  final Future<T>? future;
  final Widget Function(BuildContext context, Object? error)? onErrorBuilder;
  final void Function(Object? error)? onError;
  final Widget Function(BuildContext context)? onLoadingBuilder;
  final Widget Function(BuildContext context)? onEmptyNullBuilder;
  final Widget Function(BuildContext context, T value) onValueBuilder;

  const ValueFutureBuilder({
    super.key,
    required this.onValueBuilder,
    this.onErrorBuilder,
    this.onError,
    this.onLoadingBuilder,
    this.onEmptyNullBuilder,
    this.future,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return onLoadingBuilder?.call(context) ?? const Center(
            child: CupertinoActivityIndicator()
          );
        } else {
          if (snapshot.hasError) {
            onError?.call(snapshot.error);
            return onErrorBuilder?.call(context, snapshot.error) ?? Center(
              child: Text(snapshot.error.toString())
            );
          } else {
            if (snapshot.hasData && snapshot.data != null) {
              return onValueBuilder(context, snapshot.data as T);
            } else {
              return onEmptyNullBuilder?.call(context) ?? const SizedBox.shrink();
            }
          }
        }
      }
    );
  }
}