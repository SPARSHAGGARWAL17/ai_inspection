import 'package:ai_inspection/colors.dart';
import 'package:ai_inspection/view/details_page.dart';
import 'package:ai_inspection/view/flow_selection_page.dart';
import 'package:ai_inspection/widgets/bg_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingPage extends StatefulWidget {
  static const String route = '/';
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool termsAccepted = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(20).copyWith(bottom: 0),
              child: ElevatedButton(
                onPressed: termsAccepted
                    ? () {
                        Navigator.of(context).pushNamed(FlowSelectionPage.route);
                      }
                    : null,
                child: Text('Get Started'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 5),
              child: Row(
                children: [
                  Checkbox(
                    value: termsAccepted,
                    onChanged: (value) {
                      setState(() {
                        termsAccepted = value ?? false;
                      });
                    },
                  ),
                  Text('I agree to the ', style: GoogleFonts.poppins(fontSize: 12, color: AppColors.secondaryColor)),
                  TextButton(
                    style: ButtonStyle(
                      padding: WidgetStatePropertyAll(EdgeInsets.zero),
                      minimumSize: WidgetStatePropertyAll(Size(0, 0)),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      alignment: Alignment.centerLeft,
                    ),
                    onPressed: () {},
                    child: Text(
                      'Terms & Conditions',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                        decorationStyle: TextDecorationStyle.solid,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: BackgroundImage(
          child: Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/person.jpeg'),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Next-Gen Property\nInspection App',
                    style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0).copyWith(top: 0),
                  child: Text(
                    'Streamlining Property Damage Assessments with Al & Cloud Integration',
                    style: GoogleFonts.poppins(fontSize: 20, color: AppColors.secondaryColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
