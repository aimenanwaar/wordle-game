import 'dart:math';

import 'package:flutter/material.dart';

import 'event_bus.dart';
import 'instruction_pannel.dart';

var brightness = Brightness.light;
void onThemeChange(dynamic args, setstate) {
  setstate(() {
    brightness =
        brightness == Brightness.light ? Brightness.dark : Brightness.light;
  });
}

onBus(setstate) {
  mainBus.onBus(
      event: "ToggleTheme",
      onEvent: (a) {
        onThemeChange(a, setstate);
      });
}

offBus(setstate) {
  mainBus.offBus(
      event: "ToggleTheme",
      callBack: (a) {
        onThemeChange(a, setstate);
      });
}

theme(context) {
  var mode = Theme.of(context).brightness;

  return Container(
    constraints: const BoxConstraints(minHeight: 100.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0, bottom: 10.0),
            child: Text('WORDLE',
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w300,
                    color: mode == Brightness.light
                        ? Colors.grey[850]!
                        : Colors.white)),
          ),
        ),
        const Spacer(),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
              padding: const EdgeInsets.only(right: 30.0, bottom: 10.0),
              child: Row(children: [
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
                    onPressed: () =>
                        mainBus.emit(event: "ToggleTheme", args: []),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.help_outline_outlined),
                  //color: Colors.black,
                  onPressed: () {
                    showInstructionDialog(context: context);
                  },
                ),
              ])),
        )
      ],
    ),
  );
}

appbar(context) {
  var mode = Theme.of(context).brightness;

  return AppBar(
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

    title: Text('WORDLE',
        style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.w300,
            color:
                mode == Brightness.light ? Colors.grey[850]! : Colors.white)),
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
  );
}
