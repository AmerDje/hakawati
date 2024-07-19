import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hakawati/core/common/bloc/state_base.dart';
import 'package:hakawati/core/utils/utils.dart';
import 'package:hakawati/core/widgets/cached_image_view.dart';
import 'package:hakawati/features/profile/presentation/manager/profile_cubit.dart';
import 'package:hakawati/features/profile/presentation/view/widgets/statistics_text.dart';
import 'package:hakawati/features/settings/presentation/views/settings/view/settings_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'edge_button.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 150,
          decoration: const ShapeDecoration(
            shape: StadiumBorder(),
            color: AppColors.gradientColor2,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 20),
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  return Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        child: _buildPreview(
                            context: context,
                            imageData: // when getting the image from firebase also fire action state
                                (state.actionState is LoadedState) ? (state.actionState as LoadedState).data : "",
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
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Hi, User Name",
                      style: Styles.fontStyle26(context).copyWith(color: Theme.of(context).secondaryHeaderColor)),
                  const Row(
                    children: [
                      StatisticsTexts(),
                      SizedBox(
                        width: 20,
                      ),
                      StatisticsTexts(),
                    ],
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: EdgeButton(
            iconData: Icons.settings,
            onPressed: () {
              context.go(const SettingsView());
            },
          ),
        )
      ],
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
            child: const Text("Choose from library"),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: const Text("cancel"),
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
        Navigator.pop(context);
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
      context.read<ProfileCubit>().pickProfileImage(source: source);
    }
  }

  Widget _buildPreview({required BuildContext context, required dynamic imageData, bool isLoading = false}) {
    late Widget image;

    if (imageData is File) {
      image = Image.file(
        imageData,
        width: 115,
        height: 120,
        fit: BoxFit.cover,
      );
    } else if (imageData is String && imageData.isNotEmpty) {
      image = CachedImageView(image: imageData, width: 115, height: 115);
    } else {
      image = const CachedImageView(image: '', width: 115, height: 115);
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

class ImageUploadItem extends StatelessWidget {
  final Widget image;
  final GestureTapCallback onRemove;

  const ImageUploadItem({
    super.key,
    required this.image,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        image,
        PositionedDirectional(
          top: 0,
          end: -3,
          child: InkResponse(
            onTap: onRemove,
            child: Container(
              width: 20,
              height: 20,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: theme.colorScheme.error, shape: BoxShape.circle),
              child: const Icon(Icons.close, size: 13, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
