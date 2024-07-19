import 'package:flutter/material.dart';

class FormModel {
  final String formHeading;
  final String formQuestion;
  final Widget form;
  final GlobalKey<FormState>? formKey;

  FormModel({
    required this.formHeading,
    required this.formQuestion,
    required this.form,
    this.formKey,
  });
}
