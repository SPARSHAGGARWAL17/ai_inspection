import 'package:ai_inspection/colors.dart';
import 'package:ai_inspection/firebase_options.dart';
import 'package:ai_inspection/routes.dart';
import 'package:ai_inspection/view/landing_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Inspection',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          elevation: 0,
          foregroundColor: AppColors.primaryColor,
          titleTextStyle: GoogleFonts.poppins(color: AppColors.primaryColor, fontSize: 18, fontWeight: FontWeight.w400),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            textStyle: GoogleFonts.poppins(),
            backgroundColor: AppColors.primaryColor,
            minimumSize: const Size.fromHeight(50),
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      onGenerateRoute: RoutesGenerator.generateRoute,
      initialRoute: LandingPage.route,
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(title: Text('Error')),
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
      },
    );
  }
}
