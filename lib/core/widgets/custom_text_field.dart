import 'package:flutter/material.dart';
import 'package:hakawati/core/utils/utils.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      this.labelText,
      this.icon,
      this.controller,
      this.readOnly = false,
      this.textType,
      this.obscure = false,
      // this.isLast = false,
      this.onSaved,
      this.onChanged,
      this.focusNode,
      this.onTap,
      this.initialValue,
      this.hintText,
      this.validator});
  final TextEditingController? controller;
  final Widget? icon;
  final String? labelText;
  final TextInputType? textType;
  final String? hintText;
  final bool obscure;
  //final bool isLast;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final bool readOnly;
  final String? initialValue;
  final FocusNode? focusNode;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      controller: controller,
      validator: validator,
      onSaved: onSaved,
      onChanged: onChanged,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      // onEditingComplete: () {
      //   FocusScope.of(context).nextFocus();
      // },
      readOnly: readOnly,
      initialValue: initialValue,
      //    cursorColor: Theme.of(context).colorScheme.onBackground,
      cursorWidth: 1,
      keyboardType: textType,
      obscureText: obscure,
      focusNode: focusNode,
      cursorColor: Colors.white,
      textInputAction: TextInputAction.next, //  isLast ? TextInputAction.next : TextInputAction.done,
      decoration: customTextFieldDecoration(context),
    );
  }

  InputDecoration customTextFieldDecoration(BuildContext context) {
    return InputDecoration(
        labelText: labelText,
        fillColor: Colors.white.withOpacity(.1),
        filled: true,
        hintText: hintText,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Theme.of(context).primaryColor),
          borderRadius: Constants.kCircularRadius12,
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.red),
          borderRadius: Constants.kCircularRadius12,
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 1.5, color: Colors.red),
          borderRadius: Constants.kCircularRadius12,
        ),
        suffixIcon: icon,
        enabledBorder: const OutlineInputBorder(
            borderRadius: Constants.kCircularRadius12, borderSide: BorderSide(width: 0, color: Colors.transparent)),
        border: const OutlineInputBorder(borderSide: BorderSide(width: 1)));
  }
}
