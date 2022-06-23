import 'dart:io' show Platform;

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemChrome, DeviceOrientation;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:overlay_support/overlay_support.dart';

import 'interface/colors.dart';
import 'interface/pages/cupertino/cup_app.dart';
import 'interface/pages/material/mat_app.dart';
import 'interface/widgets/common/error.dart';

//General: Add restorationScopeId to CupertinoApp and MaterialApp
//General: Switch pushNamed to restorablePushNamed
//General: Add restorationId to listViews
//General: Change ref.watch to ref.read in onTap and onPressed
//General: Make responsive for tablets, two column layout on info page

//Localization: Make localization folder with arb files for text in different languages
//Localization: Add localization delegates to CupertinoApp and MaterialApp (AppLocalizations.delegate, GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate)
//Localization: Add supported locales in CupertinoApp and MaterialApp
//Localization: Use text from localizations throughout app

//Material: Fix SliverAppBar title spacing (centering works, but it overlaps the backbutton if it's aligned to the left)
//Material: Dinings list page
//Material: Status filter popup menu
//Material: Dining info page
//Material: Update colorschemes with appropriate AppColors colors

//Cupertino&Material: Overview page with settings to change language and charts for the restaurants info (such as dining completed and denied)
//Cupertino&Material: Profile page with information about restaurant and a way to request changes (dialog?)

//Data: Update backend with proper security, so that data is attached to user accounts, and users may only read/write data appropriate for them
//Data: Update backend to allow realtime data fetching to allow for notifications regarding new requests and to update dinings list according to changes in db
//Data: Change all methods for fetching data in the repositories and services

//Note: Make Hive store bool for whether the app is being run for the first time, and in repository check for this and logout user if true to avoid preserverence of login state after uninstall
//Note: Without the calendar view it's not possible to block certain dates

//Inspiration for improvement: https://github.com/esDotDev/flutter_experiments/tree/master/skeleton_template_riverpod

void main() => runApp(const ProviderScope(child: Application()));

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return OverlaySupport.global(
      child: Container(
        color: AppColors.background,
        alignment: Alignment.center,
        child: FutureBuilder(
          future: Firebase.initializeApp(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Error(error: 'Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.done) {
              if (Platform.isIOS) return const ChefmadeCupApp();
              if (Platform.isAndroid) return const ChefmadeMatApp();
            }

            if (Platform.isIOS) return const CupertinoActivityIndicator();
            if (Platform.isAndroid) return const CircularProgressIndicator();
            return const Error(
              error: 'Oh no :(\nAre you on a supported platform?',
            );
          },
        ),
      ),
    );
  }
}
