import 'package:ai_inspection/view/details_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SuccessPage extends StatelessWidget {
  static const String route = '/success';
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Color(0xff363636),
        bottomNavigationBar: Container(
          child: ElevatedButton(
            style: ButtonStyle(shape: WidgetStatePropertyAll(RoundedRectangleBorder()), backgroundColor: WidgetStatePropertyAll(Color(0xff56E19D))),
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(DetailsPage.route, (route) {
                return route.isFirst;
              });
            },
            child: Text('Generate Another Report', style: GoogleFonts.poppins(color: Color(0xff363636))),
          ),
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Image.asset('assets/success.gif')]),
      ),
    );
  }
}
