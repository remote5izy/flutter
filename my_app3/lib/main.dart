import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yatzy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: YatzyPage(),
    );
  }
}

class YatzyPage extends StatefulWidget {
  @override
  _YatzyPageState createState() => _YatzyPageState();
}

class _YatzyPageState extends State<YatzyPage> {
  int totalScore=0; // Total score of the game
  bool gameOver = false; // Flag to indicate if the game is over
  List<int> dice = []; // List to store dice values
  List<bool> keep = [false, false, false, false, false]; // List to store whether each dice should be kept
  bool rolling = false; // Flag to indicate if dice are rolling
  int rollsLeft = 2; // Number of rolls left for the player
  int upperSectionBonusThreshold = 63; // Threshold for achieving upper section bonus
  bool upperSectionBonusAchieved = false; // Flag to indicate if upper section bonus is achieved
  Map<String, int> scores = { // Map to store scores for different categories
    'Ones': -1,
    'Twos': -1,
    'Threes': -1,
    'Fours': -1,
    'Fives': -1,
    'Sixes': -1,
    'One Pair': -1,
    'Two Pairs': -1,
    'Three of a Kind': -1,
    'Four of a Kind': -1,
    'Small Straight': -1,
    'Large Straight': -1,
    'Full House': -1,
    'Chance': -1,
    'Yatzy': -1,
  };

  @override
  void initState() {
    super.initState();
    resetDice();
  }

  void rollDice() {
    if (rollsLeft > 0) {
      setState(() {
        rolling = true;
        rollsLeft--;
        for (int i = 0; i < keep.length; i++) {
          if (!keep[i]) {
            dice[i] = Random().nextInt(6) + 1;
          }
        }
      });

      Future.delayed(const Duration(milliseconds: 1000), () {
        setState(() {
          rolling = false;
        });
      });
    }
  }

  void resetDice() {
    setState(() {
      dice = List.generate(5, (index) => Random().nextInt(6) + 1);
      keep = [false, false, false, false, false];
      rolling = false;
      rollsLeft = 2;
    });
  }

  int calculateScore(String category) {
    switch (category) {
      case 'Ones':
        return dice.where((element) => element == 1).length * 1;
      case 'Twos':
        return dice.where((element) => element == 2).length * 2;
      case 'Threes':
        return dice.where((element) => element == 3).length * 3;
      case 'Fours':
        return dice.where((element) => element == 4).length * 4;
      case 'Fives':
        return dice.where((element) => element == 5).length * 5;
      case 'Sixes':
        return dice.where((element) => element == 6).length * 6;
      case 'One Pair':
        for (int i = 6; i >= 1; i--) {
          if (dice.where((element) => element == i).length >= 2) {
            return i * 2;
          }
        }
        return 0;
      case 'Two Pairs':
        int pairCount = 0;
        int score = 0;
        for (int i = 6; i >= 1; i--) {
          if (dice.where((element) => element == i).length >= 2) {
            pairCount++;
            score += i * 2;
          }
        }
        return pairCount == 2 ? score : 0;
      case 'Three of a Kind':
        for (int i = 6; i >= 1; i--) {
          if (dice.where((element) => element == i).length >= 3) {
            return dice.reduce((value, element) => value + element);
          }
        }
        return 0;

      case 'Four of a Kind':
        for (int i = 6; i >= 1; i--) {
          if (dice.where((element) => element == i).length >= 4) {
            return dice.reduce((value, element) => value + element);
          }
        }
        return 0;

      case 'Small Straight':
        if (dice.toSet().length >= 4) {
          List<int> sortedDice = dice.toSet().toList()..sort();
          if ((sortedDice[0] == 1 &&
                  sortedDice[1] == 2 &&
                  sortedDice[2] == 3 &&
                  sortedDice[3] == 4) ||
              (sortedDice[0] == 2 &&
                  sortedDice[1] == 3 &&
                  sortedDice[2] == 4 &&
                  sortedDice[3] == 5) ||
              (sortedDice[0] == 3 &&
                  sortedDice[1] == 4 &&
                  sortedDice[2] == 5 &&
                  sortedDice[3] == 6)) {
            return 15;
          }
        }
        return 0;

      case 'Large Straight':
        if (dice.toSet().length == 5) {
          List<int> sortedDice = dice.toSet().toList()..sort();
          if ((sortedDice[0] == 1 &&
                  sortedDice[1] == 2 &&
                  sortedDice[2] == 3 &&
                  sortedDice[3] == 4 &&
                  sortedDice[4] == 5) ||
              (sortedDice[0] == 2 &&
                  sortedDice[1] == 3 &&
                  sortedDice[2] == 4 &&
                  sortedDice[3] == 5 &&
                  sortedDice[4] == 6)) {
            return 20;
          }
        }
        return 0;

      case 'Full House':
        // 首先对骰子列表进行排序
        List<int> sortedDice = [...dice];
        sortedDice.sort();

        // 如果有两个不同的值，且有三个相同的值或者有三个相同的值且另外两个值也相同，则为 Full House
        if ((sortedDice[0] == sortedDice[1] &&
                sortedDice[3] == sortedDice[4] &&
                (sortedDice[2] == sortedDice[0] ||
                    sortedDice[2] == sortedDice[4])) ||
            (sortedDice[0] == sortedDice[2] &&
                sortedDice[3] == sortedDice[4] &&
                sortedDice[2] != sortedDice[3])) {
          return 25; // 返回 Full House 的得分
        }
        return 0; // 如果不符合 Full House 的条件，则得分为 0

      case 'Chance':
        return dice.reduce((value, element) => value + element);

      case 'Yatzy':
        if (dice.toSet().length == 1) {
          return 50;
        }
        return 0;

      default:
        return 0;
    }
  }
  
  void selectScore(String category) {
    setState(() {
      scores[category] = calculateScore(category);

      // Check if the game is over and update total score
      if (!scores.containsValue(-1)) {
        gameOver = true;
        totalScore = scores.values.reduce((value, element) => value + element);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yatzy'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: rolling ? null : rollDice,
              child: Text(rolling ? 'Rolling...' : 'Roll Dice'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: rolling || rollsLeft == 2 ? null : resetDice,
              child: Text('Reset Dice'),
            ),
            SizedBox(height: 20),
            Text(
              'Dice:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                dice.length,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      keep[index] = !keep[index];
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(10),
                      color: keep[index] ? Colors.yellow : Colors.white,
                    ),
                    child: Text(
                      '${dice[index] != 0 ? dice[index] : ''}',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Rolls Left: $rollsLeft',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: scores.length,
                itemBuilder: (context, index) {
                  String label = scores.keys.elementAt(index);
                  int score = scores.values.elementAt(index);
                  return ListTile(
                    title: Text(
                      '$label: ${score != -1 ? score : 'Not selected'}',
                    ),
                    onTap: score == -1 ? () => selectScore(label) : null,
                  );
                },
              ),
            ),
            if (gameOver)
                Text(
                  'Total Score: $totalScore',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
          ],
        ),
      ),
    );
  }
}
