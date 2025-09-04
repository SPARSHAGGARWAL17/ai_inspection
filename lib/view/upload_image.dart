import 'dart:io';

import 'package:ai_inspection/bloc/file_upload_bloc.dart';
import 'package:ai_inspection/bloc/file_upload_bloc_events.dart';
import 'package:ai_inspection/bloc/file_upload_bloc_state.dart';
import 'package:ai_inspection/data.dart';
import 'package:ai_inspection/view/success_page.dart';
import 'package:ai_inspection/widgets/bg_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class UploadImagePage extends StatefulWidget {
  static const String route = '/upload-image';
  const UploadImagePage({super.key});

  @override
  State<UploadImagePage> createState() => _UploadImagePageState();
}

class _UploadImagePageState extends State<UploadImagePage> {
  late final FileUploadBloc bloc;

  @override
  void initState() {
    bloc = FileUploadBloc();
    bloc.add(InitializeFileUpload(AppStaticData.uploadSections));
    super.initState();
  }

  Future<void> showLoadingDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Center(child: CircularProgressIndicator()),
                SizedBox(height: 20),
                Center(child: Text('Uploading files, please wait...')),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocConsumer<FileUploadBloc, FileUploadState>(
        listener: (context, state) {
          if (state is FileUploadFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
          } else if (state is FileUploadSuccess) {
            Navigator.of(context).pushNamed(SuccessPage.route);
          } else if (state is FileUploadInProgress) {
            showLoadingDialog();
          }
        },
        buildWhen: (previous, current) {
          if (current is FileUploadInProgress || current is FileUploadSuccess) {
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
                            bloc.add(SubmitFiles());
                          }
                        },
                        child: Text(state.nextSectionAvailable ? 'Next' : 'Submit'),
                      ),
                    ),
                  ],
                ),
              ),
              appBar: AppBar(title: Text('Upload Images')),
              body: SafeArea(
                child: BackgroundImage(
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
                            itemCount: state.section.uploadedPhotos.length + 1,
                            itemBuilder: (context, index) {
                              if (index == state.section.uploadedPhotos.length) {
                                return InkWell(
                                  onTap: () async {
                                    File? image = await pickPhoto();
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
                                return Container(
                                  margin: EdgeInsets.all(5),
                                  color: Colors.grey[300],
                                  child: Image.file(state.section.uploadedPhotos[index], fit: BoxFit.cover),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
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
    );
  }

  Future<File?> pickPhoto() async {
    ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (image != null) {
      return File(image.path);
    }
    return null;
  }
}
