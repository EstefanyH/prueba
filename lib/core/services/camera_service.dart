import 'package:image_picker/image_picker.dart';

class CameraService {
  final ImagePicker _picker = ImagePicker();

  Future<XFile?> openCamera() async {
    return await _picker.pickImage(source: ImageSource.camera);
  }
}