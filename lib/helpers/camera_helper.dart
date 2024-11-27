import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:tensorflow_lite_flutter/helpers/app_helper.dart';
import 'package:tensorflow_lite_flutter/helpers/tflite_helper.dart';

class CameraHelper {
  static CameraController? camera;

  static bool isDetecting = false;
  static CameraLensDirection _direction = CameraLensDirection.back;
  static Future<void>? initializeControllerFuture;

  static Future<CameraDescription> _getCamera(CameraLensDirection dir) async {
    final cameras = await availableCameras();
    return cameras.firstWhere(
      (CameraDescription camera) => camera.lensDirection == dir,
    );
  }

  static Future<void> initializeCamera() async {                         ////////////////////////////
    AppHelper.log("_initializeCamera", "Initializing camera..");

    try {
      camera = CameraController(
        await _getCamera(_direction),
        defaultTargetPlatform == TargetPlatform.android
            ? ResolutionPreset.low
            : ResolutionPreset.high,
            //enableAudio: true,                           //------------------////////////////////////
      );

      initializeControllerFuture = camera!.initialize().then((value) {
        AppHelper.log(
          "_initializeCamera",
          "Camera initialized, starting camera stream..",
        );

        camera!.startImageStream((CameraImage image) {
          if (!TFLiteHelper.modelLoaded) return;
          if (isDetecting) return;
          isDetecting = true;
          try {
            TFLiteHelper.classifyImage(image);
          } catch (e) {
            if (kDebugMode) {
              print(e);
            }
          } finally {
            isDetecting = false; // Reset detecting flag after processing
          }
        });
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error initializing camera: $e");
      }
    }
  }

   static Future<void> switchCamera() async {
    _direction = _direction == CameraLensDirection.back
        ? CameraLensDirection.front
        : CameraLensDirection.back;
    await initializeCamera();
  }
}
