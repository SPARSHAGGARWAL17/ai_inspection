import 'package:ai_inspection/colors.dart';
import 'package:ai_inspection/view/details_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingPage extends StatelessWidget {
  static const String route = '/';
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10),
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(DetailsPage.route);
          },
          child: Text('Get Started'),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/person.jpeg'),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Next-Gen Property\nInspection App',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0).copyWith(top: 0),
              child: Text(
                'Streamlining Property Damage Assessments with Al & Cloud Integration',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: AppColors.secondaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
