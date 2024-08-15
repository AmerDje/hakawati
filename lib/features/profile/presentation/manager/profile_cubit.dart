import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hakawati/core/common/common.dart';
import 'package:hakawati/features/auth/data/models/user.dart';
import 'package:hakawati/features/auth/data/repository/auth_repository_impl.dart';
import 'package:image_picker/image_picker.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final AuthRepositoryImpl authRepository;
  ProfileCubit({required this.authRepository}) : super(const ProfileState());

  void pickProfileImage({required ImageSource source, required String uid}) async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: source,
      );
      if (pickedFile != null) {
        emit(state.copyWith(actionState: LoadedState(data: File(pickedFile.path))));
        uploadProfileImage(pickedFile.path, uid);
      } else {
        emit(state.copyWith(actionState: const ErrorState(data: 'No image selected')));
      }
    } catch (_) {}
  }

  void uploadProfileImage(String imagePath, String uid) async {
    emit(state.copyWith(actionState: const LoadingState()));
    final result = await authRepository.uploadImage(File(imagePath));
    result.fold((failure) => emit(state.copyWith(actionState: ErrorState(data: failure.message))), (imageUrl) {
      emit(state.copyWith(actionState: LoadedState(data: imageUrl)));
      authRepository.updateUser(uid, {'image_url': imageUrl});
    });
  }

  void deleteImage() {
    emit(state.copyWith(actionState: const InitState()));
  }

  Future<void> updateUser(UserModel user) async {
    emit(UpdateUserProfileLoading());
    final result = await authRepository.updatePersonalData(user);
    result.fold(
      (failure) => emit(UpdateUserProfileFailure(errMessage: failure.message)),
      (user) => emit(UpdateUserProfileSuccess(user: user)),
    );
  }
}
