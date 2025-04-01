import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField(
      {super.key,
      this.validator,
      required this.controller,
      this.label = "",
      required this.hintText,
      this.prefixIcon,
      this.keyboardType = TextInputType.text,
      this.isObscured = false,
      this.readOnly = false,
      this.onSuffixPressed,
      this.onTap,
      this.maxLength,
      this.onChanged});

  final TextEditingController controller;
  final String label, hintText;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool isObscured, readOnly;
  final VoidCallback? onSuffixPressed;
  final GestureTapCallback? onTap;
  final int? maxLength;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5,
      children: [
        if (label.isNotEmpty)
          Text(label, style: Theme.of(context).textTheme.labelMedium),
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: controller,
          builder: (context, textValue, _) {
            return TextFormField(
              onTap: onTap,
              onChanged: onChanged,
              controller: controller,
              validator: validator,
              readOnly: readOnly,
              style: Theme.of(context).textTheme.bodySmall,
              keyboardType: keyboardType,
              obscureText: isObscured,
              obscuringCharacter: "*",
              cursorColor: Theme.of(context).primaryColor,
              maxLength: maxLength,
              decoration: InputDecoration(
                  hintText: hintText,
                  counterText: "",
                  prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
                  suffixIcon: Visibility(
                    visible: textValue.text.isNotEmpty,
                    child: IconButton(
                      icon: Icon(
                        keyboardType != TextInputType.visiblePassword
                            ? Icons.clear
                            : (isObscured
                                ? Icons.visibility_off
                                : Icons.visibility),
                      ),
                      onPressed: onSuffixPressed,
                    ),
                  )),
            );
          },
        ),
      ],
    );
  }
}
