import 'package:flutter/material.dart';
import 'package:photoeditorapp/screens/main_page.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 170.0, left: 20, right: 20),
          child: Center(
            child: Column(children: [
              const Padding(
                padding: EdgeInsets.all(4.0),
                child: Text("Flutter Photo Editor App",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "Lucid",
                        fontSize: 30,
                        color: Colors.deepPurple)),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset("assets/images/logo.png"),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                    "This is an app to edit a photo of your choice with filter of my choice ;)",
                    style: TextStyle(
                        fontFamily: 'Familjen ',fontSize: 15, color: Colors.deepPurpleAccent)),
              ),
               Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>  const MainPage()),
                        );
                      },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white38,
                        shadowColor: Colors.black
                    ),
                    child: const Text('Lets Get Started',
                        style: TextStyle(
                            fontSize: 15, color: Colors.deepPurpleAccent)),
                  )
               ),
            ]),
          ),
        ),
      ),
    );
  }
}
