import 'package:ai_inspection/model/user_details.dart';
import 'package:ai_inspection/view/upload_image.dart';
import 'package:ai_inspection/widgets/bg_wrapper.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  static const String route = '/details';
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final UserDetails userDetails = UserDetails.empty();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState?.validate() != true) {
              return;
            }
            _formKey.currentState?.save();
            Navigator.of(context).pushNamed(UploadImagePage.route, arguments: userDetails);
          },
          child: Text('Start Inspection'),
        ),
      ),
      appBar: AppBar(title: Text('Fill your details')),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: BackgroundImage(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0).copyWith(top: 0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.55,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        PrimaryTextField(
                          labelName: 'Full Name',
                          onSaved: (val) {
                            userDetails.name = val ?? '';
                          },
                          validator: (val) {
                            if (val == null || val.isEmpty == true) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        PrimaryTextField(
                          labelName: 'Email Address',
                          onSaved: (val) {
                            userDetails.email = val ?? '';
                          },
                          keyboardType: TextInputType.emailAddress,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return null;
                            } else {
                              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(val)) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            }
                          },
                        ),
                        PrimaryTextField(
                          labelName: 'Mobile No.',
                          onSaved: (val) {
                            userDetails.mobileNo = val ?? '';
                          },
                          keyboardType: TextInputType.phone,
                          validator: (val) {
                            if (val == null || val.isEmpty == true) {
                              return 'Please enter your mobile number';
                            }
                            if (!RegExp(r'^\d{10}$').hasMatch(val)) {
                              return 'Please enter a valid 10-digit mobile number';
                            }
                            return null;
                          },
                        ),
                        PrimaryTextField(
                          labelName: 'Address',
                          onSaved: (val) {
                            userDetails.address = val ?? '';
                          },
                          maxLines: 4,
                          validator: (val) {
                            if (val == null || val.isEmpty == true) {
                              return 'Please enter your address';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PrimaryTextField extends StatelessWidget {
  const PrimaryTextField({
    super.key,
    required this.labelName,
    this.maxLines,
    this.validator,
    this.controller,
    this.onChanged,
    this.onSaved,
    this.keyboardType,
  });

  final String labelName;
  final int? maxLines;
  final TextEditingController? controller;
  final String? Function(String? val)? validator;
  final void Function(String val)? onChanged;
  final void Function(String? val)? onSaved;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      onSaved: onSaved,
      maxLines: maxLines,
      onChanged: onChanged,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        labelText: labelName,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
      ),
    );
  }
}
