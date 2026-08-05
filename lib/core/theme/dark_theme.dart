import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,

  colorScheme: ColorScheme.dark(
    primaryContainer: Color(0xFF282828),
    primary: Color(0xFF282828),
  ),

  scaffoldBackgroundColor: Color(0xff181818),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xff181818),
    titleTextStyle: TextStyle(
      color: Color(0xffFFFCFC),
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),
    iconTheme: IconThemeData(color: Color(0xffFFFCFC)),
    centerTitle: false,
  ),

  checkboxTheme: CheckboxThemeData(
    side: BorderSide(color: Color(0xFF6E6E6E), width: 2),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
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
      foregroundColor: WidgetStateProperty.all(Colors.white)
    )
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      color: Color(0xffFFFCFC),
      fontSize: 32,
      fontWeight: FontWeight.w400,
    ),
    displayMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      color: Color(0xffFFFCFC),
    ),
    displaySmall: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Color(0xffFFFCFC),
    ),
    labelSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Color(0xFFC6C6C6),
    ),
    labelMedium: TextStyle(
      fontSize: 16,
      color: Color(0xFFFFFCFC),
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(fontSize: 14, color: Color(0xFFA0A0A0)),
    titleMedium: TextStyle(
      fontSize: 20,
      color: Color(0xffFFFCFC),
      fontWeight: FontWeight.w400,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(color: Color(0xff6D6D6D), fontWeight: FontWeight.w400),
    filled: true,
    fillColor: Color(0xff282828),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.red, width: 1),
    ),
  ),
  iconTheme: IconThemeData(color: Color(0xFFA0A0A0)),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xff15B86C),
    foregroundColor: Color(0xffFFFCFC),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(30),
    ),
  ),
  dividerTheme: DividerThemeData(
    color: Color(0xFFD1DAD6),
    thickness: 1,
  ),
    textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.white,
        selectionColor: Colors.grey,
        selectionHandleColor:Colors.white
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Color(0xff181818),
      selectedItemColor: Color(0xff15B86C),
      unselectedItemColor: Color(0xffC6C6C6),
    ),
  splashFactory: NoSplash.splashFactory,

  popupMenuTheme: PopupMenuThemeData(
      labelTextStyle :WidgetStateProperty.all(
        TextStyle(fontSize: 20 , fontWeight: FontWeight.w400 ,)
      ),
    color: Color(0xff181818),
    shape: RoundedRectangleBorder(
      side: BorderSide(color: Color(0xff15B86C) , width: 2),
      borderRadius: BorderRadiusGeometry.circular(16)
    ),
      elevation: 10,
    shadowColor: Color(0xff15B86C)
  )

);
