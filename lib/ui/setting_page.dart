import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_restaurant/cummon/styles.dart';
import 'package:my_restaurant/data/provider/prefreces_provider.dart';
import 'package:my_restaurant/data/provider/scheduling_provider.dart';
import 'package:my_restaurant/widgets/custom_dialog.dart';
import 'package:my_restaurant/widgets/platform_widget.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  static const routeName = "/setting_screen";

  const SettingPage({Key key}) : super(key: key);

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'My Restaurant',
          style: TextStyle(
              fontFamily: 'Varela', fontSize: 20.0, color: Color(0xFF545D68)),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          "Setting",
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: bold,
          ),
        ),
      ),
      child: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, child) {
        return ListView(
          children: [
            ListTile(
              title: const Text('Restaurant Alarm'),
              trailing: Consumer<SchedulingProvider>(
                builder: (context, scheduled, _) {
                  return Switch.adaptive(
                    value: provider.isDailyRestoActive,
                    onChanged: (value) async {
                      if (Platform.isIOS) {
                        customDialog(context);
                      } else {
                        scheduled.scheduledResto(value);
                        provider.enableDailyResto(value);
                      }
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
