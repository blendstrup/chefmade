import 'dart:ui' show Radius;

import 'package:flutter/material.dart' show EdgeInsets, BorderRadius, Divider;
import 'package:gap/gap.dart';

import 'widgets/cupertino/cup_divider.dart';

//TODO Replace SizedBoxes with gap from constants.dart
//TODO Replace EdgeInsets with paddings from constants.dart
//TODO Replace borderRadius with borderRadius from constants.dart
//TODO Replace dividers with dividers from constants.dart

// Spacers
Gap gap8 = const Gap(8);
Gap gap12 = const Gap(12);
Gap gap16 = const Gap(16);
Gap gap24 = const Gap(24);
Gap gap36 = const Gap(36);
Gap gap48 = const Gap(48);

// Paddings
EdgeInsets padding8 = const EdgeInsets.all(8);
EdgeInsets padding16 = const EdgeInsets.all(16);
EdgeInsets padding24 = const EdgeInsets.all(24);
EdgeInsets paddingH8 = const EdgeInsets.symmetric(horizontal: 8);
EdgeInsets paddingV8 = const EdgeInsets.symmetric(vertical: 8);
EdgeInsets paddingH16 = const EdgeInsets.symmetric(horizontal: 16);
EdgeInsets paddingV16 = const EdgeInsets.symmetric(vertical: 16);
EdgeInsets paddingH24 = const EdgeInsets.symmetric(horizontal: 24);
EdgeInsets paddingV24 = const EdgeInsets.symmetric(vertical: 24);

// Borders
BorderRadius circular4 = const BorderRadius.all(Radius.circular(4));
BorderRadius circular8 = const BorderRadius.all(Radius.circular(8));
BorderRadius circular12 = const BorderRadius.all(Radius.circular(12));
BorderRadius circular16 = const BorderRadius.all(Radius.circular(16));

// Widgets
Divider matDivider = const Divider(height: 2);
CupDivider cupShortDivider = const CupDivider.short();
CupDivider cupLongDivider = const CupDivider.long();
