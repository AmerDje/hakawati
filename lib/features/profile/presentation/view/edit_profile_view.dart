import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hakawati/config/locale/localization/app_localizations.dart';
import 'package:hakawati/core/functions/show_snackbar.dart';
import 'package:hakawati/core/utils/styles.dart';
import 'package:hakawati/core/tools/phone_number_formatter.dart';
import 'package:hakawati/core/utils/validators.dart';
import 'package:hakawati/core/widgets/custom_elevated_button.dart';
import 'package:hakawati/core/widgets/custom_text_field.dart';
import 'package:hakawati/core/widgets/gradient_scaffold.dart';
import 'package:hakawati/features/auth/data/models/user.dart';
import 'package:hakawati/features/auth/presentation/manager/auth_cubit.dart';
import 'package:hakawati/features/profile/presentation/manager/profile_cubit.dart';
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
  String? phone, name, photoUrl; //email, password;

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!.translate;
    final user = context.read<AuthCubit>().state.user;

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
      body: Builder(builder: (context) {
        return SingleChildScrollView(
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
                Center(
                  child: ProfileImageView(
                    size: 200,
                    onUpdate: (value) {
                      photoUrl = value;
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text("Name", style: Styles.fontStyle16(context)),
                CustomTextField(
                  hintText: 'Enter your name',
                  initialValue: user.name,
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
                  initialValue: user.email,
                  readOnly: true,
                  onTap: () => showSnackBar(context, "Email can't be changed, please contact us"),
                  // onSaved: (value) {
                  //   email = value;
                  // },
                  // validator: (value) {
                  //   if (Validators.isNullOrBlank(value)) {
                  //     return "Field can't be empty";
                  //   } else if (!Validators.isValidEmail(value)) {
                  //     return "Invalid email format";
                  //   }
                  //   return null;
                  // },
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
                  initialValue: user.phoneNumber,
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
                const SizedBox(
                  height: 45,
                ),
                BlocConsumer<ProfileCubit, ProfileState>(
                  listener: (context, state) {
                    if (state is UpdateUserProfileSuccess) {
                      context.read<AuthCubit>().updateUser(state.user);
                      Navigator.pop(context);
                      //context.read<ProfileCubit>().sendEmailVerification();
                    } else if (state is UpdateUserProfileFailure) {
                      showSnackBar(context, state.errMessage, isError: true);
                    }
                  },
                  builder: (context, state) {
                    return CustomElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          final UserModel user0 = UserModel(
                            uid: user.uid,
                            //email: email!.trim(),
                            name: name!.trim(),
                            phoneNumber: phone!.trim(),
                            photoUrl: photoUrl,
                          );
                          context.read<ProfileCubit>().updateUser(user0);
                        } else {
                          _autovalidateMode = AutovalidateMode.always;
                          setState(() {});
                        }
                      },
                      child: state is UpdateUserProfileLoading
                          ? const CupertinoActivityIndicator()
                          : Text(
                              translate("Update Profile"),
                              style:
                                  Styles.fontStyle16(context).copyWith(color: Theme.of(context).secondaryHeaderColor),
                            ),
                    );
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
