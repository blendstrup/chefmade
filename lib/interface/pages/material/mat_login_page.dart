import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/repository_providers.dart';
import '../../colors.dart';
import '../../widgets/common/base_page.dart';
import '../../widgets/material/mat_elevated_button.dart';
import '../../widgets/material/mat_sliver_appbar.dart';

class MatLoginPage extends StatefulWidget {
  const MatLoginPage({Key? key}) : super(key: key);

  @override
  State<MatLoginPage> createState() => _MatLoginPageState();
}

class _MatLoginPageState extends State<MatLoginPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  final _formKey = GlobalKey<FormState>();

  bool _showEmailError = false;
  bool _showPasswordError = false;
  bool _showLoading = false;

  String _emailError = 'Invalid email.';
  String _passwordError = 'Wrong password.';

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
    bool _isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    Color _fillColor = _isDark ? AppColors.darkGrey1 : AppColors.white;

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: BasePage(
          androidOverride: CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
            slivers: [
              const MatSliverAppBar(text: 'chefmade'),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverFillRemaining(
                  child: Center(
                    child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          const SizedBox(height: 40),
                          Text(
                            'Welcome!',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          const Text('Please sign in to your account.'),
                          const SizedBox(height: 40),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                MatEmailInput(
                                  emailController: _emailController,
                                  showEmailError: _showEmailError,
                                  emailError: _emailError,
                                  fillColor: _fillColor,
                                ),
                                const SizedBox(height: 20),
                                MatPasswordInput(
                                  passwordController: _passwordController,
                                  showPasswordError: _showPasswordError,
                                  passwordError: _passwordError,
                                  fillColor: _fillColor,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 40),
                          Consumer(
                            builder: (context, ref, _) {
                              return MatElevatedButton(
                                onPressed: () async => _checkLogin(ref),
                                text: 'Login',
                              );
                            },
                          ),
                          const SizedBox(height: 20),
                          Visibility(
                            visible: _showLoading,
                            maintainSize: true,
                            maintainAnimation: true,
                            maintainState: true,
                            child: const CircularProgressIndicator(),
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
        ),
      ),
    );
  }

  void _checkLogin(WidgetRef ref) async {
    FocusManager.instance.primaryFocus?.unfocus();
    _resetErrors();

    if (_formKey.currentState!.validate()) {
      setState(() => _showLoading = true);
      Map<String, String>? result =
          await ref.watch(authRepositoryProvider).login(
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
  }

  void _resetErrors() {
    return setState(() {
      _showEmailError = false;
      _showPasswordError = false;
      _emailError = 'Invalid email.';
      _passwordError = 'Wrong password.';
    });
  }
}

class MatPasswordInput extends StatelessWidget {
  const MatPasswordInput({
    Key? key,
    required this.passwordController,
    required this.showPasswordError,
    required this.passwordError,
    required this.fillColor,
  }) : super(key: key);

  final TextEditingController passwordController;
  final bool showPasswordError;
  final String passwordError;
  final Color fillColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: passwordController,
      decoration: InputDecoration(
        label: const Text('Password'),
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: fillColor,
        errorText: showPasswordError ? passwordError : null,
      ),
      textInputAction: TextInputAction.done,
      autocorrect: false,
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password.';
        }
        return null;
      },
    );
  }
}

class MatEmailInput extends StatelessWidget {
  const MatEmailInput({
    Key? key,
    required this.emailController,
    required this.showEmailError,
    required this.emailError,
    required this.fillColor,
  }) : super(key: key);

  final TextEditingController emailController;
  final bool showEmailError;
  final String emailError;
  final Color fillColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailController,
      decoration: InputDecoration(
        label: const Text('Email'),
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: fillColor,
        errorText: showEmailError ? emailError : null,
      ),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      autocorrect: false,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email.';
        }
        return null;
      },
    );
  }
}
