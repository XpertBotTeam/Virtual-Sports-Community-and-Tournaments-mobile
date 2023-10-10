import 'package:flutter/material.dart';
import 'package:lineupmaster/utils/colors.dart';
import 'package:lineupmaster/widgets/appbar/custom_appbar.dart';
import 'package:lineupmaster/widgets/section_title.dart';
import 'package:lineupmaster/widgets/settings_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: lightGray,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(MediaQuery.of(context).size.height / 12),
            child: const CustomAppBar("Settings"),
        ),
        body: const Column(
          children: [
            SizedBox(height: 20),
            SectionTitle("Help and Support"),
            SettingsButton(title: "FAQs" , image: "icons/question mark icon.svg"),
            SettingsButton(title: "Contact Support" , image: "icons/phone icon.svg"),
            SettingsButton(title: "Report a bug" , image: "icons/flag.svg"),
            SizedBox(height: 20),
            SectionTitle("Feedback"),
            SettingsButton(title: "Rate Application", image: "icons/star.svg"),
            SettingsButton(title: "Share Application", image: "icons/share.svg"),
            SizedBox(height: 20),
            SectionTitle("Social Media"),
            SettingsButton(title: "@lineupmaster", image: "icons/instagram icon.svg"),
            SettingsButton(title: "LineUpMaster", image: "icons/facebook icon.svg"),
        ]),
      ),
    );
  }
}