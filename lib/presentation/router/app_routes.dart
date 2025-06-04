import 'package:flutter/material.dart';

enum AppPage { todo, finance }

extension AppPageExtension on AppPage {
  String get route => switch (this) {
    AppPage.todo => '/',
    AppPage.finance => '/finance',
  };

  String get label => switch (this) {
    AppPage.todo => 'To-do',
    AppPage.finance => 'Finance',
  };

  IconData get icon => switch (this) {
    AppPage.todo => Icons.check,
    AppPage.finance => Icons.account_balance_wallet,
  };
}
