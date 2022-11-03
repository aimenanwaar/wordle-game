/*
 * @Author       : Linloir
 * @Date         : 2022-03-05 20:41:41
 * @LastEditTime : 2022-03-11 14:54:15
 * @Description  : Offline page
 */

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wordle_game/event_bus.dart';
import 'package:wordle_game/theme.dart';
import 'package:wordle_game/validation_provider.dart';
import 'package:wordle_game/display_pannel.dart';
import 'package:wordle_game/instruction_pannel.dart';
import 'package:wordle_game/popper_generator.dart';

class GamePage extends StatefulWidget {
  const GamePage({
    Key? key,
    required this.database,
    required this.wordLen,
    required this.maxChances,
    required this.gameMode,
  }) : super(key: key);

  final Map<String, List<String>> database;
  final int wordLen;
  final int maxChances;
  final int gameMode;

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with TickerProviderStateMixin {
  late AnimationController _controller;

  void _onGameEnd(dynamic args) {
    var result = args as bool;
    if (result == true) {
      _controller.forward().then((v) {
        _controller.reset();
        mainBus.emit(event: "Result", args: result);
      });
    } else {
      mainBus.emit(event: "Result", args: result);
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    mainBus.onBus(event: "ValidationEnds", onEvent: _onGameEnd);
  }

  @override
  void dispose() {
    mainBus.offBus(event: "ValidationEnds", callBack: _onGameEnd);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mode = Theme.of(context).brightness;
    return Stack(
      children: [
        Positioned.fill(
          child: Scaffold(
            appBar: appbar(context),
            body: Container(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey[850]
                  : Colors.white,
              child: ValidationProvider(
                database: widget.database,
                wordLen: widget.wordLen,
                maxChances: widget.maxChances,
                gameMode: widget.gameMode,
                child: WordleDisplayWidget(
                  wordLen: widget.wordLen,
                  maxChances: widget.maxChances,
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: PartyPopperGenerator(
            direction: PopDirection.fowardX,
            motionCurveX: FunctionCurve(func: (t) {
              return -t * t / 2 + t;
            }),
            motionCurveY: FunctionCurve(func: (t) {
              return 4 / 3 * t * t - t / 3;
            }),
            numbers: 50,
            posX: -60.0,
            posY: 30.0,
            pieceHeight: 15.0,
            pieceWidth: 30.0,
            controller: _controller,
          ),
        ),
        Positioned.fill(
          child: PartyPopperGenerator(
            direction: PopDirection.backwardX,
            motionCurveX: FunctionCurve(func: (t) {
              return -t * t / 2 + t;
            }),
            motionCurveY: FunctionCurve(func: (t) {
              return 4 / 3 * t * t - t / 3;
            }),
            numbers: 50,
            posX: -60.0,
            posY: 30.0,
            pieceHeight: 15.0,
            pieceWidth: 30.0,
            controller: _controller,
          ),
        ),
      ],
    );
  }
}
