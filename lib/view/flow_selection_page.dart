import 'package:ai_inspection/bloc/generate_report/generate_report_bloc.dart';
import 'package:ai_inspection/bloc/generate_report/generate_report_event.dart';
import 'package:ai_inspection/bloc/generate_report/generate_report_state.dart';
import 'package:ai_inspection/colors.dart';
import 'package:ai_inspection/services/dialog_service.dart';
import 'package:ai_inspection/view/details_page.dart';
import 'package:ai_inspection/widgets/bg_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    _Flows('Generate Report', 'GenerateReport'),
    _Flows('Schedule', '/'),
    _Flows('Other', '/'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Flow', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500)),
      ),
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
              if (flows[index].routeName == 'GenerateReport') {
                return _GenerateReportButton();
              }
              return InkWell(
                onTap: () {
                  if (flows[index].routeName == 'GenerateReport') {
                    return;
                  }
                  Navigator.of(context).pushNamed(flows[index].routeName);
                },
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.primaryLogoColor),
                  alignment: Alignment.center,
                  child: Text(
                    flows[index].name,
                    style: GoogleFonts.poppins(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
                  ),
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

class _GenerateReportButton extends StatelessWidget {
  _GenerateReportButton();

  final GenerateReportBloc _bloc = GenerateReportBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: BlocListener<GenerateReportBloc, GenerateReportState>(
        listener: (context, state) {
          if (state is GenerateReportInProgress) {
            DialogService().showDialog(
              context: context,
              widget: AlertDialog(content: Row(children: [CircularProgressIndicator(), SizedBox(width: 20), Text('Generating Report...')])),
            );
          } else {
            DialogService().hideDialog(context);
          }
          if (state is GenerateReportSuccess) {
            // Show success message
            DialogService().showDialog(
              context: context,
              widget: AlertDialog(
                title: Text('Success'),
                content: Text('Report generated successfully!'),
                actions: [
                  TextButton(
                    onPressed: () {
                      DialogService().hideDialog(context);
                    },
                    child: Text('OK'),
                  ),
                ],
              ),
            );
          } else if (state is GenerateReportFailure) {
            // Show failure message
            DialogService().showDialog(
              context: context,
              widget: AlertDialog(
                title: Text('Failure'),
                content: Text('Failed to generate report. Please try again.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      DialogService().hideDialog(context);
                    },
                    child: Text('OK'),
                  ),
                ],
              ),
            );
          }
        },
        child: InkWell(
          onTap: () {
            _bloc.add(GenerateReportRequested());
          },
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.primaryLogoColor),
            alignment: Alignment.center,
            child: Text(
              'Generate Report',
              style: GoogleFonts.poppins(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
