import 'package:flutter/cupertino.dart';

import 'error.dart';

class BaseAsyncBuilder<T> extends StatelessWidget {
  const BaseAsyncBuilder.stream({
    Key? key,
    required this.onData,
    this.onError,
    this.onNoData,
    required this.stream,
    this.future,
    required this.onWaiting,
  })  : assert((future == null)),
        super(key: key);

  const BaseAsyncBuilder.future({
    Key? key,
    required this.onData,
    this.onError,
    this.onNoData,
    this.stream,
    required this.future,
    required this.onWaiting,
  })  : assert((stream == null)),
        super(key: key);

  final Widget Function(T) onData;
  final Widget? onError;
  final Widget? onNoData;
  final Widget onWaiting;
  final Stream<T>? stream;
  final Future<T>? future;

  Widget _handleData(T data) {
    return onData(data);
  }

  @override
  Widget build(BuildContext context) {
    if (future == null) {
      return StreamBuilder<T>(
        stream: stream,
        builder: (context, snapshot) => builder(context, snapshot),
      );
    } else {
      return FutureBuilder<T>(
        future: future,
        builder: (context, snapshot) => builder(context, snapshot),
      );
    }
  }

  Widget builder(BuildContext context, AsyncSnapshot<T> snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
        return onError ??
            Error(
              error: snapshot.error.toString(),
              stackTrace: snapshot.stackTrace,
            );
      case ConnectionState.waiting:
        return onWaiting;
      case ConnectionState.active:
        if (snapshot.hasData) {
          return _handleData(snapshot.data!);
        } else {
          return onNoData ?? _handleData(snapshot.data!);
        }
      case ConnectionState.done:
        if (snapshot.hasData) {
          return _handleData(snapshot.data!);
        } else {
          return onNoData ?? _handleData(snapshot.data!);
        }
    }
  }
}
