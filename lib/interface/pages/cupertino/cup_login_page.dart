import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../state/repository_providers.dart';
import '../../colors.dart';
import '../../widgets/common/base_page.dart';

class CupLoginPage extends StatefulWidget {
  const CupLoginPage({Key? key}) : super(key: key);

  @override
  State<CupLoginPage> createState() => _CupLoginPageState();
}

class _CupLoginPageState extends State<CupLoginPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  bool _showEmailError = false;
  bool _showPasswordError = false;
  bool _showLoading = false;

  String _emailError = 'Invalid email';
  String _passwordError = 'Wrong password';

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CupertinoThemeData _theme = CupertinoTheme.of(context);

    return CupertinoPageScaffold(
      child: BasePage(
        appBar: const CupertinoSliverNavigationBar(
          largeTitle: Text('chefmade'),
        ),
        removeFocusOnTap: true,
        scrollPhysics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverFillRemaining(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      Text(
                        'Welcome!',
                        style: _theme.textTheme.navTitleTextStyle,
                      ),
                      const Text('Please sign in to your account'),
                      const SizedBox(height: 40),
                      CupertinoFormSection.insetGrouped(
                        margin: const EdgeInsets.all(0),
                        backgroundColor: _theme.scaffoldBackgroundColor,
                        decoration: BoxDecoration(
                          color: const CupertinoDynamicColor.withBrightness(
                            color: AppColors.white,
                            darkColor: AppColors.darkGrey2,
                          ).resolveFrom(context),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        children: [
                          CupertinoFormRow(
                            prefix: const Text('Email'),
                            error: Visibility(
                              visible: _showEmailError,
                              child: Text(_emailError),
                            ),
                            child: CupertinoTextFormFieldRow(
                              controller: _emailController,
                              placeholder: 'Enter your email',
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              autocorrect: false,
                            ),
                          ),
                          CupertinoFormRow(
                            prefix: const Text('Password'),
                            error: Visibility(
                              visible: _showPasswordError,
                              child: Text(_passwordError),
                            ),
                            child: CupertinoTextFormFieldRow(
                              controller: _passwordController,
                              placeholder: 'Enter your password',
                              textInputAction: TextInputAction.done,
                              autocorrect: false,
                              obscureText: true,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Consumer(
                        builder: (context, ref, _) => CupertinoButton.filled(
                          child: const Text('Login'),
                          onPressed: () async => _checkLogin(
                            ref: ref,
                            context: context,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Visibility(
                        visible: _showLoading,
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,
                        child: const CupertinoActivityIndicator(),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _checkLogin({
    required WidgetRef ref,
    required BuildContext context,
  }) async {
    _resetErrors();

    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      if (_emailController.text.isEmpty) {
        setState(() {
          _showEmailError = true;
          _emailError = 'Please enter your email';
        });
      }
      if (_passwordController.text.isEmpty) {
        setState(() {
          _showPasswordError = true;
          _passwordError = 'Please enter your password';
        });
      }
      return;
    }

    FocusScope.of(context).unfocus();

    setState(() => _showLoading = true);
    Map<String, String>? result = await ref.watch(authRepositoryProvider).login(
          _emailController.text,
          _passwordController.text,
        );

    if (result != null) {
      setState(() => _showLoading = false);

      if (result['code'] == 'user-not-found' ||
          result['code'] == 'user-disabled' ||
          result['code'] == 'invalid-email') {
        setState(() {
          _showEmailError = true;
          _emailError = result['msg'] ?? _emailError;
        });
      } else if (result['code'] == 'wrong-password') {
        setState(() {
          _showPasswordError = true;
          _passwordError = result['msg'] ?? _emailError;
        });
      }
    }
  }

  void _resetErrors() {
    return setState(() {
      _showEmailError = false;
      _showPasswordError = false;
      _emailError = 'Invalid email';
      _passwordError = 'Wrong password';
    });
  }
}
