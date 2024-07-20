import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hakawati/core/common/bloc/state_base.dart';
import 'package:hakawati/core/utils/utils.dart';
import 'package:hakawati/core/widgets/cached_image_view.dart';
import 'package:hakawati/core/widgets/image_upload_item.dart';
import 'package:hakawati/features/auth/presentation/manager/auth_cubit.dart';
import 'package:hakawati/features/profile/presentation/manager/profile_cubit.dart';
import 'package:hakawati/features/profile/presentation/view/widgets/edge_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileImageView extends StatelessWidget {
  const ProfileImageView({super.key, this.size = 120});
  final double size;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listenWhen: (previous, current) => previous.actionState != current.actionState,
      listener: (context, state) {
        if (state.actionState is LoadedState) {
          final AuthCubit authCubit = context.read<AuthCubit>();
          authCubit.updateUser(authCubit.state.user.copyWith(photoUrl: (state.actionState as LoadedState).data));
          Navigator.pop(context);
        } else if (state.actionState is ErrorState) {
          Navigator.pop(context);
          showSnackBar(context, (state.actionState as ErrorState).data, isError: true);
        }
      },
      buildWhen: (previous, current) => previous.actionState != current.actionState,
      builder: (context, state) {
        return Stack(
          children: [
            CircleAvatar(
              radius: size / 2,
              child: _buildPreview(
                  size: size,
                  context: context,
                  imageData: // when getting the image from firebase also fire action state
                      (state.actionState is LoadedState)
                          ? (state.actionState as LoadedState).data
                          : context.read<AuthCubit>().state.user.photoUrl ?? "",
                  isLoading: state.actionState is LoadingState),
            ),
            Positioned(
              bottom: -3,
              right: -3,
              child: CircleAvatar(
                radius: 24,
                backgroundColor: AppColors.gradientColor2,
                child: EdgeButton(
                  iconData: Icons.camera_alt,
                  onPressed: () async {
                    showCupertinoModalPopup(context: context, builder: (_) => getActions(context));
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  CupertinoActionSheet getActions(BuildContext context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () async {
              if (await isBelowAndroid32()) {
                if (context.mounted) {
                  await requestPermissionAndPickImage(context, Permission.camera, source: ImageSource.camera);
                }
              } else {
                if (context.mounted) {
                  await requestPermissionAndPickImage(context, Permission.photos, source: ImageSource.camera);
                }
              }
            },
            child: const Text("Take a photo"),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () async {
              if (await isBelowAndroid32()) {
                if (context.mounted) await requestPermissionAndPickImage(context, Permission.storage);
              } else {
                if (context.mounted) await requestPermissionAndPickImage(context, Permission.photos);
              }
            },
            child: const Text("Choose from gallery"),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      );

  Future<void> requestPermissionAndPickImage(BuildContext context, Permission permission,
      {ImageSource source = ImageSource.gallery}) async {
    PermissionStatus status = await permission.status;
    if (status.isDenied) {
      permission.request().then((value) {
        if (value == PermissionStatus.granted) {
          pickProfileImage(context, source: source);
        }
      });
    } else {
      if (context.mounted) pickProfileImage(context, source: source);
    }
  }

  void pickProfileImage(BuildContext context, {ImageSource source = ImageSource.gallery}) {
    if (context.mounted) {
      context.read<ProfileCubit>().pickProfileImage(source: source, uid: context.read<AuthCubit>().state.user.uid!);
    }
  }

  Widget _buildPreview(
      {required BuildContext context, required dynamic imageData, bool isLoading = false, double size = 120}) {
    late Widget image;
    final double size0 = size - 5; // -5 for the outsider border to be visible
    if (imageData is File) {
      image = Image.file(
        imageData,
        width: size0,
        height: size0,
        fit: BoxFit.cover,
      );
    } else if (imageData is String && imageData.isNotEmpty) {
      image = CachedImageView(image: imageData, width: size0, height: size0);
    } else {
      image = CachedImageView(image: '', width: size0, height: size0);
    }

    Widget viewImage = ClipOval(
      child: image,
    );

    if (isLoading) {
      return ImageUploadItem(
        image: viewImage,
        onRemove: () {
          context.read<ProfileCubit>().deleteImage();
        },
      );
    }

    return viewImage;
  }

  Future<bool> isBelowAndroid32() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      return androidInfo.version.sdkInt <= 32;
    }
    return true;
  }
}
