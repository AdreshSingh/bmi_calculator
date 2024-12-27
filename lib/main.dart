import 'package:bmi_calculator/pages/calender_page.dart';
import 'package:bmi_calculator/pages/home_page.dart';
import 'package:bmi_calculator/pages/qr_code_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  static const List<BottomNavigationBarItem> pagesIcon = [
    BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined),
        activeIcon: Icon(Icons.home),
        label: "Home"),
    BottomNavigationBarItem(
        icon: Icon(Icons.qr_code_2_outlined),
        activeIcon: Icon(Icons.qr_code_2),
        label: "QR"),
    BottomNavigationBarItem(
        icon: Icon(Icons.calendar_month_outlined),
        activeIcon: Icon(Icons.calendar_month),
        label: "Calendar")
  ];

  static const List<Widget> pages = [HomePage(), QrCodePage(), CalenderPage()];

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int current = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black)),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "BMI Calculator",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          shadowColor: Colors.grey[200],
          elevation: 2,
        ),
        body: MainApp.pages[current],
        bottomNavigationBar: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          clipBehavior: Clip.hardEdge,
          child: BottomNavigationBar(
            backgroundColor: Colors.pink[100],
            currentIndex: current,
            items: MainApp.pagesIcon,
            onTap: (value) {
              setState(() {
                current = value;
              });
            },
          ),
        ),
      ),
    );
  }
}
