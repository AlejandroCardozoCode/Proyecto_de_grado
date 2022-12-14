import 'package:electrocardio/models/fhir/patient_fhir.dart';
import 'package:electrocardio/theme/theme.dart';
import 'package:electrocardio/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/fhir/practitioner_fhir.dart';

class PatientListScreen extends StatefulWidget {
  const PatientListScreen({Key? key}) : super(key: key);

  @override
  State<PatientListScreen> createState() => _PatientListScreenState();
}

class _PatientListScreenState extends State<PatientListScreen> {
  bool applyFilter = false;
  String filter = "";
  List<AppPatient> patientsList = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppPractitioner practitioner = context.watch<AppPractitioner>();
    if (applyFilter) {
      patientsList = practitioner.patientList.where((element) => element.id.contains(filter)).toList();
    } else {
      patientsList = practitioner.patientList;
    }
    return SafeArea(
      child: Scaffold(
        appBar: ApplicationAppBar(darkIcons: true),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              child: Card(
                elevation: 5,
                child: TextField(
                  onChanged: (value) {
                    if (value != "") {
                      applyFilter = true;
                      filter = value;
                    } else {
                      applyFilter = false;
                    }
                    setState(() {});
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: "Buscar por cédula",
                    suffixIcon: Icon(
                      Icons.search,
                      color: ThemeApp.primary,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await practitioner.generatePatients();
                },
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: patientsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return PatientBanner(
                      enableOnTap: true,
                      bannerPatient: patientsList[index],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
