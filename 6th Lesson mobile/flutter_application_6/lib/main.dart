import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (context) => ColorModel(), child: MyApp()),
  );
}

class ColorModel extends ChangeNotifier {
  bool _isSwitched = false;
  bool get isSwitched => _isSwitched;

  Color get currentColor => _isSwitched ? Colors.purple : Colors.teal;
  void toggleSwitch(bool value) {
    _isSwitched = value;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorModel = context.watch<ColorModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Homework Provider'),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(height: 200, width: 200, color: colorModel.currentColor),

            SizedBox(height: 20),

            Switch(
              value: colorModel.isSwitched,
              onChanged: (val) {
                context.read<ColorModel>().toggleSwitch(val);
              },
            ),
          ],
        ),
      ),
    );
  }
}
