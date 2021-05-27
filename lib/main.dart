import 'package:flutter/material.dart';
import 'view/widgets/ps_button.dart';
import 'view/widgets/text_input.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  final TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // takes the dimensions of the device
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: TextInput(
              size: size,
              text: "E-mail",
              controller: textController,
            ),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Center(
            child: PsButton(
              size: size,
              func: () {},
              text: "Enviar",
            ),
          )
        ],
      ),
    );
  }
}
