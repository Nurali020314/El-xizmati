import 'dart:async';

import 'package:camera/camera.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';
import 'package:onlinebozor/core/enum/enums.dart';
import 'package:onlinebozor/data/repositories/auth_repository.dart';
import 'package:onlinebozor/data/repositories/favorite_repository.dart';

part 'face_id_confirmation_cubit.freezed.dart';
part 'face_id_confirmation_state.dart';

@injectable
class FaceIdConfirmationCubit
    extends BaseCubit<FaceIdConfirmationState, FaceIdConfirmationEvent> {
  final AuthRepository _authRepository;
  final FavoriteRepository _favoriteRepository;

  FaceIdConfirmationCubit(
    this._authRepository,
    this._favoriteRepository,
  ) : super(const FaceIdConfirmationState()) {
    setupCamera();
  }

  void setupCamera() async {
    await initialCamera().then((value) {
      updateState((state) => state.copyWith(loadState: LoadingState.success));
    });
  }

  Future<void> initialCamera() async {
    List<CameraDescription> cameras = await availableCameras();
    final CameraController cameraController = CameraController(
      cameras[1],
      ResolutionPreset.high,
      enableAudio: false,
    );
    await cameraController.initialize();
    updateState((state) => state.copyWith(
          cameras: cameras,
          cameraController: cameraController,
          loadState: LoadingState.loading,
        ));
  }

  void setSecretKey(String secretKey) {
    updateState((state) => state.copyWith(secretKey: secretKey));
  }

  void sendImage(String image, String secretKey) async {
    updateState((state) => state.copyWith(loading: true));
    try {
      var res = await _authRepository.sendImage(image, secretKey);
      updateState((state) => state.copyWith(loadState: LoadingState.success));
      sendAllFavoriteAds();
      emitEvent(FaceIdConfirmationEvent(FaceIdConfirmationEventType.onSuccess));
    } catch (e) {
      updateState((state) => states.copyWith(showPicture: false));
      emitEvent(FaceIdConfirmationEvent(FaceIdConfirmationEventType.onFailure));
      stateMessageManager.showErrorSnackBar(e.toString());
    } finally {
      updateState((state) => state.copyWith(loading: false));
    }
  }

  Future<void> sendAllFavoriteAds() async {
    try {
      await _favoriteRepository.pushAllFavoriteAds();
    } catch (error) {
      stateMessageManager.showErrorSnackBar("Xatolik yuz berdi");
      emitEvent(FaceIdConfirmationEvent(FaceIdConfirmationEventType.onSuccess));
    }
  }

  void closeIntroPage() {
    updateState((state) => state.copyWith(introState: false));
  }

  void showPicture(bool value) {
    updateState((state) => state.copyWith(showPicture: value));
  }

  void croppedImage(String value) {
    updateState((state) => state.copyWith(cropperImage: value));
  }
}