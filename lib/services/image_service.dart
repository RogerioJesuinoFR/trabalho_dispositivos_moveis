import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ImageService {
  static final ImagePicker _picker = ImagePicker();

  static Future<File?> pickImage() async {
    final XFile? image =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 70);

    if (image == null) return null;

    final Directory appDir = await getApplicationDocumentsDirectory();
    final String fileName = basename(image.path);
    final String savedImagePath = '${appDir.path}/$fileName';

    final File savedImage = await File(image.path).copy(savedImagePath);
    return savedImage;
  }
}
