import 'package:flutter/material.dart';
import 'package:trainer_application/core/widgets/app_drawer.dart';
import 'package:trainer_application/core/widgets/custom_appBar.dart';

class TraningScreen extends StatefulWidget {
  const TraningScreen({super.key});

  @override
  State<TraningScreen> createState() => _TraningScreenState();
}

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class _TraningScreenState extends State<TraningScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const AppDrawer(),

      appBar: CustomAppBar(
        title: "Training",
        onMenuTap: () {
          scaffoldKey.currentState?.openDrawer();
        },
        onNotificationTap: () {},
        onProfileTap: () {},
      ),

      body: Container(child: Text("Traing screen")),
    );
  }
}
