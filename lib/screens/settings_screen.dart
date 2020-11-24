import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsScreen extends StatefulWidget {
  static String id = 'settings';
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool lockInBackground = true;
  bool notificationsEnabled = true;
  bool showFAQSwitchValue = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: 'Account',
            tiles: [
              SettingsTile(
                title: 'Phone number',
                leading: Icon(Icons.phone),
              ),
              SettingsTile(
                title: 'Email',
                leading: Icon(Icons.email),
              ),
              SettingsTile(
                title: 'Theme',
                leading: Icon(Icons.format_paint),
              ),
              SettingsTile.switchTile(
                title: "Show FAQs in home page",
                leading: Icon(Icons.help_center),
                onToggle: (bool value) {},
                switchValue: showFAQSwitchValue,
              ),
              SettingsTile(
                title: 'Sign out',
                leading: Icon(Icons.exit_to_app),
              ),
            ],
          ),
          SettingsSection(
            title: 'Security',
            tiles: [
              SettingsTile.switchTile(
                title: 'Change password',
                leading: Icon(Icons.lock),
                switchValue: true,
                onToggle: (bool value) {},
              ),
            ],
          ),
          SettingsSection(
            title: 'Misc',
            tiles: [
              SettingsTile(
                title: 'Terms of Service',
                leading: Icon(Icons.description),
              ),
              SettingsTile(
                title: 'Open source licenses',
                leading: Icon(Icons.collections_bookmark),
              ),
            ],
          )
        ],
      ),
    );
  }
}
