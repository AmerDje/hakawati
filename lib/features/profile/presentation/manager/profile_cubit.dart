import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hakawati/core/common/common.dart';
import 'package:image_picker/image_picker.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(const ProfileState());

  void pickProfileImage({required ImageSource source}) async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: source,
      );
      // emit(state.copyWith(actionState: const LoadingState()));
      if (pickedFile != null) {
        emit(state.copyWith(actionState: LoadedState(data: File(pickedFile.path))));
        // firebase_storage.FirebaseStorage.instance
        //     .ref(
        //         'uploads/${AppBloc.get(context).postImage!.path.split('/').last}')
        //     .putFile(AppBloc.get(context).postImage!)
        //     .then((p0) {
        //   debugPrint(p0.state.name);

        //   p0.ref.getDownloadURL().then((value) {
        //     PostDataModel model = PostDataModel(
        //       image: value,
        //       likes: [],
        //       ownerImage: AppBloc.get(context).user!.image,
        //       ownerName: AppBloc.get(context).user!.username,
        //       shares: 0,
        //       text: postTextController.text,
        //       time: formattedDate,
        //       comments: [],
        //     );

        //     FirebaseFirestore.instance
        //         .collection('posts')
        //         .add(model.toJson())
        //         .then((value) {
        //       setState(() {
        //         isClicked = false;
        //       });

        //       navigateAndFinish(
        //         context,
        //         const HomeScreen(),
        //       );
        //     }).catchError((error) {
        //       Fluttertoast.showToast(
        //         msg: error.toString(),
        //       );
        //     });
        //   }).catchError((error) {
        //     Fluttertoast.showToast(
        //       msg: error.toString(),
        //     );
        //   });
        // })
        //     .catchError((error) {
        //   Fluttertoast.showToast(
        //     msg: error.toString(),
        //   );
        // });
      } else {
        emit(state.copyWith(actionState: const ErrorState(data: 'No image selected')));
      }
    } catch (_) {}
  }

  void deleteImage() {
    emit(state.copyWith(actionState: const InitState()));
  }
}
