import 'dart:ui';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';

const String url = "https://api.openweathermap.org/data/2.5/forecast?q=";
const String urlParams = "&appid=f802fd908c155491e99f266ff0d443e5&lang=ru&units=metric";
// TODO: - List of Cities
const double templateHeight = 640;
const double templateWidth = 360;

// Manrope

// Colors
bool themeLight = true;

const Map<String, Color> colorsLight = {
  "background" : Color(0xFFE2EBFF),
  "textBase" : Color(0xFF000000),
  "textSwitchNotSelected" : Color(0xFF000000),
  "switchNotSelectedBackground" : Color(0xFFE2EBFF),
  "textSwitchSelected" : Color(0xFFFFFFFF),
  "switchSelectedBackground" : Color(0xFF4B5F88),
  "section" : Color(0xFFE0E9FD),
  "text16" : Color(0xFF5A5A5A),
  "title10" : Color(0xFF828282),
  "text10" : Color(0xFF4A4A4A),
  "button" : Color(0xFF0256FF),
  "card1" : Color(0xFFCDDAF5),
  "card2" : Color(0xFF9CBCFF),
  "line" : Color(0xFF038CFE),
  "toWeekButtonText" : Color(0xFF038CFE),
  "removeFavouriteButton" : Color(0xFFC8DAFF),
  "mainText" : Color(0xFFFFFFFF),
  "textSecond" : Color(0xFF5A5A5A),
};
const Map<String, Color> colorsDark = {
  "background" : Color(0xFF0D172B),
  "textBase" : Color(0xFFFFFFFF),
  "textSwitchNotSelected" : Color(0xFF000000),
  "switchNotSelectedBackground" : Color(0xFFEEF4FF),
  "textSwitchSelected" : Color(0xFFFFFFFF),
  "switchSelectedBackground" : Color(0xFF0E182C),
  "section" : Color(0xFF0D182C),
  "text16" : Color(0xFFD2D2D2),
  "title10" : Color(0xFFAAAAAA),
  "text10" : Color(0xFFE3E3E3),
  "button" : Color(0xFF051340),
  "card1" : Color(0xFF223B70),
  "card2" : Color(0xFF0F1F40),
  "line" : Color(0xFFFFFFFF),
  "toWeekButtonText" : Color(0xFFFFFFFF),
  "removeFavouriteButton" : Color(0xFF152A53),
  "mainText" : Color(0xFFFFFFFF),
  "textSecond" : Color(0xFFB1B1B1),
};

// https://openweathermap.org/weather-conditions


String getIcon(number) {
  return "assets/" + number + ".png";
}