import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:draggable_widget/draggable_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'AlertsHelper.dart';
import 'DataLibrary.dart';
import 'ImageLibrary.dart';
import 'package:badges/badges.dart' as cardCount;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: DataLibrary.AppName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.brown,
      ),
      home: const MyHomePage(title: DataLibrary.AppName),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  AudioCache audioCache = AudioCache();

  late BuildContext _context;

  //These two variable will help us locate the exact position of players thumb.
  double _thumbPositionDx = 0.00;
  double _thumbPositionDy = 0.00;

  //To use the low latency API, better for gaming sounds, use:
  AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);

  //keys
  GlobalKey key = GlobalKey();

  //Controllers
  final DragController? play_dragController = DragController();
  final DragController? market_dragController = DragController();

  //Design Rules
  final double cardHeigt = 150.0;
  final double cardWidth = 105.0;
  static const double cardBoderRadius = 4.0;
  bool _isCenterDeckGlowing = false;
  bool _isPlayAllowed = false;

  //Game Rules
  final int number_Of_Players = 2;
  final bool use_Whot20 = true;
  //Number of cards shared for each player before game starts
  final int number_Of_Shared_Cards = 4;
  bool myTurn = true;
  String cpu_difficulty = "easy";

  bool movable_PlayerCard_Visibility = false;
  String movable_PlayerCard_Image = "";
  String movable_PlayerCard_Shape = "";
  int movable_PlayerCard_Number = 0;
  int movable_PlayerCard_Index = 100;

  //Offsets
  Offset playCard_widgetPosition = Offset.zero;
  Offset marketCard_widgetPosition = Offset.zero;

  final List<Map> Default_Whot_Stack = [
    {
      "index": 0,
      "number": 1,
      "shape": "circle",
      "image": "assets/images/Circle1.png"
    },
    {
      "index": 1,
      "number": 2,
      "shape": "circle",
      "image": "assets/images/Circle2.png"
    },
    {
      "index": 2,
      "number": 3,
      "shape": "circle",
      "image": "assets/images/Circle3.png"
    },
    {
      "index": 3,
      "number": 4,
      "shape": "circle",
      "image": "assets/images/Circle4.png"
    },
    {
      "index": 4,
      "number": 5,
      "shape": "circle",
      "image": "assets/images/Circle5.png"
    },
    {
      "index": 5,
      "number": 7,
      "shape": "circle",
      "image": "assets/images/Circle7.png"
    },
    {
      "index": 6,
      "number": 8,
      "shape": "circle",
      "image": "assets/images/Circle8.png"
    },
    {
      "index": 7,
      "number": 10,
      "shape": "circle",
      "image": "assets/images/Circle10.png"
    },
    {
      "index": 8,
      "number": 11,
      "shape": "circle",
      "image": "assets/images/Circle11.png"
    },
    {
      "index": 9,
      "number": 12,
      "shape": "circle",
      "image": "assets/images/Circle12.png"
    },
    {
      "index": 10,
      "number": 13,
      "shape": "circle",
      "image": "assets/images/Circle13.png"
    },
    {
      "index": 11,
      "number": 14,
      "shape": "circle",
      "image": "assets/images/Circle14.png"
    },
    {
      "index": 12,
      "number": 1,
      "shape": "triangle",
      "image": "assets/images/Triangle1.png"
    },
    {
      "index": 13,
      "number": 2,
      "shape": "triangle",
      "image": "assets/images/Triangle2.png"
    },
    {
      "index": 14,
      "number": 3,
      "shape": "triangle",
      "image": "assets/images/Triangle3.png"
    },
    {
      "index": 15,
      "number": 4,
      "shape": "triangle",
      "image": "assets/images/Triangle4.png"
    },
    {
      "index": 16,
      "number": 5,
      "shape": "triangle",
      "image": "assets/images/Triangle5.png"
    },
    {
      "index": 17,
      "number": 7,
      "shape": "triangle",
      "image": "assets/images/Triangle7.png"
    },
    {
      "index": 18,
      "number": 8,
      "shape": "triangle",
      "image": "assets/images/Triangle8.png"
    },
    {
      "index": 19,
      "number": 10,
      "shape": "triangle",
      "image": "assets/images/Triangle10.png"
    },
    {
      "index": 20,
      "number": 11,
      "shape": "triangle",
      "image": "assets/images/Triangle11.png"
    },
    {
      "index": 21,
      "number": 12,
      "shape": "triangle",
      "image": "assets/images/Triangle12.png"
    },
    {
      "index": 22,
      "number": 13,
      "shape": "triangle",
      "image": "assets/images/Triangle13.png"
    },
    {
      "index": 23,
      "number": 14,
      "shape": "triangle",
      "image": "assets/images/Triangle14.png"
    },
    {
      "index": 24,
      "number": 1,
      "shape": "plus",
      "image": "assets/images/Plus1.png"
    },
    {
      "index": 25,
      "number": 2,
      "shape": "plus",
      "image": "assets/images/Plus2.png"
    },
    {
      "index": 26,
      "number": 3,
      "shape": "plus",
      "image": "assets/images/Plus3.png"
    },
    {
      "index": 27,
      "number": 5,
      "shape": "plus",
      "image": "assets/images/Plus5.png"
    },
    {
      "index": 28,
      "number": 7,
      "shape": "plus",
      "image": "assets/images/Plus7.png"
    },
    {
      "index": 29,
      "number": 10,
      "shape": "plus",
      "image": "assets/images/Plus10.png"
    },
    {
      "index": 30,
      "number": 11,
      "shape": "plus",
      "image": "assets/images/Plus11.png"
    },
    {
      "index": 31,
      "number": 13,
      "shape": "plus",
      "image": "assets/images/Plus13.png"
    },
    {
      "index": 32,
      "number": 14,
      "shape": "plus",
      "image": "assets/images/Plus14.png"
    },
    {
      "index": 33,
      "number": 1,
      "shape": "square",
      "image": "assets/images/Square1.png"
    },
    {
      "index": 34,
      "number": 2,
      "shape": "square",
      "image": "assets/images/Square2.png"
    },
    {
      "index": 35,
      "number": 3,
      "shape": "square",
      "image": "assets/images/Square3.png"
    },
    {
      "index": 36,
      "number": 5,
      "shape": "square",
      "image": "assets/images/Square5.png"
    },
    {
      "index": 37,
      "number": 7,
      "shape": "square",
      "image": "assets/images/Square7.png"
    },
    {
      "index": 38,
      "number": 10,
      "shape": "square",
      "image": "assets/images/Square10.png"
    },
    {
      "index": 39,
      "number": 11,
      "shape": "square",
      "image": "assets/images/Square11.png"
    },
    {
      "index": 40,
      "number": 13,
      "shape": "square",
      "image": "assets/images/Square13.png"
    },
    {
      "index": 41,
      "number": 14,
      "shape": "square",
      "image": "assets/images/Square14.png"
    },
    {
      "index": 42,
      "number": 1,
      "shape": "star",
      "image": "assets/images/Star1.png"
    },
    {
      "index": 43,
      "number": 2,
      "shape": "star",
      "image": "assets/images/Star2.png"
    },
    {
      "index": 44,
      "number": 3,
      "shape": "star",
      "image": "assets/images/Star3.png"
    },
    {
      "index": 45,
      "number": 4,
      "shape": "star",
      "image": "assets/images/Star4.png"
    },
    {
      "index": 46,
      "number": 5,
      "shape": "star",
      "image": "assets/images/Star5.png"
    },
    {
      "index": 47,
      "number": 7,
      "shape": "star",
      "image": "assets/images/Star7.png"
    },
    {
      "index": 48,
      "number": 8,
      "shape": "star",
      "image": "assets/images/Star8.png"
    },
    /*{
      "index": 49,
      "number": 20,
      "shape": "whot",
      "image": "assets/images/Whot20.png"
    },
    {
      "index": 50,
      "number": 20,
      "shape": "whot",
      "image": "assets/images/Whot20.png"
    },
    {
      "index": 51,
      "number": 20,
      "shape": "whot",
      "image": "assets/images/Whot20.png"
    },
    {
      "index": 52,
      "number": 20,
      "shape": "whot",
      "image": "assets/images/Whot20.png"
    },
    {
      "index": 53,
      "number": 20,
      "shape": "whot",
      "image": "assets/images/Whot20.png"
    },*/
  ];

  List<Map> Shuffled_Whot_Stack = [];

  List<Map> Market_Whot_Stack = [];

  List<Map> CPU_Whot_Stack = [];

  List<Map> Player1_Whot_Stack = [];

  List<Map> Center_Game_Whot_Stack = [];

  //The draggable card whot stack can only have one card at a time.
  List<Map> Draggable_Card_Whot_Stack = [];

  //This function will share the cards once at the beginning of each game.
  _shareCards() {
    //Step 1. Shuffle Our Cards
    Shuffled_Whot_Stack = List.from(Default_Whot_Stack);
    Shuffled_Whot_Stack.shuffle(Random());

    //Step 2. Share Cards For CPU and Player
    for (int i = 0; i < number_Of_Shared_Cards * 2; i++) {
      //Step3. Check if i is an even or odd number
      //If i is an odd number share card for CPU then add 1 to i
      //After adding card for CPU_Whot_Stack, remove card from Shuffled_Whot_Stack
      //If i is an even number share card for Player 1 then add 1 to i
      //After adding card for Player1_Whot_Stack, remove card from Shuffled_Whot_Stack
      if (i % 2 == 0) {
        CPU_Whot_Stack.add(Shuffled_Whot_Stack[0]);
      } else {
        Player1_Whot_Stack.add(Shuffled_Whot_Stack[0]);
      }
      Shuffled_Whot_Stack.removeAt(0);
    }
    //For loop ends here

    //Step 4. Place center card(or center game card)
    Center_Game_Whot_Stack.add(Shuffled_Whot_Stack[0]);
    Shuffled_Whot_Stack.removeAt(0);

    //Step 5. Add Remaining cards in Shuffled_Whot_Stack to Market_Whot_Stack
    Market_Whot_Stack = List.from(Shuffled_Whot_Stack);
  }

  //This function will add cards to Player1_Whot_Stack or CPU_Whot_Stack
  //whenever they visit the market.
  //This function will receive the players name as a String variable
  //before adding card to the desired player's deck of cards.
  _gotoMarket(String playerName) {
    //Step 1. Check if the number of cards in the Market_Whot_Stack is equal to 1
    //and if the number of cards in the Center_Game_Whot_Stack is equal to 1
    //and if the card in both the Market_Whot_Stack and Center_Game_Whot_Stack is the same card
    //if they are not the same continue, else call the _endGame() function.
    //This comparisons will be handled by the _didMarketCrash() function, which returns a boolean value.
    //If market crashed, jump to Step 6.
    if (!_didMarketCrash()) {
      //Step 2. Check which player is visiting the market
      switch (playerName) {
        //Step 3.a Give card to CPU if player name is CPU, else ignore.
        case "CPU":
          CPU_Whot_Stack.add(Market_Whot_Stack[0]);
          Market_Whot_Stack.removeAt(0);
          break;

        //Step 3.b Give card to Player 1 if player name matches case, else ignore.
        case "Player 1":
          Player1_Whot_Stack.add(Market_Whot_Stack[0]);
          Market_Whot_Stack.removeAt(0);
          break;
      }

      //Step 4. Check if Market_Whot_Stack is less than 1 or empty, else ignore.
      //If Market_Whot_Stack is empty, repopulate it with Center_Game_Whot_Stack
      //then remove all cards in Center_Game_Whot_Stack except the last added card.
      if (Market_Whot_Stack.length < 1) {
        //Step 5. Check if Center_Game_Whot_Stack is less than 2 cards.
        //If Center_Game_Whot_Stack is less than 2, add the remaining card to
        //Market_Whot_Stack without emptying Center_Game_Whot_Stack
        Market_Whot_Stack = List.from(Center_Game_Whot_Stack);

        if (Center_Game_Whot_Stack.length > 1) {
          Center_Game_Whot_Stack = [];
          Center_Game_Whot_Stack.add(
              Market_Whot_Stack[Market_Whot_Stack.length - 1]);
        }
      }
    } else {
      //Step 6.
      _endGame();
    }
  }

  //This function calculates the total sum of number in keys
  int calculateTotalSum(List<Map> stack) {
    return stack.fold(0, (sum, card) => sum + (card['number'] as int));
  }

  _endGame() {
    // Call the function with your CPU_Whot_Stack list

    int totalSumCPU = calculateTotalSum(CPU_Whot_Stack);
    int totalSumPlayer = calculateTotalSum(CPU_Whot_Stack);

    if (CPU_Whot_Stack.isEmpty) {
      AlertHelper.alertDialog(_context, 330, "So Sorry", "You lost to CPU.");
    } else if (Player1_Whot_Stack.isEmpty) {
      AlertHelper.alertDialog(
          _context, 330, "Congratulations", "You have won the game.");
    } else if (totalSumCPU < totalSumPlayer) {
      AlertHelper.alertDialog(_context, 330, "So Sorry", "You lost to CPU.");
    } else {
      AlertHelper.alertDialog(
          _context, 330, "Congratulations", "You have won the game.");
    }
  }

  bool _didMarketCrash() {
    return false;
  }

  bool _canPlayGo(String shape, int number) {
    if (Center_Game_Whot_Stack[Center_Game_Whot_Stack.length - 1]["number"] ==
        1) {
      return true;
    } else {
      if (number == 20) {
        return true;
      } else {
        if (Center_Game_Whot_Stack[Center_Game_Whot_Stack.length - 1]
                    ["shape"] ==
                shape ||
            Center_Game_Whot_Stack[Center_Game_Whot_Stack.length - 1]
                    ["number"] ==
                number) {
          return true;
        } else {
          return false;
        }
      }
    }
  }

  // Function to calculate the score for a given play
  int _calculatePlayScore(List<Map> play) {
    // You can define your own scoring logic here, e.g., based on the number of cards played
    return play.length;
  }

  // Function to get all possible plays for the CPU
  List<List<Map>> _getPossiblePlaysForCPU() {
    List<List<Map>> possiblePlays = [];
    List<Map> cpuCards = CPU_Whot_Stack;

    // Check if the CPU can play any card
    if (cpuCards.isNotEmpty) {
      for (Map card in cpuCards) {
        if (_canPlayGo(card['shape'], card['number'])) {
          // If the CPU can play the card, add it to the possible plays
          possiblePlays.add([card]);
        }
      }

      // Check if the CPU can play a 1 card with any shape or number
      for (Map card in cpuCards) {
        if (card['number'] == 1) {
          possiblePlays.add([card]);
        }
      }
    }

    return possiblePlays;
  }

  // Function to let the CPU play against the human
  void _cpuPlay() {
    final Random random = Random();

    while (!myTurn) {
      List<List<Map>> possiblePlays = _getPossiblePlaysForCPU();

      if (possiblePlays.isNotEmpty) {
        // Calculate the score for each possible play
        List<int> scores =
            possiblePlays.map((play) => _calculatePlayScore(play)).toList();

        // Find the play with the highest score
        int maxScore = scores.reduce(max);
        List<List<Map>> bestPlays = possiblePlays
            .where((play) => _calculatePlayScore(play) == maxScore)
            .toList();

        // If multiple plays have the same highest score, randomly choose one
        List<Map> selectedPlay = bestPlays[random.nextInt(bestPlays.length)];

        // Play the selected cards and remove them from CPU_Whot_Stack
        CPU_Whot_Stack.removeWhere((card) => selectedPlay.contains(card));
        Center_Game_Whot_Stack.addAll(selectedPlay);

        // Check if the CPU won the game
        if (CPU_Whot_Stack.isEmpty) {
          _endGame();
          return;
        }

        // Check if the play has a special card (e.g., 1 Card, 2 Card, 8 Card, 14 Card, and 20 Card.)
        Map lastPlayedCard = selectedPlay.last;
        if (lastPlayedCard['number'] == 1) {
          //Do nothing
        } else if (lastPlayedCard['number'] == 2) {
          //next player picks two cards
          _gotoMarket("Player 1");
          _gotoMarket("Player 1");
        } else if (lastPlayedCard['number'] == 8) {
          //Do nothing
        } else if (lastPlayedCard['number'] == 14) {
          // all players pick one card except this player
          _gotoMarket("Player 1");
        } else {
          myTurn = true;
        }

      } else {
        // If the CPU cannot play any card, it goes to the market
        _gotoMarket("CPU");
        myTurn = true;
      }

      Future.delayed(const Duration(seconds: 1), () {
        _toggleGlow(false);
      });

      setState(() {});
    }
  }

  void _playerPlay(String shape, int number, int index) {
    if (myTurn == true) {
      if (_canPlayGo(shape, number)) {
        if (number != 1 &&
            number != 2 &&
            number != 8 &&
            number != 14 &&
            number != 20) {
          myTurn = false;
        }

        Center_Game_Whot_Stack.add(Player1_Whot_Stack[index]);
        Player1_Whot_Stack.removeAt(index);

        switch (number) {
          case 2:
            _gotoMarket("CPU");
            _gotoMarket("CPU");
            break;

          case 14:
            _gotoMarket("CPU");
            break;

          case 20:
            //Nothing for this demo
            break;
        }

        _isPlayAllowed = true;
        _toggleGlow(true);
        Future.delayed(const Duration(seconds: 1), () {
          _toggleGlow(false);
          if (Player1_Whot_Stack.isEmpty) {
            _endGame();
          } else {
            if (!myTurn) {
              _cpuPlay();
            }
          }
        });
      } else {
        _isPlayAllowed = false;
        _toggleGlow(true);
        Future.delayed(const Duration(seconds: 1), () {
          _toggleGlow(false);
        });
      }
    }
  }

  //This function will cause containers border to glow.
  void _toggleGlow(bool onOff) {
    setState(() {
      _isCenterDeckGlowing = onOff;
    });
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      // Device unlocked, perform your action here
      //await audioPlayer.resume();
      audioCache.loop('audio/background_music.mp3');
    } else if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached ||
        state == AppLifecycleState.paused) {
      // Device locked, perform your action here
      //await audioPlayer.pause();
      audioCache.loop('audio/background_music.mp3', volume: 0);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    //_playBackgroundMusic();
    //audioCache.loop('audio/background_music.mp3', volume: 0.1);
    _shareCards();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    double deviceScreenWidth = MediaQuery.of(context).size.width;
    double deviceScreenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title), // The title of the AppBar
        actions: [
          /*IconButton(
            icon: const Icon(Icons.redo),
            onPressed: () {
              //Redo Action

            },
          ),
          IconButton(
            icon: const Icon(Icons.undo),
            onPressed: () {
              //Undo Action

            },
          ),*/
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              //Pop up tutorial dialog box
              AlertHelper.infoDialog(context, deviceScreenWidth);
            },
          ),
        ],
      ),
      body: Container(
        height: deviceScreenHeight - 80,
        width: deviceScreenWidth,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
            image: AssetImage(ImageLibrary.WoodenSurface),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: <Widget>[
//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
            //CPU Cards
            cardCount.Badge(
              badgeContent: Text(
                'CPU Cards: ${CPU_Whot_Stack.length}',
                style: const TextStyle(color: Colors.white),
              ),
              position: cardCount.BadgePosition.topEnd(
                  top: cardHeigt - 15, end: deviceScreenWidth - 130),
              badgeStyle: cardCount.BadgeStyle(
                shape: cardCount.BadgeShape.square,
                badgeColor: Colors.brown,
                padding: const EdgeInsets.all(5),
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.white, width: 1),
                elevation: 0,
              ),
              child: SizedBox(
                height: cardHeigt,
                width: deviceScreenWidth,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: CPU_Whot_Stack.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final item = CPU_Whot_Stack[index];
                    final double widthFactor = index == 0
                        ? 1
                        : CPU_Whot_Stack.length == 4
                            ? 0.62
                            : ((4 / CPU_Whot_Stack.length) * 0.62);
                    return Align(
                      alignment: Alignment.center,
                      widthFactor: widthFactor,
                      child: Container(
                        height: cardHeigt,
                        width: cardWidth,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/images/CardBack.png"),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  spreadRadius: 3,
                                  blurRadius: 3,
                                  offset: Offset(2, 1)),
                            ],
                            borderRadius: BorderRadius.all(
                                Radius.circular(cardBoderRadius))),
                      ),
                    );
                  },
                ),
              ),
            ),
