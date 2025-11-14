import 'package:ai_inspection/bloc/file_upload_bloc.dart';
import 'package:ai_inspection/model/user_details.dart';
import 'package:ai_inspection/view/details_page.dart';
import 'package:ai_inspection/view/landing_page.dart';
import 'package:ai_inspection/view/note_page.dart';
import 'package:ai_inspection/view/success_page.dart';
import 'package:ai_inspection/view/upload_image.dart';
import 'package:flutter/material.dart';

class RoutesGenerator {
  static const String landing = LandingPage.route;
  static const String fillDetails = DetailsPage.route;
  static const String uploadImages = UploadImagePage.route;
  static const String success = SuccessPage.route;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    Widget page;
    switch (settings.name) {
      case landing:
        page = LandingPage();
      case fillDetails:
        page = DetailsPage();
      case uploadImages:
        page = UploadImagePage(userDetails: settings.arguments as UserDetails);
      case SuccessPage.route:
        page = SuccessPage();
      case NotePage.route:
        page = NotePage(
          bloc: settings.arguments as FileUploadBloc,
        );
      default:
        page = Scaffold(body: Center(child: Text('No route defined for ${settings.name}')));
    }
    return MaterialPageRoute(builder: (_) => page);
  }
}
