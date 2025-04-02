import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final Color primaryColor = Color(0xFF70A9A1);
  static final Color secondaryColor = Color(0xFFDDB771);
  static final Color accentColor = Color(0xFFE07A5F);

  static final Color black = Color(0xFF000000);
  static final Color white = Color(0xFFffffff);
  static final Color gray = Color(0xFF888888);
  static ThemeData get lightTheme {
    return ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: white,
        iconTheme: IconThemeData(color: black),
        appBarTheme: AppBarTheme(
          color: white,
          foregroundColor: black,
          iconTheme: IconThemeData(color: black),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: GoogleFonts.poppins(
              color: black, fontSize: 16, fontWeight: FontWeight.w500),
        ),
        cardTheme: CardTheme(
          clipBehavior: Clip.hardEdge,
          elevation: 3,
          surfaceTintColor: Colors.transparent,
          color: white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.only(bottom: 16),
        ),
        colorScheme: ColorScheme.light(
          primary: primaryColor,
          secondary: secondaryColor,
          tertiary: accentColor,
          surface: Colors.white,
          error: const Color(0xFFF44336),
        ),
        datePickerTheme: DatePickerThemeData(
          elevation: 5,
          backgroundColor: white,
          dividerColor: white,
          headerBackgroundColor: white,
          surfaceTintColor: Colors.transparent,
          dayStyle: GoogleFonts.poppins(
              fontSize: 14, fontWeight: FontWeight.w400, color: black),
          yearStyle: GoogleFonts.poppins(fontWeight: FontWeight.normal),
          headerHeadlineStyle: GoogleFonts.poppins(color: gray, fontSize: 20),
          headerHelpStyle: GoogleFonts.poppins(color: black, fontSize: 16),
          todayBackgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return primaryColor;
            }
            return Colors.transparent;
          }),
          todayForegroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return Colors.grey;
            } else if (states.contains(WidgetState.selected)) {
              return white;
            }
            return black;
          }),
          todayBorder: BorderSide(color: primaryColor, width: 1),
          dayForegroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return Colors.grey;
            } else if (states.contains(WidgetState.selected)) {
              return white;
            }
            return black;
          }),
          dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return primaryColor;
            }
            return Colors.transparent;
          }),
          yearForegroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return Colors.grey;
            } else if (states.contains(WidgetState.selected)) {
              return white;
            }
            return black;
          }),
          yearBackgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return primaryColor;
            }
            return Colors.transparent;
          }),
          weekdayStyle: GoogleFonts.poppins(
            fontSize: 14, // Adjust size
          ),
          cancelButtonStyle: ButtonStyle(
            padding:
                WidgetStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
            foregroundColor: WidgetStateProperty.all<Color>(Colors.grey),
            textStyle: WidgetStateProperty.all<TextStyle>(
                GoogleFonts.poppins(color: Colors.grey, fontSize: 14)),
            minimumSize: WidgetStateProperty.all<Size>(const Size(0, 35)),
          ),
          confirmButtonStyle: ButtonStyle(
            foregroundColor: WidgetStateProperty.all<Color>(primaryColor),
            textStyle: WidgetStateProperty.all<TextStyle>(GoogleFonts.poppins(
                color: primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w600)),
            minimumSize: WidgetStateProperty.all<Size>(const Size(0, 35)),
          ),
        ),
        dialogTheme: DialogTheme(
          titleTextStyle: GoogleFonts.poppins(
              fontSize: 16, color: black, fontWeight: FontWeight.w600),
          contentTextStyle:
              GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
          barrierColor: gray.withValues(alpha: 0.75),
        ),
        drawerTheme: DrawerThemeData(
            surfaceTintColor: Colors.transparent,
            backgroundColor: white,
            elevation: 6),
        dropdownMenuTheme: DropdownMenuThemeData(
            menuStyle: MenuStyle(
                elevation: WidgetStateProperty.all<double>(3),
                surfaceTintColor:
                    WidgetStateProperty.all<Color>(Colors.transparent))),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            minimumSize: const Size(double.infinity, 40),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            animationDuration: const Duration(milliseconds: 100),
            elevation: 2,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            textStyle:
                GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: primaryColor,
          elevation: 6,
          foregroundColor: white,
        ),
        inputDecorationTheme: InputDecorationTheme(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          hintStyle: GoogleFonts.poppins(color: Colors.grey, fontSize: 14),
          errorStyle: GoogleFonts.poppins(color: Colors.red),
          contentPadding: const EdgeInsets.all(16),
          prefixIconColor: gray,
          suffixIconColor: gray,
          prefixStyle: GoogleFonts.poppins(color: primaryColor),
          suffixStyle: GoogleFonts.poppins(fontSize: 16),
          errorMaxLines: 2,
          border: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: gray),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: gray),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.5, color: primaryColor),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.5, color: primaryColor),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 1.5, color: Colors.redAccent),
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
        listTileTheme: ListTileThemeData(
            contentPadding: EdgeInsets.symmetric(vertical: 10)),
        progressIndicatorTheme: ProgressIndicatorThemeData(
            color: gray, circularTrackColor: primaryColor),
        snackBarTheme: SnackBarThemeData(
            contentTextStyle: GoogleFonts.poppins(
                color: white, fontWeight: FontWeight.w600, fontSize: 15),
            closeIconColor: white),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: primaryColor,
          selectionColor: primaryColor,
          selectionHandleColor: primaryColor,
        ),
        textTheme: TextTheme(
            labelLarge: GoogleFonts.poppins(
                color: primaryColor, fontSize: 35, fontWeight: FontWeight.w800),
            labelMedium: GoogleFonts.poppins(
                color: black, fontWeight: FontWeight.w500, fontSize: 15),
            labelSmall: GoogleFonts.poppins(color: gray, fontSize: 12),
            bodyLarge: GoogleFonts.poppins(
              color: white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            bodyMedium: GoogleFonts.poppins(
                color: black, fontSize: 16, fontWeight: FontWeight.w600),
            bodySmall: GoogleFonts.poppins(color: black, fontSize: 14),
            headlineMedium: GoogleFonts.poppins(
                fontSize: 18, color: gray, fontWeight: FontWeight.w600),
            headlineSmall: GoogleFonts.poppins(fontSize: 14, color: gray)),
        timePickerTheme: TimePickerThemeData(
          dialTextStyle: GoogleFonts.poppins(
              fontSize: 14, fontWeight: FontWeight.w400, color: black),
          cancelButtonStyle: ButtonStyle(
            padding:
                WidgetStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
            foregroundColor: WidgetStateProperty.all<Color>(Colors.grey),
            textStyle: WidgetStateProperty.all<TextStyle>(
                GoogleFonts.poppins(color: Colors.grey, fontSize: 14)),
            minimumSize: WidgetStateProperty.all<Size>(const Size(0, 35)),
          ),
          confirmButtonStyle: ButtonStyle(
            foregroundColor: WidgetStateProperty.all<Color>(primaryColor),
            textStyle: WidgetStateProperty.all<TextStyle>(GoogleFonts.poppins(
                color: primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w600)),
            minimumSize: WidgetStateProperty.all<Size>(const Size(0, 35)),
          ),
        ));
  }
}
