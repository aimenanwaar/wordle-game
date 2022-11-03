import 'package:flutter/material.dart';
import '../selection_group.dart';
import '../single_selection.dart';
import '../theme.dart';

class ChallengePage extends StatefulWidget {
  const ChallengePage({Key? key}) : super(key: key);

  @override
  State<ChallengePage> createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  TextEditingController wordController = TextEditingController();
  int wordLen = 5;
  int maxChances = 6;
  int dicBookIndex = 0;
  var dicBook = [
    ["All", "Full wordlist", "A", Colors.indigo],
    ["HighSchool", "HighSchool wordlist", "H", Colors.amber],
    ["CET4", "CET4 wordlist", "4", Colors.green[400]],
    ["CET6", "CET6 wordlist", "6", Colors.teal[400]],
    ["CET4 + 6", "CET4&6 wordlist", "46", Colors.teal[600]],
    ["TOEFL Slim", "TOEFL without CET4&6", "T", Colors.blue[400]],
    ["TOEFL", "Full TOEFL wordlist", "T", Colors.cyan[400]],
    ["GRE Slim", "GRE without CET4&6", "G", Colors.pink[200]]
  ];
  late final List<Widget> dicBookSelections;
  var wordLenSelectionColors = [
    Colors.green[300],
    Colors.green[500],
    Colors.teal[300],
    Colors.teal[500],
    Colors.pink[300]
  ];
  var chancesSelectionColors = [
    Colors.deepOrange[600],
    Colors.orange[400],
    Colors.cyan,
    Colors.blue[400],
    Colors.blue[600],
    Colors.teal[400],
    Colors.teal[600],
    Colors.green[700]
  ];

  @override
  void initState() {
    super.initState();
    dicBookSelections = [
      for (int i = 0; i < dicBook.length; i++)
        generateSelectionBox(
          id: i,
          width: 190,
          height: 240,
          padding: const EdgeInsets.fromLTRB(15.0, 25.0, 15.0, 0.0),
          color: dicBook[i][3]! as Color,
          primaryText: dicBook[i][0] as String,
          primaryTextSize: 20.0,
          secondaryText: dicBook[i][1] as String,
          secondaryTextSize: 14.0,
          decorationText: dicBook[i][2] as String,
          alignment: Alignment.topLeft,
        )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(context),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color: wordLenSelectionColors[wordLen - 4]!.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 10.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 10.0),
                      child: Text(
                        'Word Length',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: wordLenSelectionColors[wordLen - 4]!,
                        ),
                      ),
                    ),
                    SelectionGroupProvider(
                      defaultSelection: 5,
                      onChanged: (sel) => setState(() => wordLen = sel),
                      selections: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (int i = 4; i <= 8; i++)
                              generateSelectionBox(
                                id: i,
                                width: 80.0,
                                height: 80.0,
                                color: wordLenSelectionColors[i - 4]!,
                                primaryText: '$i',
                                primaryTextSize: 25.0,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 150.0,
                decoration: BoxDecoration(
                  color:
                      chancesSelectionColors[maxChances - 1]!.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 10.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 10.0),
                      child: Text(
                        'Max Attempts',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: chancesSelectionColors[maxChances - 1]!,
                        ),
                      ),
                    ),
                    SelectionGroupProvider(
                      defaultSelection: 6,
                      onChanged: (sel) => setState(() => maxChances = sel),
                      selections: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (int i = 1; i <= 8; i++)
                              generateSelectionBox(
                                id: i,
                                width: 80.0,
                                height: 80.0,
                                color: chancesSelectionColors[i - 1]!,
                                primaryText: '$i',
                                primaryTextSize: 25.0,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: (dicBook[dicBookIndex][3]! as Color).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 10.0, 0.0, 10.0),
                      child: Text(
                        'Word List',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: (dicBook[dicBookIndex][3]! as Color),
                        ),
                      ),
                    ),
                    SelectionGroupProvider(
                      defaultSelection: 0,
                      onChanged: (sel) => setState(() => dicBookIndex = sel),
                      selections: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: dicBookSelections,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Text(
                'OR',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10.0),
                child: TextField(
                  maxLength: wordLen,
                  cursorColor: const Color.fromARGB(255, 207, 106, 140),
                  controller: wordController,
                  decoration: const InputDecoration(
                    hintText: 'Write your own Word',
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
                    child: const Text(
                      'Generate Link',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
