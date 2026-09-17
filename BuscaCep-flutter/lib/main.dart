import 'package:busca_cep/ui/home_screen.dart';
import 'package:busca_cep/utils/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    home: HomeScreen(),
    debugShowCheckedModeBanner: false,
    theme: AppTheme.lightTheme,
    darkTheme: AppTheme.darkTheme,
    themeMode: ThemeMode.system, //How the theme application is defined
  )); 
}
