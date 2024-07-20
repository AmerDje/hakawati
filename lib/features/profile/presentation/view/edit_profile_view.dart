import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hakawati/config/locale/localization/app_localizations.dart';
import 'package:hakawati/core/utils/styles.dart';
import 'package:hakawati/core/utils/tools/phone_number_formatter.dart';
import 'package:hakawati/core/utils/validators.dart';
import 'package:hakawati/core/widgets/custom_elevated_button.dart';
import 'package:hakawati/core/widgets/custom_text_field.dart';
import 'package:hakawati/core/widgets/gradient_scaffold.dart';
import 'package:hakawati/features/profile/presentation/view/widgets/profile_image_view.dart';
import 'package:hakawati/core/widgets/appbar_leading_button.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  AutovalidateMode? _autovalidateMode = AutovalidateMode.disabled;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? email, password, phone, name;

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!.translate;
    return GradientScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Text(
            translate("Edit Profile"),
            style: Styles.fontStyle32(context),
          ),
        ),
        centerTitle: true,
        forceMaterialTransparency: true,
        leading: const AppBarLeadingButton(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 15.0,
          right: 15.0,
          top: 15.0,
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Form(
          key: _formKey,
          autovalidateMode: _autovalidateMode,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 25,
              ),
              const Center(
                child: ProfileImageView(
                  size: 200,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text("Name", style: Styles.fontStyle16(context)),
              CustomTextField(
                hintText: 'Enter your name',
                onSaved: (value) {
                  name = value;
                },
                validator: (value) {
                  if (Validators.isNullOrBlank(value)) {
                    return "Field can't be empty";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              Text("Email", style: Styles.fontStyle16(context)),
              CustomTextField(
                hintText: 'Enter your email',
                onSaved: (value) {
                  email = value;
                },
                validator: (value) {
                  if (Validators.isNullOrBlank(value)) {
                    return "Field can't be empty";
                  } else if (!Validators.isValidEmail(value)) {
                    return "Invalid email format";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              Text("Phone number", style: Styles.fontStyle16(context)),
              CustomTextField(
                inputFormatters: [
                  LengthLimitingTextInputFormatter(13),
                  FilteringTextInputFormatter.digitsOnly,
                  NumberTextInputFormatter()
                ],
                hintText: '0666 ** ** **',
                onSaved: (value) {
                  phone = value;
                },
                validator: (value) {
                  if (Validators.isNullOrBlank(value)) {
                    return "Field can't be empty";
                  } else if (!Validators.isValidPhone(value)) {
                    return "Invalid phone format";
                  }
                  return null;
                },
              ),

              //   const Spacer(),
              // Text("Password", style: Styles.fontStyle16(context)),
              // CustomPasswordField(
              //   hintText: 'Enter your password',
              //   onSaved: (value) {
              //     password = value;
              //   },
              //   validator: (value) {
              //     if (Validators.isNullOrBlank(value)) {
              //       return "Field can't empty";
              //     } else if (value!.length < 6) {
              //       return "Password must be at least 6 characters";
              //     }
              //     return null;
              //   },
              // ),

              // BlocConsumer<RegisterCubit, RegisterState>(
              // listener: (context, state) {
              //   if (state is RegisterSuccess) {
              //     context.read<AuthCubit>().updateAuthStatus({
              //       "user": state.user.toJson(),
              //       "token": state.user.uid.toString(),
              //     });
              //     context.read<RegisterCubit>().sendEmailVerification();
              //   } else if (state is RegisterFailure) {
              //     showSnackBar(context, state.errMessage, isError: true);
              //   }
              // },
              // builder: (context, state) {
              //  return
              const SizedBox(
                height: 45,
              ),
              CustomElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // await context.read<RegisterCubit>().register(
                    //     email: email!.trim(),
                    //     name: name!.trim(),
                    //     phone: phone!.trim(),
                    //     password: password!,
                    //     locate: context.read<SettingsCubit>().state.locate);
                  } else {
                    _autovalidateMode = AutovalidateMode.always;
                    setState(() {});
                  }
                },
                child:
                    // state is RegisterLoading
                    //     ? const CupertinoActivityIndicator()
                    //:
                    Text(
                  translate("update Profile"),
                  style: Styles.fontStyle16(context).copyWith(color: Theme.of(context).secondaryHeaderColor),
                ),
                //   );
                // },
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
