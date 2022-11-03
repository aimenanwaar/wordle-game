import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:wordle_game/scroll_behav.dart';
import 'event_bus.dart';
import 'instruction_pannel.dart';
import 'main-options/page1.dart';
import 'main-options/page2.dart';
import 'main-options/page3.dart';
import 'dart:io';
import 'dart:math';
import 'theme.dart';

Future<void> loadSettings() async {
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String documentsPath = documentsDirectory.path + Platform.pathSeparator;
  File settings = File(documentsPath + "settings.txt");
  if (!(await settings.exists())) {
    var defaultSettings = "5\nCET4\nLight";
    settings.writeAsString(defaultSettings);
  }
  List<String> dicBooks = ["validation.txt", "CET4.txt"];
  for (String dicName in dicBooks) {
    if (!(await File(documentsPath + dicName).exists())) {
      //Copy file
      ByteData data = await rootBundle.load("assets/CET4.txt");
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(documentsPath + dicName).writeAsBytes(bytes, flush: true);
    }
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    //loadSettings();
    onBus(setState);
  }

  @override
  void dispose() {
    offBus(setState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyScrollBehavior(),
      title: 'Wordle',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        brightness: brightness,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Future<void> readSettings() async {
    return;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: readSettings(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            body: Align(
              alignment: Alignment.center,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 960.0),
                child: Column(
                  children: [
                    theme(context),
                    const Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: MainMenu(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Text('');
        }
      },
    );
  }
}

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    var mode = Theme.of(context).brightness;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DefaultTextStyle(
            style: TextStyle(
              color:
                  mode == Brightness.light ? Colors.grey[850]! : Colors.white,
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
            child: AnimatedTextKit(
              animatedTexts: [
                WavyAnimatedText(
                  "LET'S PLAY :)",
                  speed: const Duration(
                    milliseconds: 300,
                  ),
                ),
              ],
              isRepeatingAnimation: true,
              repeatForever: true,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.teal.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OfflinePage(),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 30.0),
                child: const Text(
                  'Play Random',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.pink.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LinkPage(),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 30.0),
                child: const Text(
                  'Play with Link',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink,
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: const EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChallengePage(),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 30.0),
                child: const Text(
                  'Challenge a Friend',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
