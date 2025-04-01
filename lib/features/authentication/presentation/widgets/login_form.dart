import 'package:flutter/material.dart';

import '../../../../core/validators/validators.dart';
import '../../../../core/widgets/input_field.dart';

class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController, passwordController;
  final bool obscurePassword;
  final void Function()? onLogin, onObscureToggle;

  const LoginForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.obscurePassword,
    required this.onLogin,
    required this.onObscureToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        spacing: 20,
        children: [
          InputField(
            label: "Email",
            hintText: "Enter Your Email",
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            validator: Validators.emailValidation,
            onSuffixPressed: emailController.clear,
          ),
          InputField(
            label: "Password",
            hintText: "Enter Your Password",
            prefixIcon: Icons.lock_open,
            keyboardType: TextInputType.visiblePassword,
            controller: passwordController,
            isObscured: obscurePassword,
            validator: Validators.passwordValidation,
            onSuffixPressed: onObscureToggle,
          ),
          ElevatedButton(
            onPressed: onLogin,
            child: const Text('LOGIN'),
          ),
        ],
      ),
    );
  }
}
