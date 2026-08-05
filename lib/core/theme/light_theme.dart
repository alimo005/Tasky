import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,

  colorScheme: ColorScheme.light(
    primaryContainer: Color(0xFFFFFFFF),
    primary: Color(0xFFFFFFFF),
  ),

  scaffoldBackgroundColor: Color(0xffF6F7F9),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xffF6F7F9),
    titleTextStyle: TextStyle(
      color: Color(0xff161F1B),
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),
    iconTheme: IconThemeData(color: Color(0xff161F1B)),
    centerTitle: false,
  ),
  switchTheme: SwitchThemeData(
    trackColor: WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Color(0xff15B86C);
      }
      return Colors.transparent;
    }),

    thumbColor: WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Color(0xffFFFCFC);
      }
      return Color(0xff9E9E9E);
    }),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(Color(0xff15B86C)),
      foregroundColor: WidgetStateProperty.all(Color(0xFFFFFCFC)),
    ),
  ),

    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            textStyle: WidgetStateProperty.all(TextStyle(fontSize: 18)) ,
            foregroundColor: WidgetStateProperty.all(Colors.black)
        )
    ),


    checkboxTheme: CheckboxThemeData(
    side: BorderSide(color: Color(0xFFD1DAD6), width: 2),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
  ),

  textTheme: TextTheme(
    displayLarge: TextStyle(
      color: Color(0xFF161F1B),
      fontSize: 32,
      fontWeight: FontWeight.w400,
    ),
    displayMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      color: Color(0xFF161F1B),
    ),
    displaySmall: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Color(0xFF161F1B),
    ),
    labelMedium: TextStyle(
      fontSize: 16,
      color: Color(0xFF161F1B),
      fontWeight: FontWeight.w400,
    ),
    labelSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Color(0xFF3A4640),
    ),
    bodySmall: TextStyle(fontSize: 14, color: Color(0xFF6A6A6A)),
    titleMedium: TextStyle(
      fontSize: 20,
      color: Color(0xFF161F1B),
      fontWeight: FontWeight.w500,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(color: Color(0xff9E9E9E), fontWeight: FontWeight.w400),
    filled: true,
    fillColor: Color(0xFFD1DAD6),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xFFD1DAD6), width: 0.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.red, width: 1),
    ),
  ),

  iconTheme: IconThemeData(color: Color(0xFF161F1B)),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xff15B86C),
    foregroundColor: Color(0xffFFFCFC),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(30),
    ),
  ),
  dividerTheme: DividerThemeData(color: Color(0xFFCAC4D0), thickness: 1),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.black,
    selectionColor: Colors.grey,
    selectionHandleColor: Colors.black,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    backgroundColor: Color(0xFFF6F7F9),
    selectedItemColor: Color(0xFF14A662),
    unselectedItemColor: Color(0xFF3A4640),
    selectedLabelStyle: TextStyle(
      color: Color(0xFF14A662),
      fontWeight: FontWeight.w500,
    ),
    unselectedLabelStyle: TextStyle(color: Color(0xFF3A4640)),
  ),
  splashFactory: NoSplash.splashFactory,

    popupMenuTheme: PopupMenuThemeData(
        labelTextStyle :WidgetStateProperty.all(
            TextStyle(fontSize: 20 , fontWeight: FontWeight.w400 ,color: Colors.black)
        ),
        color: Color(0xffF6F7F9),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Color(0xff15B86C) , width: 2),
            borderRadius: BorderRadiusGeometry.circular(16)
        ),
        elevation: 10,
        shadowColor: Color(0xff15B86C)
    )
);
