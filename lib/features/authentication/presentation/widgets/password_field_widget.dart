import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:findcarsale/features/authentication/presentation/widgets/auth_field.dart';

class PasswordFieldWidget extends StatelessWidget {
  const PasswordFieldWidget({
    super.key,
    required this.passwordController,
    required this.name,
    required this.hintText,
    this.labelText,
    this.validator,
    this.autofillHints,
  });
  final TextEditingController passwordController;
  final String name, hintText;
  final String? labelText;
  final String? Function(String?)? validator;
  final Iterable<String>? autofillHints;

  @override
  Widget build(BuildContext context) {
    return AuthField(
      name: name,
      autofillHints: autofillHints,
      hintText: hintText,
      labelText: labelText ?? 'Password',
      obscureText: true,
      controller: passwordController,
      textInputAction: TextInputAction.next,
      validator:
          validator ??
          FormBuilderValidators.compose([
            FormBuilderValidators.required(
              errorText: '${labelText ?? hintText} is required.',
            ),
            FormBuilderValidators.minLength(
              8,
              errorText:
                  '${labelText ?? hintText} must be at least 8 characters.',
            ),
          ]),
    );
  }
}
