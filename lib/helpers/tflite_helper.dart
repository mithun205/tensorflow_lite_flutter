import 'dart:async';

import 'package:camera/camera.dart';
import 'package:tensorflow_lite_flutter/models/result.dart';
import 'package:tflite_v2/tflite_v2.dart';
//import 'package:tflite/tflite.dart';



import 'app_helper.dart';

class TFLiteHelper {
  static StreamController<List<Result>> tfLiteResultsController =
      StreamController.broadcast();
  static List<Result> _outputs = [];
  static bool modelLoaded = false;

  static Future<String?> loadModel() async {
    AppHelper.log("loadModel", "Loading model..");

    try {
      return await Tflite.loadModel(
        model: "assets/model_unquant.tflite",
        labels: "assets/labels.txt",
      );
    } catch (e) {
      AppHelper.log("loadModel", "Failed to load model: $e");
      return null;
    }
  }

  static classifyImage(CameraImage image) async {
    try {
      var results = await Tflite.runModelOnFrame(
        bytesList: image.planes.map((plane) => plane.bytes).toList(),
        numResults: 5,
      );

      if (results != null && results.isNotEmpty) {
        AppHelper.log("classifyImage", "Results loaded: ${results.length}");

        // Update the _outputs list instead of clearing it
        _outputs = results
            .map<Result>((result) => Result(
                  result['confidence'],
                  result[''],
                  result['label'],
                ))
            .toList();
      } else {
        AppHelper.log("classifyImage", "No results found.");
      }

      // Sort results according to most confidence
      _outputs.sort((a, b) => b.confidence.compareTo(a.confidence));

      // Send results
      tfLiteResultsController.add(_outputs);
    } catch (e) {
      AppHelper.log("classifyImage", "Failed to classify image: $e");
    }
  }

  static void disposeModel() {
    Tflite.close();
    tfLiteResultsController.close();
  }
}
