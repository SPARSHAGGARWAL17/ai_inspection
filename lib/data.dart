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
    FileUploadSection(sectionId: 'fronthouse', sectionName: 'Front with house number', maxPhotoAllowed: 2),
    FileUploadSection(sectionId: 'backside', sectionName: 'Backside Photo', maxPhotoAllowed: 4),
    FileUploadSection(sectionId: 'roof', sectionName: 'Roof', maxPhotoAllowed: 20),
    FileUploadSection(sectionId: 'chimney', sectionName: 'Chimney', maxPhotoAllowed: 10),
    FileUploadSection(sectionId: 'gutter', sectionName: 'Gutter', maxPhotoAllowed: 10),
    FileUploadSection(sectionId: 'windows', sectionName: 'Windows', maxPhotoAllowed: 15),
    FileUploadSection(sectionId: 'doors', sectionName: 'Doors', maxPhotoAllowed: 15),
    FileUploadSection(sectionId: 'siding', sectionName: 'Siding/Wall', maxPhotoAllowed: 15),
    FileUploadSection(sectionId: 'fence', sectionName: 'Fence', maxPhotoAllowed: 10),
    FileUploadSection(sectionId: 'backyard', sectionName: 'Backyard', maxPhotoAllowed: 10),
    FileUploadSection(sectionId: 'garage', sectionName: 'Garage', maxPhotoAllowed: 10),
    FileUploadSection(sectionId: 'pool', sectionName: 'Pool', maxPhotoAllowed: 7),
  ];
}
