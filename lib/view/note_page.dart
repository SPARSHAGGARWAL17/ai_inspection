import 'package:ai_inspection/bloc/file_upload_bloc.dart';
import 'package:ai_inspection/bloc/file_upload_bloc_events.dart';
import 'package:ai_inspection/bloc/file_upload_bloc_state.dart';
import 'package:ai_inspection/services/dialog_service.dart';
import 'package:ai_inspection/view/success_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotePage extends StatefulWidget {
  static const String route = '/note-page';
  const NotePage({super.key, required this.bloc});

  final FileUploadBloc bloc;

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final TextEditingController noteController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  ValueNotifier<bool> submitButtonEnabled = ValueNotifier(false);

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  Future<void> showLoadingDialog() async {
    return DialogService().showDialog(
      context: context,
      widget: AlertDialog(
        content: BlocProvider.value(
          value: widget.bloc,
          child: BlocBuilder<FileUploadBloc, FileUploadState>(
            builder: (context, state) {
              if (state is FileUploadInProgress) {
                return SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Center(child: Text('Uploading files, please wait...')),
                      SizedBox(height: 20),
                      Center(child: LinearProgressIndicator(value: (state.currentFile / state.totalFiles).clamp(0, 1))),
                    ],
                  ),
                );
              } else {
                return SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Center(child: CircularProgressIndicator()),
                      Center(child: Text('Uploading files, please wait...')),
                      SizedBox(height: 20),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Future<void> showErrorDialog(String error) {
    return DialogService().showDialog(
      context: context, // barrierDismissible: false, // user must tap button!
      widget: AlertDialog(
        title: Text('Error'),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
        content: Text(error),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Write note")),
      bottomNavigationBar: ValueListenableBuilder<bool>(
        valueListenable: submitButtonEnabled,
        builder: (context, value, child) {
          return ElevatedButton(
            onPressed: !value
                ? null
                : () {
                    if (formKey.currentState?.validate() == true) {
                      widget.bloc.add(SubmitFiles(note: noteController.text));
                    }
                  },
            child: Text("Submit"),
          );
        },
      ),
      body: BlocProvider.value(
        value: widget.bloc,
        child: BlocListener<FileUploadBloc, FileUploadState>(
          listener: (context, state) {
            if (state is FileUploadFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
            } else if (state is FileUploadSuccess) {
              Navigator.of(context).pushNamedAndRemoveUntil(SuccessPage.route, (route) => route.isFirst);
            } else if (state is FileUploadInProgress) {
              showLoadingDialog();
            } else if (state is ValidationError) {
              showErrorDialog(state.error);
            }
          },
          child: SafeArea(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: noteController,
                      onChanged: (value) {
                        submitButtonEnabled.value = value.isNotEmpty;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter note.';
                        }
                        return null;
                      },
                      maxLines: 4,
                      decoration: InputDecoration(hintText: 'Write note', border: OutlineInputBorder()),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
