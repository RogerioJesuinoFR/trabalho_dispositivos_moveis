import 'package:camera/camera.dart';

class CameraService {
  CameraController? _controller;

  Future<void> initCamera() async {
    final cameras = await availableCameras();
    final camera = cameras.first;

    _controller = CameraController(camera, ResolutionPreset.medium);
    await _controller!.initialize();
  }

  CameraController? get controller => _controller;

  Future<void> dispose() async {
    await _controller?.dispose();
  }
}
