import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:findcarsale/shared/theme/app_colors.dart';

class AuthField extends StatefulWidget {
  const AuthField({
    super.key,
    required this.name,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.autoFocus = false,
    this.borderRadius = 4.0,
    this.suffixIcon,
    this.keyboardType,
    this.fillColor,
    this.textInputAction,
    this.validator,
    this.maxlines = 1,
    this.readOnly = false,
    this.textCapitalization = TextCapitalization.none,
    this.labelText,
    this.onChanged,
    this.autofillHints,
    this.validationWithRequired,
    this.maxLength,
    this.onTap,
    this.inputFormatters,
  });
  final String name;
  final String hintText;
  final String? labelText;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextCapitalization textCapitalization;

  final TextInputAction? textInputAction;

  final Color? fillColor;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  final bool? readOnly;
  final bool? autoFocus;

  final int? maxLength;

  final Function(String?)? onChanged;
  final double borderRadius;
  final int maxlines;
  final TextEditingController controller;
  final Iterable<String>? autofillHints;
  final bool? validationWithRequired;
  final void Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;
  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  bool _obsecureText = false;

  @override
  void initState() {
    super.initState();
    _obsecureText = widget.obscureText == true ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      onTap: widget.onTap,
      textCapitalization: widget.textCapitalization,
      name: widget.name,
      // enabled: !(widget.readOnly ?? false),
      readOnly: widget.readOnly ?? false,
      maxLength: widget.maxLength,
      autofocus: widget.autoFocus ?? false,
      controller: widget.controller,
      autofillHints: widget.autofillHints,
      obscureText: _obsecureText,
      maxLines: widget.maxlines,
      minLines: widget.maxlines,
      onChanged: widget.onChanged,
      inputFormatters: widget.inputFormatters,
      validator:
          widget.validator ??
          FormBuilderValidators.compose([
            if (widget.validationWithRequired == true)
              FormBuilderValidators.required(
                errorText:
                    '${widget.labelText ?? widget.hintText} is required.',
              ),
          ]),
      textInputAction:
          (widget.maxlines > 1)
              ? TextInputAction.newline
              : widget.textInputAction,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      // autovalidateMode: AutovalidateMode.,
      decoration: InputDecoration(
        errorMaxLines: 2,

        hintText: widget.hintText,
        alignLabelWithHint: true,
        fillColor: widget.fillColor,
        counterText: '',
        // contentPadding:
        //     const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        labelText: widget.labelText,
        labelStyle: const TextStyle(color: Colors.grey),
        hintStyle: const TextStyle(color: AppColors.tileColor),
        errorStyle: Theme.of(
          context,
        ).textTheme.bodyMedium!.copyWith(color: Colors.red),
        filled: widget.fillColor != null ? true : false,
        suffixIcon:
            widget.suffixIcon ??
            (widget.obscureText == false
                ? null
                : DefaultIconWidget(
                  onPressed: () {
                    setState(() {
                      _obsecureText = !_obsecureText;
                    });
                  },
                  icon:
                      _obsecureText == false
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                  color: AppColors.primary,
                  size: 18,
                )),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.fillColor != null ? Colors.transparent : Colors.grey,
          ),
          borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color:
                (widget.readOnly == true)
                    ? Colors.grey
                    : widget.fillColor != null
                    ? Colors.transparent
                    : AppColors.primary,
          ),
          borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
        ),
      ),
    );
  }
}

class DefaultIconWidget extends StatelessWidget {
  const DefaultIconWidget({
    super.key,
    required this.icon,
    this.onPressed,
    this.color,
    this.padding,
    this.splashRadius = 22,
    this.size,
  });
  final IconData icon;
  final void Function()? onPressed;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final double? size;
  final double? splashRadius;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: splashRadius,
      onPressed: onPressed,
      padding: padding,
      icon: Icon(icon, color: color, size: size),
    );
  }
}
