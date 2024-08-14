import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var choice = 'Turn - O'; // Indicates whose turn it is
  var win = ''; // Stores the winner
  int i = 0; // Move counter
  int x = 0; // Win state counter
  var block = ['', '', '', '', '', '', '', '', '']; // Board state

  // Updates the board based on the current player's move
  void getdata(var index) {
    setState(() {
      if (block[index] == '') {
        if (i % 2 == 0) {
          block[index] = 'O';
          choice = 'Turn - X';
        } else {
          block[index] = 'X';
          choice = 'Turn - O';
        }
        i++;
      }
    });
  }

  // Resets the game board
  void restart() {
    setState(() {
      for (int i = 0; i < block.length; i++) {
        block[i] = '';
      }
      i = 0;
      choice = 'Turn - O';
    });
  }

  // Checks for a winner
  String winner() {
    // Checking Rows
    if (block[0] == block[1] && block[0] == block[2] && block[0] != '') {
      x++;
      return (block[0] + ' wins');
    }
    if (block[3] == block[4] && block[3] == block[5] && block[3] != '') {
      x++;
      return (block[3] + ' wins');
    }
    if (block[6] == block[7] && block[6] == block[8] && block[6] != '') {
      x++;
      return (block[6] + ' wins');
    }

    // Checking Columns
    if (block[0] == block[3] && block[0] == block[6] && block[0] != '') {
      x++;
      return (block[0] + ' wins');
    }
    if (block[1] == block[4] && block[1] == block[7] && block[1] != '') {
      x++;
      return (block[1] + ' wins');
    }
    if (block[2] == block[5] && block[2] == block[8] && block[2] != '') {
      x++;
      return (block[2] + ' wins');
    }

    // Checking Diagonals
    if (block[0] == block[4] && block[0] == block[8] && block[0] != '') {
      x++;
      return (block[0] + ' wins');
    }
    if (block[2] == block[4] && block[2] == block[6] && block[2] != '') {
      x++;
      return (block[2] + ' wins');
    }
    return '';
  }

  // Resets the game after 2 games
  void again() {
    if (x == 2) {
      x = 0;
      restart();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'TIC TAC TOE',
            style: TextStyle(
                fontSize: 50, fontWeight: FontWeight.bold, color: Colors.brown),
          ),
        ),
        backgroundColor: Colors.black,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: Colors.brown.shade900,
            height: 3,
          ),
        ),
      ),
      backgroundColor: Colors.brown.shade700,
      body: Column(
        children: [
          // Displays the current turn
          Container(
            width: 700,
            height: 50,
            margin: EdgeInsets.all(20),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(
                color: Colors.brown.shade900,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Text(choice,
                style: TextStyle(
                    color: Colors.brown,
                    fontSize: 30,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold)),
          ),
          Container(
            width: 800,
            height: 30,
            alignment: Alignment.center,
            child: Text(
              "'In Tic-Tac-Toe, you're either 'X'-cellent or 'O'-so close!'",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontStyle: FontStyle.italic),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              margin: EdgeInsets.all(10),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, crossAxisSpacing: 2, mainAxisSpacing: 2),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(2),
                    child: InkWell(
                      onTap: () {
                        if (i <= 9) {
                          if (x == 0) {
                            getdata(index);
                            win = winner();
                            again();
                          } else if (x == 1) {
                            x++;
                            gameOver(win);
                            x = 0;
                            restart();
                          }
                        }
                        if (win == '' && i == 9) {
                          draw();
                          restart();
                        }
                      },
                      child: Container(
                        child: Center(
                          child: Text(block[index],
                              style: TextStyle(
                                color: Colors.brown,
                                fontSize: 60,
                              )),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.brown.shade900,
                            width: 3,
                          ),
                          color: Colors.black,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: block.length,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => restart(),
          child: Icon(Icons.restart_alt_rounded, color: Colors.brown.shade400),
          backgroundColor: Colors.black),
    );
  }

  // Displays the winner message
  gameOver(String win) {
    if (win != '') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.brown.shade400,
          content: Text(
            'Congrats! $win',
            style: TextStyle(
                fontSize: 25,
                fontStyle: FontStyle.italic,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
  }

  // Displays the draw message
  draw() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.brown.shade400,
        content: Text(
          'Draw!',
          style: TextStyle(
              fontSize: 25,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
