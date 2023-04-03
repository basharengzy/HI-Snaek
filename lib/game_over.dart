import 'package:SnakeGameFlutter/game_page.dart';
import 'package:flutter/material.dart';

import 'color.dart';

class GameOver extends StatelessWidget {

  final int score;

  GameOver({
    this.score
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: logo2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Game Over', style:
            TextStyle(color: backcolor,
                fontSize: 50.0, fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic, shadows: [
                Shadow( // bottomLeft
                  offset: Offset(-1.5, -1.5),
                  color: black
                ),
                Shadow( // bottomRight
                  offset: Offset(1.5, -1.5),
                  color: black
                ),
                Shadow( // topRight
                  offset: Offset(1.5, 1.5),
                  color: black
                ),
                Shadow( // topLeft
                  offset: Offset(-1.5, 1.5),
                  color:black
                ),
              ])
            ),
            
            SizedBox(height: 50.0),

            Text('Your Score is: $score',
                style: TextStyle(color: searcecolor, fontSize: 20.0)),

            SizedBox(height: 50.0),

            ElevatedButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(12),
                  backgroundColor: MaterialStateProperty.all(logo5),
                ),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>
                    GamePage()));
              },
           //   icon: Icon(Icons.refresh, color: Colors.white, size: 30.0),
             child: Text("Try Again", style: TextStyle(color: searcecolor, fontSize: 20.0))
            ),
          ],
        ),
      )
    );
  }
}