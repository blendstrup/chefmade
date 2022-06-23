import 'dart:io' show Platform;

import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/restaurant_providers.dart';
import 'base_async_builder.dart';

class Login extends ConsumerWidget {
  const Login({
    Key? key,
    required this.loginPage,
    required this.home,
  }) : super(key: key);

  final Widget home;
  final Widget loginPage;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseAsyncBuilder<User?>.stream(
      stream: ref.watch(authStateProvider.stream),
      onWaiting: Platform.isAndroid
          ? const Center(child: CircularProgressIndicator())
          : const Center(child: CupertinoActivityIndicator()),
      onData: (User? user) => home,
      onNoData: loginPage,
    );
  }
}
