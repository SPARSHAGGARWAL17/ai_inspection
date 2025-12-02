import 'dart:typed_data';

/// Stub implementation for image_picker_web on non-web platforms
class ImagePickerWeb {
  static Future<Uint8List?> getImageAsBytes() {
    throw UnsupportedError('ImagePickerWeb is only available on web platform');
  }
}
