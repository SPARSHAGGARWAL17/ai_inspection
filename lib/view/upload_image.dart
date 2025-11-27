import 'dart:io';

import 'package:ai_inspection/bloc/file_upload_bloc.dart';
import 'package:ai_inspection/bloc/file_upload_bloc_events.dart';
import 'package:ai_inspection/bloc/file_upload_bloc_state.dart';
import 'package:ai_inspection/data.dart';
import 'package:ai_inspection/model/user_details.dart';
import 'package:ai_inspection/services/dialog_service.dart';
import 'package:ai_inspection/services/firebase_upload_file_service.dart';
import 'package:ai_inspection/view/note_page.dart';
import 'package:ai_inspection/view/success_page.dart';
import 'package:ai_inspection/widgets/bg_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:typed_data';

import 'package:image_picker_web/image_picker_web.dart';

class UploadImagePage extends StatefulWidget {
  static const String route = '/upload-image';
  final UserDetails userDetails;

  const UploadImagePage({super.key, required this.userDetails});

  @override
  State<UploadImagePage> createState() => _UploadImagePageState();
}

class _UploadImagePageState extends State<UploadImagePage> {
  late final FileUploadBloc bloc;

  @override
  void initState() {
    bloc = FileUploadBloc(fileService: FirebaseUploadFileService(), userDetails: widget.userDetails);
    bloc.add(InitializeFileUpload(AppStaticData.uploadSections));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: BlocProvider.value(
        value: bloc,
        child: BlocBuilder<FileUploadBloc, FileUploadState>(
          buildWhen: (previous, current) {
            if (current is FileUploadInProgress || current is FileUploadSuccess || current is ValidationError) {
              return false;
            }
            return true;
          },
          builder: (context, state) {
            if (state is FileUploadInitial) {
              return Scaffold(
                bottomNavigationBar: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: state.prevSectionAvailable
                              ? () {
                                  bloc.add(PrevPageEvent());
                                  return;
                                }
                              : null,
                          child: Text('Prev'),
                        ),
                      ),
                      Expanded(flex: 2, child: SizedBox()),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (state.nextSectionAvailable) {
                              bloc.add(NextPageEvent());
                              return;
                            } else {
                              Navigator.of(context).pushNamed(NotePage.route, arguments: bloc);
                            }
                          },
                          child: Text(state.nextSectionAvailable ? 'Next' : 'Submit'),
                        ),
                      ),
                    ],
                  ),
                ),
                appBar: AppBar(title: Text('Upload Images')),
                body: BackgroundImage(
                  child: Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10).copyWith(top: 5),
                          child: Text(
                            'Upload images for: ${state.section.sectionName} (Max. ${state.section.maxPhotoAllowed})',
                            style: GoogleFonts.poppins(fontSize: 12),
                          ),
                        ),
                        Expanded(
                          child: GridView.builder(
                            padding: EdgeInsets.all(10),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                            itemCount: state.section.photos.length + 1,
                            itemBuilder: (context, index) {
                              if (index == state.section.photos.length) {
                                return InkWell(
                                  onTap: () async {
                                    Uint8List? image = await pickPhoto();
                                    if (image != null) {
                                      bloc.add(AddPhotoEvent(state.section.sectionId, image));
                                    }
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(5),
                                    color: Colors.grey[300],
                                    child: Icon(Icons.add_a_photo, color: Colors.grey[700]),
                                  ),
                                );
                              } else {
                                if (kIsWeb) {
                                  // Assume you store Uint8List for web
                                  return Stack(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(5),
                                        color: Colors.grey[300],
                                        child: Image.memory(state.section.photos.entries.elementAt(index).value, fit: BoxFit.cover),
                                      ),
                                      Positioned(
                                        right: 0,
                                        child: IconButton(
                                          onPressed: () {
                                            bloc.add(RemovePhotoEvent(state.section.sectionId, state.section.photos.keys.elementAt(index)));
                                          },
                                          icon: Icon(Icons.delete, color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  // Mobile/desktop: File
                                  return Container(
                                    margin: EdgeInsets.all(5),
                                    color: Colors.grey[300],
                                    child: Image.memory(state.section.photos.entries.elementAt(index).value, fit: BoxFit.cover),
                                  );
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Scaffold(
                appBar: AppBar(title: Text('Upload Images')),
                body: Center(child: CircularProgressIndicator()),
              );
            }
          },
        ),
      ),
    );
  }

  Future<Uint8List?> pickPhoto() async {
    if (kIsWeb) {
      Uint8List? picker = await ImagePickerWeb.getImageAsBytes();
      if (picker != null) {
        return picker;
      }
    }
    ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (image != null) {
      return await image.readAsBytes();
    }
    return null;
  }
}
