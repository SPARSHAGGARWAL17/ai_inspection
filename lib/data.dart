import 'package:ai_inspection/model/file_upload.dart';

class AppStaticData {
  static List<FileUploadSection> uploadSections = [
    //     •⁠  ⁠Front with house number (2 photos)
    // •⁠  ⁠Backside Photo (2-4 photos)
    // •⁠  ⁠Roof (15-20 photos)
    // •⁠  ⁠Chimney (5-10 photos)
    // •⁠  ⁠Gutter (5-10 Photos)
    // •⁠  ⁠Windows (10-15 photos)
    // •⁠  ⁠Doors (10-15 photos)
    // •⁠  ⁠Siding/Wall (10-15 photos)
    // •⁠  ⁠Fence (5-10 photos)
    // •⁠  ⁠Backyard (5-10 photos)
    // •⁠  ⁠Garage (5-10 photos)
    // •⁠  ⁠Pool (4-7 photos)
    FileUploadSection(sectionId: 'roof', sectionName: 'Roof', maxPhotoAllowed: 8),
    FileUploadSection(sectionId: 'fronthouse', sectionName: 'Front with house number', maxPhotoAllowed: 8),
    FileUploadSection(sectionId: 'right', sectionName: 'Right Side', maxPhotoAllowed: 8),
    FileUploadSection(sectionId: 'left', sectionName: 'Left Side', maxPhotoAllowed: 8),
    FileUploadSection(sectionId: 'rear', sectionName: 'Rear Side', maxPhotoAllowed: 8),
    FileUploadSection(sectionId: 'fence', sectionName: 'Fence', maxPhotoAllowed: 8),
    FileUploadSection(sectionId: 'extra', sectionName: 'Extras', maxPhotoAllowed: 10),
  ];
}
