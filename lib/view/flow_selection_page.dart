import 'package:ai_inspection/colors.dart';
import 'package:ai_inspection/view/details_page.dart';
import 'package:ai_inspection/widgets/bg_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class _Flows {
  final String name;
  final String routeName;

  _Flows(this.name, this.routeName);
}

class FlowSelectionPage extends StatefulWidget {
  static const String route = '/flow-selection';
  const FlowSelectionPage({super.key});

  @override
  State<FlowSelectionPage> createState() => _FlowSelectionPageState();
}

class _FlowSelectionPageState extends State<FlowSelectionPage> {
  final List<_Flows> flows = [
    _Flows('Start Inspection', DetailsPage.route),
    _Flows('Generate Report', '/'),
    _Flows('Schedule', '/'),
    _Flows('Other', '/'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Flow')),
      body: BackgroundImage(
        child: Center(
          child: GridView.builder(
            padding: EdgeInsets.all(40),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 30,
              mainAxisSpacing: 30,
              childAspectRatio: 2 / 1,
            ),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(flows[index].routeName);
                },
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.primaryColor),
                  alignment: Alignment.center,
                  child: Text(flows[index].name, style: GoogleFonts.poppins(fontSize: 20, color: Colors.white)),
                ),
              );
            },
            itemCount: flows.length,
          ),
        ),
      ),
    );
  }
}
