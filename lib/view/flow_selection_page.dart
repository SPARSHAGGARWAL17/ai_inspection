import 'package:ai_inspection/view/details_page.dart';
import 'package:ai_inspection/widgets/bg_wrapper.dart';
import 'package:flutter/material.dart';

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
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var flow in flows) ...[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, flow.routeName);
                    },
                    child: Text(flow.name),
                  ),
                  SizedBox(height: 20),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
