import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/signin.dart';

bool _isSelected=true;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
      overlays: [SystemUiOverlay.top]).then(
    (_) => runApp(const ProTech()),
  );
}

class ProTech extends StatelessWidget {
  const ProTech({super.key}); 
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ProTech',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
      ),
      home:  const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration:const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/mainBackground.jpg"),
                alignment: Alignment.center,
                opacity: 0.8,
                fit: BoxFit.cover,
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors:[
                  Color.fromARGB(255, 7, 7, 7),
                  Color.fromARGB(255, 25, 26, 25),
                  Color.fromARGB(255, 65, 65, 65),
                  Color.fromARGB(255, 91, 92, 91),
                ],
              ),
            ),
          child: const signin(),
        ),
      ),
    );
  }
}
