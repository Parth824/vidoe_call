import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class ReProvider extends ChangeNotifier {
  int _index = 1;

  late CameraController cameraController;
  

  get index => _index;

  get cam => cameraController;

  updateIndex({required int i,required var mounted}) async{
    _index = i;
    cameraController = CameraController(cameras[i], ResolutionPreset.max);
    cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }
      notifyListeners();
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
          // Handle access errors here.
            break;
          default:
          // Handle other errors here.
            break;
        }
      }
    });
    
  }

  
}