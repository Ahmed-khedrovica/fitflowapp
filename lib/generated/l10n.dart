// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `FitFlow`
  String get appName {
    return Intl.message('FitFlow', name: 'appName', desc: '', args: []);
  }

  /// `Continue`
  String get continueButton {
    return Intl.message('Continue', name: 'continueButton', desc: '', args: []);
  }

  /// `Get Started`
  String get getStarted {
    return Intl.message('Get Started', name: 'getStarted', desc: '', args: []);
  }

  /// `Select Language`
  String get selectLanguage {
    return Intl.message(
      'Select Language',
      name: 'selectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `Arabic`
  String get arabic {
    return Intl.message('Arabic', name: 'arabic', desc: '', args: []);
  }

  /// `Welcome to FitFlow`
  String get welcomeTitle {
    return Intl.message(
      'Welcome to FitFlow',
      name: 'welcomeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Your personal fitness companion`
  String get welcomeSubtitle {
    return Intl.message(
      'Your personal fitness companion',
      name: 'welcomeSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Elevate Your Movement`
  String get splashTagline {
    return Intl.message(
      'Elevate Your Movement',
      name: 'splashTagline',
      desc: '',
      args: [],
    );
  }

  /// `Select Your Goal`
  String get selectYourGoal {
    return Intl.message(
      'Select Your Goal',
      name: 'selectYourGoal',
      desc: '',
      args: [],
    );
  }

  /// `Customize your journey for precision performance.`
  String get goalSubtitle {
    return Intl.message(
      'Customize your journey for precision performance.',
      name: 'goalSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Build Muscle`
  String get buildMuscle {
    return Intl.message(
      'Build Muscle',
      name: 'buildMuscle',
      desc: '',
      args: [],
    );
  }

  /// `Focus on hypertrophy and strength.`
  String get buildMuscleDesc {
    return Intl.message(
      'Focus on hypertrophy and strength.',
      name: 'buildMuscleDesc',
      desc: '',
      args: [],
    );
  }

  /// `Get Strong`
  String get getStrong {
    return Intl.message('Get Strong', name: 'getStrong', desc: '', args: []);
  }

  /// `Prioritize heavy lifting and power.`
  String get getStrongDesc {
    return Intl.message(
      'Prioritize heavy lifting and power.',
      name: 'getStrongDesc',
      desc: '',
      args: [],
    );
  }

  /// `General Fitness`
  String get generalFitness {
    return Intl.message(
      'General Fitness',
      name: 'generalFitness',
      desc: '',
      args: [],
    );
  }

  /// `Balanced health and mobility.`
  String get generalFitnessDesc {
    return Intl.message(
      'Balanced health and mobility.',
      name: 'generalFitnessDesc',
      desc: '',
      args: [],
    );
  }

  /// `Weekly Availability`
  String get weeklyAvailability {
    return Intl.message(
      'Weekly Availability',
      name: 'weeklyAvailability',
      desc: '',
      args: [],
    );
  }

  /// `2 Days`
  String get days2 {
    return Intl.message('2 Days', name: 'days2', desc: '', args: []);
  }

  /// `3 Days`
  String get days3 {
    return Intl.message('3 Days', name: 'days3', desc: '', args: []);
  }

  /// `4 Days`
  String get days4 {
    return Intl.message('4 Days', name: 'days4', desc: '', args: []);
  }

  /// `5+ Days`
  String get days5plus {
    return Intl.message('5+ Days', name: 'days5plus', desc: '', args: []);
  }

  /// `RECOMMENDED`
  String get recommended {
    return Intl.message('RECOMMENDED', name: 'recommended', desc: '', args: []);
  }

  /// `Optimal recovery cycle`
  String get optimalRecovery {
    return Intl.message(
      'Optimal recovery cycle',
      name: 'optimalRecovery',
      desc: '',
      args: [],
    );
  }

  /// `YOU CAN CHANGE THIS LATER IN PROFILE`
  String get changeInProfile {
    return Intl.message(
      'YOU CAN CHANGE THIS LATER IN PROFILE',
      name: 'changeInProfile',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
