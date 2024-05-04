import 'package:flutter/material.dart';
import 'package:hakawati/core/utils/constants.dart';

class CustomPasswordField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  const CustomPasswordField({
    super.key,
    this.controller,
    this.onSaved,
    this.onChanged,
    this.hintText,
    this.validator,
  });

  @override
  State<CustomPasswordField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<CustomPasswordField> {
  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _isHidden,
      onSaved: widget.onSaved,
      onChanged: widget.onChanged,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      // onEditingComplete: () {
      //   FocusScope.of(context).nextFocus();
      // },
      cursorColor: Colors.white,
      textInputAction: TextInputAction.next,
      cursorWidth: 1,
      keyboardType: TextInputType.visiblePassword,
      validator: widget.validator,
      decoration: passwordFieldDecoration(context),
    );
  }

  InputDecoration passwordFieldDecoration(BuildContext context) {
    return InputDecoration(
      fillColor: Colors.white.withOpacity(.1),
      filled: true,
      hintText: widget.hintText,
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
      enabledBorder: const OutlineInputBorder(
          borderRadius: Constants.kCircularRadius12, borderSide: BorderSide(width: 0, color: Colors.transparent)),
      suffixIcon: IconButton(
        padding: EdgeInsets.zero,
        splashRadius: 8,
        icon: _isHidden ? const Icon(Icons.visibility_outlined) : const Icon(Icons.visibility_off_outlined),
        onPressed: () {
          setState(() {
            _isHidden = !_isHidden;
          });
        },
      ),
    );
  }
}