//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
            //Center Game Stack
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerRight,
                child: cardCount.Badge(
                  badgeContent: Text(
                    'Center Game: ${Center_Game_Whot_Stack.length}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  position: cardCount.BadgePosition.topEnd(
                      top: cardHeigt - 5, end: deviceScreenWidth - 360),
                  badgeStyle: cardCount.BadgeStyle(
                    shape: cardCount.BadgeShape.square,
                    badgeColor: Colors.brown,
                    padding: const EdgeInsets.all(5),
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: Colors.white, width: 1),
                    elevation: 0,
                  ),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    height: cardHeigt,
                    width: cardWidth,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(Center_Game_Whot_Stack[
                              Center_Game_Whot_Stack.length - 1]["image"]),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: _isCenterDeckGlowing
                            ? [
                                BoxShadow(
                                  color:
                                      _isPlayAllowed ? Colors.blue : Colors.red,
                                  blurRadius: 30.0,
                                  spreadRadius: 15.0,
                                ),
                              ]
                            : [],
                        borderRadius: const BorderRadius.all(
                            Radius.circular(cardBoderRadius))),
                  ),
                ),
              ),
            ),
            //Players Card Stack
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: cardHeigt,
                  width: deviceScreenWidth + 33,
                  child: ListView.builder(
                    itemCount: Player1_Whot_Stack.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final item = Player1_Whot_Stack[index];
                      final double widthFactor = index == 0
                          ? 1
                          : Player1_Whot_Stack.length == 4
                              ? 0.62
                              : ((4 / Player1_Whot_Stack.length) * 0.62);
                      return Align(
                        alignment: Alignment.center,
                        widthFactor: widthFactor,
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onVerticalDragStart: (val) {
                            setState(() {
                              playCard_widgetPosition = Offset.zero;
                              play_dragController
                                  ?.jumpTo(AnchoringPosition.center);
                              movable_PlayerCard_Visibility = true;
                              movable_PlayerCard_Image = item["image"];
                              movable_PlayerCard_Shape = item["shape"];
                              movable_PlayerCard_Index = index;
                              movable_PlayerCard_Number = item["number"];

                              if (Draggable_Card_Whot_Stack.length > 0) {
                                for (int i = 0; i < 4; i++) {
                                  switch (i) {
                                    case 0:
                                      Draggable_Card_Whot_Stack.add(
                                          Player1_Whot_Stack[index]);
                                      break;
                                    case 1:
                                      Player1_Whot_Stack.removeAt(index);
                                      break;
                                    case 2:
                                      Player1_Whot_Stack.add(
                                          Draggable_Card_Whot_Stack[0]);
                                      break;
                                    case 3:
                                      Draggable_Card_Whot_Stack.removeAt(0);
                                      break;
                                  }
                                }
                              } else {
                                Draggable_Card_Whot_Stack.add(
                                    Player1_Whot_Stack[index]);
                                Player1_Whot_Stack.removeAt(index);
                              }
                            });
                          },
                          onHorizontalDragStart: (val) {
                            setState(() {
                              if (movable_PlayerCard_Visibility) {
                                play_dragController
                                    ?.jumpTo(AnchoringPosition.center);
                                movable_PlayerCard_Visibility = false;
                                movable_PlayerCard_Image = "";
                                movable_PlayerCard_Shape = "";
                                movable_PlayerCard_Number = 0;
                                movable_PlayerCard_Index = 100;
                                Player1_Whot_Stack.add(
                                    Draggable_Card_Whot_Stack[0]);
                                Draggable_Card_Whot_Stack.removeAt(0);
                                _isCenterDeckGlowing = false;
                                _toggleGlow(false);
                              }
                            });
                          },
                          onTap: () {
                            setState(() {
                              if (movable_PlayerCard_Visibility) {
                                play_dragController
                                    ?.jumpTo(AnchoringPosition.center);
                                movable_PlayerCard_Visibility = false;
                                movable_PlayerCard_Image = "";
                                movable_PlayerCard_Shape = "";
                                movable_PlayerCard_Number = 0;
                                movable_PlayerCard_Index = 100;
                                Player1_Whot_Stack.add(
                                    Draggable_Card_Whot_Stack[0]);
                                Draggable_Card_Whot_Stack.removeAt(0);
                                _isCenterDeckGlowing = false;
                                _toggleGlow(false);
                              }
                            });
                          },
                          onDoubleTap: () {
                            setState(() {
                              _playerPlay(item["shape"], item["number"], index);
                            });
                          },
                          child: Container(
                            height: cardHeigt,
                            width: cardWidth,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(item["image"]),
                                  fit: BoxFit.cover,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.grey,
                                      spreadRadius: 3,
                                      blurRadius: 3,
                                      offset: Offset(2, 1)),
                                ],
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(cardBoderRadius))),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
            //Market Card (Not Draggable)
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerLeft,
                child: cardCount.Badge(
                  badgeContent: Text(
                    'Market: ${Market_Whot_Stack.length}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  position: cardCount.BadgePosition.topEnd(
                      top: cardHeigt - 5, end: 30),
                  badgeStyle: cardCount.BadgeStyle(
                    shape: cardCount.BadgeShape.square,
                    badgeColor: Colors.brown,
                    padding: const EdgeInsets.all(5),
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: Colors.white, width: 1),
                    elevation: 0,
                  ),
                  child: GestureDetector(
                    onVerticalDragDown: (val) {
                      Future.delayed(const Duration(seconds: 1), () {
                        _gotoMarket("Player 1");
                      }).then((value) {
                        setState(() {
                          if (movable_PlayerCard_Visibility) {
                            play_dragController
                                ?.jumpTo(AnchoringPosition.center);
                            movable_PlayerCard_Visibility = false;
                            movable_PlayerCard_Image = "";
                            movable_PlayerCard_Shape = "";
                            movable_PlayerCard_Number = 0;
                            Player1_Whot_Stack.add(
                                Draggable_Card_Whot_Stack[0]);
                            Draggable_Card_Whot_Stack.removeAt(0);
                            _isCenterDeckGlowing = false;
                          }
                          myTurn = false;
                        });
                        _cpuPlay();
                      });
                    },
                    child: Container(
                      height: cardHeigt,
                      width: cardWidth,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(ImageLibrary.CardBack),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(
                              Radius.circular(cardBoderRadius))),
                    ),
                  ),
                ),
              ),
            ),
            //Market Card (Draggable)
            /*DraggableWidget(
              bottomMargin: 80,
              topMargin: deviceScreenHeight * 0.33,
              intialVisibility: true,
              horizontalSpace: 0,
              shadowBorderRadius: 50,
              initialPosition: AnchoringPosition.center,
              dragController: market_dragController,
              child: GestureDetector(
                onPanUpdate: (DragUpdateDetails details) {
                  setState(() {
                    marketCard_widgetPosition = details.globalPosition;
                    if(marketCard_widgetPosition.dy > 600){
                      _toggleGlow();
                    }else{
                      _toggleGlow();
                    }
                  });
                },
                onPanEnd: (val){
                  //_gotoMarket("Player 1");
                },
                child: Container(
                  height: cardHeigt,
                  width: cardWidth,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(ImageLibrary.CardBack),
                        fit: BoxFit.cover,
                      ),
                      borderRadius:
                          BorderRadius.all(Radius.circular(cardBoderRadius))),
                ),
              ),
            ),*/
            //Play Card (Draggable)
            DraggableWidget(
              bottomMargin: 80,
              topMargin: deviceScreenHeight * 0.33,
              intialVisibility: movable_PlayerCard_Visibility,
              horizontalSpace: 0,
              shadowBorderRadius: 50,
              initialPosition: AnchoringPosition.center,
              dragController: play_dragController,
              child: GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    _thumbPositionDx = details.globalPosition.dx;
                    _thumbPositionDy = details.globalPosition.dy;
                    print("_thumbPosition dx: ${_thumbPositionDx}");
                    print("_thumbPosition dy: ${_thumbPositionDy}");
                    if (_thumbPositionDx > 200 &&
                        _thumbPositionDy > 300 &&
                        _thumbPositionDy < 500) {
                      if (_canPlayGo(movable_PlayerCard_Shape,
                          movable_PlayerCard_Number)) {
                        _isPlayAllowed = true;
                        _toggleGlow(true);
                        Future.delayed(const Duration(seconds: 1), () {
                          _toggleGlow(false);
                        });
                      } else {
                        _isPlayAllowed = false;
                        _toggleGlow(true);
                        Future.delayed(const Duration(seconds: 1), () {
                          _toggleGlow(false);
                        });
                      }
                    } else {
                      _isPlayAllowed = false;
                      _toggleGlow(true);
                      Future.delayed(const Duration(seconds: 1), () {
                        _toggleGlow(false);
                      });
                    }
                  });
                },
                onPanEnd: (val) {
                  if (_thumbPositionDx > 200 &&
                      _thumbPositionDy > 300 &&
                      _thumbPositionDy < 500) {
                    if (_canPlayGo(
                        movable_PlayerCard_Shape, movable_PlayerCard_Number)) {
                      String _shape = movable_PlayerCard_Shape;
                      int _number = movable_PlayerCard_Number;
                      int _index = movable_PlayerCard_Index;
                      _isPlayAllowed = true;
                      _toggleGlow(true);
                      Future.delayed(const Duration(seconds: 1), () {
                        play_dragController?.jumpTo(AnchoringPosition.center);
                        movable_PlayerCard_Visibility = false;
                        movable_PlayerCard_Image = "";
                        Center_Game_Whot_Stack.add(
                            Draggable_Card_Whot_Stack[0]);
                        Draggable_Card_Whot_Stack.removeAt(0);
                        _isCenterDeckGlowing = false;
                        movable_PlayerCard_Shape = "";
                        movable_PlayerCard_Number = 0;
                        movable_PlayerCard_Index = 100;
                        _toggleGlow(false);
                      }).then((val) {
                        _playerPlay(_shape, _number, _index);
                      });
                    } else {
                      _isPlayAllowed = false;
                      _toggleGlow(true);
                      Future.delayed(const Duration(seconds: 1), () {
                        _toggleGlow(false);
                      });
                    }
                  } else {
                    _isPlayAllowed = false;
                    _toggleGlow(true);
                    Future.delayed(const Duration(seconds: 1), () {
                      _toggleGlow(false);
                    });
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  height: cardHeigt,
                  width: cardWidth,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(movable_PlayerCard_Image),
                        fit: BoxFit.cover,
                      ),
                      color: Colors.black,
                      borderRadius: const BorderRadius.all(
                          Radius.circular(cardBoderRadius)),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.blue,
                          blurRadius: 30.0,
                          spreadRadius: 5.0,
                        ),
                      ]),
                ),
              ),
            ),
//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
