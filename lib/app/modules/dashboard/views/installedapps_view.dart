import '../../apps/views/apps_installed_view.dart';
import 'package:flutter/material.dart';
import '../../../modules/dashboard/controllers/dashboard_controller.dart';

class dashboardInstalledView extends StatelessWidget {
  final List installedapps;
  final int coloumns;

  dashboardInstalledView({
    Key? key,
    required this.installedapps,
    required this.noDataTextStyle,
    required this.coloumns,
    required this.controller

  }) : super(key: key);

  // final DashboardController controller;
  final TextStyle noDataTextStyle;
  final DashboardController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.grey[900],
        toolbarHeight: 50,
        title: Center(
          child: SizedBox(
            width: 350, // Adjust width as needed
            child: GestureDetector(
              onTap: () {
                controller.gotoAppsList(controller.selectedIndex.value);
              },
              child: Container(

                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search,
                      size: 20,
                      color: Colors.grey[500],
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Search',
                      style: TextStyle(color: Colors.grey[500], fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: InstalledAppsView(
          installedapps: installedapps,
          coloumns: coloumns,
          noDataTextStyle: noDataTextStyle,
          color: Color(0xFFFF9236),
      ),
    );
  }
}