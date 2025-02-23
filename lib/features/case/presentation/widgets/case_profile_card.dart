import 'package:flutter/material.dart';

import 'package:tatpar_orange/features/case/presentation/widgets/info_tile.dart';

import '../../../../configurations/theme/size_constants.dart';

class CaseProfileCard extends StatelessWidget {
  const CaseProfileCard({
    super.key,
    required this.patientName,
    required this.mobileNumber,
    required this.panchayat,
    required this.district,
    required this.screeningStatus,
    required this.rifResistance,
    required this.statusAfterDx,
    required this.treatmentOutcome,
  });

  final String patientName;
  final String mobileNumber;
  final String panchayat;
  final String district;
  final String screeningStatus;
  final String rifResistance;
  final String statusAfterDx;
  final String treatmentOutcome;

  @override
  Widget build(BuildContext context) {
    final isPresumptive = screeningStatus.contains('Presumptive');
    return Container(
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(kPadding),
      ),
      margin: const EdgeInsets.symmetric(vertical: kPadding * 1.75),
      padding: const EdgeInsets.symmetric(
        vertical: kPadding * 1.5,
        horizontal: kPadding * 2,
      ),
      child: Column(
        children: [
          InfoTile(
            'Patient name',
            fieldValue: patientName,
            useExpandedDots: false,
          ),
          InfoTile(
            'Mobile Number',
            fieldValue: mobileNumber,
          ),
          InfoTile(
            'Panchayat',
            fieldValue: panchayat,
          ),
          InfoTile(
            'District',
            fieldValue: district,
          ),
          InfoTile(
            'Screening Status',
            fieldValue:
                screeningStatus.isEmpty ? 'Not Filled' : screeningStatus,
            fieldColor: screeningStatus.isEmpty ? Colors.red : Colors.green,
            useExpandedDots: false,
          ),
          InfoTile(
            'Rif Resistance',
            fieldValue: rifResistance,
          ),
          InfoTile(
            'Diagnosis Initiation',
            fieldValue: isPresumptive ? 'Not Initiated' : 'In Progress',
            fieldColor: isPresumptive ? Colors.red : Colors.green,
            useExpandedDots: false,
          ),
          InfoTile(
            'Status after Dx',
            fieldValue: statusAfterDx,
          ),
          InfoTile(
            'Treatment Outcome',
            fieldValue: treatmentOutcome,
          ),
        ],
      ),
    );
  }
}
