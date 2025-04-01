import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velp_lite/core/utils/utils.dart';
import 'package:velp_lite/features/authentication/data/models/user_model.dart';
import 'package:velp_lite/features/authentication/presentation/widgets/logo_section.dart';

import '../../../home/presentation/screens/home_screen.dart';
import '../../viewmodel/auth_viewmodel.dart';
import '../widgets/login_form.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController, _passwordController;
  bool _obscurePassword = true;

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

  void _attemptLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      Utils.showLoadingDialog(context);
      final UserModel userModel = UserModel(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
      final success =
          await ref.read(authProvider.notifier).attemptLogin(userModel);
      if (!mounted) return; // Exit if widget is unmounted
      Navigator.of(context).pop(); // Hide loading dialog
      if (success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      } else {
        final error = ref.read(authProvider).error;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(error ?? 'Login failed'),
              backgroundColor: Colors.redAccent),
        );
      }
    }
  }

  void _updateObscurePassword() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LogoSection(),
                LoginForm(
                  formKey: _formKey,
                  emailController: _emailController,
                  passwordController: _passwordController,
                  obscurePassword: _obscurePassword,
                  onLogin: authState.isLoading ? null : _attemptLogin,
                  onObscureToggle: _updateObscurePassword,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
