import 'dart:math';

import 'package:flutter/material.dart';

import '../event_bus.dart';
import '../instruction_pannel.dart';

class LinkPage extends StatefulWidget {
  const LinkPage({Key? key}) : super(key: key);

  @override
  State<LinkPage> createState() => _LinkPageState();
}

class _LinkPageState extends State<LinkPage> {
  TextEditingController linkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var mode = Theme.of(context).brightness;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey[850]
            : Colors.grey[100],
        elevation: 0.0,
        shadowColor: Colors.transparent,
        toolbarHeight: 80.0,
        titleTextStyle: TextStyle(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey[100]
              : Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
        title: const Text('WORDLE'),
        centerTitle: true,
        //iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 750),
            reverseDuration: const Duration(milliseconds: 750),
            switchInCurve: Curves.bounceOut,
            switchOutCurve: Curves.bounceIn,
            transitionBuilder: (child, animation) {
              var rotateAnimation =
                  Tween<double>(begin: 0, end: 2 * pi).animate(animation);
              var opacAnimation =
                  Tween<double>(begin: 0, end: 1).animate(animation);
              return AnimatedBuilder(
                animation: rotateAnimation,
                builder: (context, child) {
                  return Transform(
                    transform: Matrix4.rotationZ(
                        rotateAnimation.status == AnimationStatus.reverse
                            ? 2 * pi - rotateAnimation.value
                            : rotateAnimation.value),
                    alignment: Alignment.center,
                    child: Opacity(
                      opacity: opacAnimation.value,
                      child: child,
                    ),
                  );
                },
                child: child,
              );
            },
            child: IconButton(
              key: ValueKey(mode),
              icon: mode == Brightness.light
                  ? const Icon(Icons.dark_mode_outlined)
                  : const Icon(Icons.dark_mode),
              onPressed: () => mainBus.emit(event: "ToggleTheme", args: []),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.help_outline_outlined),
            //color: Colors.black,
            onPressed: () {
              showInstructionDialog(context: context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(10.0),
              child: TextField(
                cursorColor: const Color.fromARGB(255, 207, 106, 140),
                controller: linkController,
                decoration: const InputDecoration(
                  hintText: 'Paste your Link here',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 206, 83, 124),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 207, 106, 140),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
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
                onTap: () {},
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Play',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.play_circle_rounded,
                        color: Colors.pink,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
