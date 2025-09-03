import 'package:ai_inspection/view/success_page.dart';
import 'package:flutter/material.dart';

class UploadImagePage extends StatelessWidget {
  static const String route = '/upload-image';
  const UploadImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10),
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(SuccessPage.route);
          },
          child: Text('Submit'),
        ),
      ),
      appBar: AppBar(title: Text('Upload Images')),
      body: SafeArea(
        child: GridView.builder(
          padding: EdgeInsets.all(10).copyWith(top: 5),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemCount: 5,
          itemBuilder: (context, index) {
            if (index == 4) {
              return Container(
                margin: EdgeInsets.all(5),
                color: Colors.grey[300],
                child: Icon(Icons.add_a_photo, color: Colors.grey[700]),
              );
            } else {
              return Container(
                margin: EdgeInsets.all(5),
                color: Colors.grey[300],
                child: Image.asset('assets/person.jpeg', fit: BoxFit.cover),
              );
            }
          },
        ),
      ),
    );
  }
}
