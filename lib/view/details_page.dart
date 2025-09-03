import 'package:ai_inspection/view/upload_image.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  static const String route = '/details';
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(UploadImagePage.route);
          },
          child: Text('Start Inspection'),
        ),
      ),
      appBar: AppBar(title: Text('Fill your details')),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0).copyWith(top: 0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.55,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PrimaryTextField(labelName: 'Full Name'),
                  PrimaryTextField(labelName: 'Email Address'),
                  PrimaryTextField(labelName: 'Mobile No.'),
                  PrimaryTextField(labelName: 'Address', maxLines: 4),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PrimaryTextField extends StatelessWidget {
  const PrimaryTextField({super.key, required this.labelName, this.maxLines});

  final String labelName;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        labelText: labelName,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      ),
    );
  }
}
