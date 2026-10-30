import 'package:easymove/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppStyles {
  static const label = TextStyle(fontSize: 11, color: App_Colors.textLabel);

  static const input = TextStyle(fontSize: 11, color: App_Colors.textInput);

  static const role = TextStyle(fontSize: 11);

  static const appBarTitle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w700,
  );

  static const submit = TextStyle(fontSize: 14, fontWeight: FontWeight.w700);

  static const terms = TextStyle(fontSize: 11, color: App_Colors.textTerms);

  static const account = TextStyle(fontSize: 11, color: App_Colors.textAccount);

  static const dateOfBirth = TextStyle(
    fontSize: 11,
    color: App_Colors.textDateOfBirth,
  );

  static const link = TextStyle(
    fontSize: 11,
    color: App_Colors.PrimaryColor,
    decoration: TextDecoration.underline,
    fontWeight: FontWeight.w600,
  );

  static const verifiedTitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static const verifiedLink = TextStyle(
    fontSize: 14,
    color: App_Colors.PrimaryColor,
    decoration: TextDecoration.underline,
  );
}

class HomeStyles {
  static const sectionTitle = TextStyle(
    color: HomeColors.dark,
    fontSize: 12,
    fontWeight: FontWeight.w700,
  );
  static const sectionAction = TextStyle(
    color: HomeColors.red,
    fontSize: 8,
    fontWeight: FontWeight.w700,
  );
  static const cardTitle = TextStyle(
    color: HomeColors.dark,
    fontSize: 11,
    fontWeight: FontWeight.w600,
  );
  static const cardMeta = TextStyle(color: HomeColors.muted, fontSize: 8);
  static const cardPrice = TextStyle(
    color: HomeColors.dark,
    fontSize: 10,
    fontWeight: FontWeight.w700,
  );
  static const button = TextStyle(
    color: Colors.white,
    fontSize: 9,
    fontWeight: FontWeight.w700,
  );
  static const serviceLabel = TextStyle(
    color: HomeColors.dark,
    fontSize: 7,
    fontWeight: FontWeight.w600,
  );
}

class WidgetStyle {
  static const discount = TextStyle(
    color: HomeColors.red,
    fontSize: 8,
    fontWeight: FontWeight.w700,
  );
  static const bannerTitle = TextStyle(
    color: Colors.white,
    fontSize: 20,
    height: 0.96,
    fontWeight: FontWeight.w700,
  );
  static const searchHint = TextStyle(
    fontSize: 9,
    color: HomeColors.lightMuted,
  );
  static const category = TextStyle(fontSize: 12, fontWeight: FontWeight.w700);
  static const categoryItem = TextStyle(fontSize: 8, color: HomeColors.muted);
  static const country = TextStyle(fontSize: 8, color: HomeColors.dark);
  static const scheduleMove = TextStyle(
    color: HomeColors.primary,
    fontSize: 12,
    fontWeight: FontWeight.w700,
  );
}

class ProfileStyles {
  static const appBarTitle = TextStyle(
    color: ProfileColors.text,
    fontSize: 13,
    fontWeight: FontWeight.w600,
  );
  static const label = TextStyle(color: ProfileColors.label, fontSize: 9);
  static const input = TextStyle(color: ProfileColors.input, fontSize: 9);
  static const button = TextStyle(
    color: Colors.white,
    fontSize: 11,
    fontWeight: FontWeight.w700,
  );
}
