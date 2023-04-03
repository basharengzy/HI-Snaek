import 'dart:async';
import 'dart:math';

import 'package:SnakeGameFlutter/game_over.dart';
import 'package:flutter/material.dart';

import 'color.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with TickerProviderStateMixin {

  int _playerScore;
  bool _hasStarted;
  Animation _snakeAnimation;
  AnimationController _snakeController;
  List _snake = [404, 405, 406, 407];
  final int _noOfSquares = 400;
  final Duration _duration = Duration(milliseconds: 50);
  final int _squareSize = 16;
  String _currentSnakeDirection;
  int _snakeFoodPosition;
  Random _random = new Random();

  @override
  void initState() {
    super.initState();
    _setUpGame();
  }

  void _setUpGame() {
    _playerScore = 0;
    _currentSnakeDirection = 'RIGHT';
    _hasStarted = true;
    do {
      _snakeFoodPosition = _random.nextInt(_noOfSquares);
    } while(_snake.contains(_snakeFoodPosition));
    _snakeController = AnimationController(vsync: this, duration: _duration);
    _snakeAnimation = CurvedAnimation(curve: Curves.easeInOut, parent: _snakeController);
  }

  void _gameStart() {
    Timer.periodic(Duration(milliseconds: 80), (Timer timer) {
      _updateSnake();
      if(_hasStarted) timer.cancel();
    });
  }

  bool _gameOver() {
    for (int i = 0; i < _snake.length - 1; i++)
      if (_snake.last == _snake[i]) return true;
    return false;
  }

  void _updateSnake() {
    if(!_hasStarted) {
      setState(() {
        _playerScore = (_snake.length - 4) * 100;
        switch (_currentSnakeDirection) {
          case 'DOWN':
            if (_snake.last > _noOfSquares)
              _snake.add(_snake.last + _squareSize -
                  (_noOfSquares + _squareSize));
            else _snake.add(_snake.last + _squareSize);
            break;
          case 'UP':
            if (_snake.last < _squareSize) _snake.add(_snake.last -
                _squareSize + (_noOfSquares + _squareSize));
            else _snake.add(_snake.last - _squareSize);
            break;
          case 'RIGHT':
            if ((_snake.last + 1) % _squareSize == 0)
              _snake.add(_snake.last + 1 - _squareSize);
            else _snake.add(_snake.last + 1);
            break;
          case 'LEFT':
            if ((_snake.last) % _squareSize == 0)
              _snake.add(_snake.last - 1 + _squareSize);
            else _snake.add(_snake.last - 1);
        }

        if (_snake.last != _snakeFoodPosition) _snake.removeAt(0);
        else {
          do {
            _snakeFoodPosition = _random.nextInt(_noOfSquares);
          } while (_snake.contains(_snakeFoodPosition));
        }

        if (_gameOver()) {
          setState(() {
            _hasStarted = !_hasStarted;
          });
          Navigator.of(context).pushReplacement
            (MaterialPageRoute(builder: (context) =>
              GameOver(score: _playerScore)));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screensize=MediaQuery.of(context).size;
    Color bolckpord22=backcolor;
    var colors=[ backcolor,logo1,logo5,logo5,navocolor];
    for (int i=0;i<5;i++){
      setState((){
        bolckpord22==colors[i];
      });
    };
    return Scaffold(
      appBar: AppBar(
        title: Text('HI Snaek', style: TextStyle(color: searcecolor,
            fontSize: 20.0)),
        centerTitle: false,
        backgroundColor: logo2,
        actions: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text('Score: $_playerScore',
                  style: TextStyle(fontSize: 16.0)),
            )
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: logo2,
        elevation: 20,
        label: Text(
          _hasStarted ? 'Start' : 'Pause',
          style: TextStyle(),
        ),
        onPressed: () {
          setState(() {
            if(_hasStarted) _snakeController.forward();
            else _snakeController.reverse();
            _hasStarted = !_hasStarted;
            _gameStart();
          });
        },
        icon: AnimatedIcon(icon:
        AnimatedIcons.play_pause, progress: _snakeAnimation)
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [

          Container(
            width: screensize.width,
            height: screensize.height,
            child: Center(
              child: GestureDetector(
                onVerticalDragUpdate: (drag) {
                  if (drag.delta.dy > 0 && _currentSnakeDirection != 'UP')
                    _currentSnakeDirection = 'DOWN';
                  else if (drag.delta.dy < 0 && _currentSnakeDirection != 'DOWN')
                    _currentSnakeDirection = 'UP';
                },
                onHorizontalDragUpdate: (drag) {
                  if (drag.delta.dx > 0 && _currentSnakeDirection != 'LEFT')
                    _currentSnakeDirection = 'RIGHT';
                  else if (drag.delta.dx < 0 && _currentSnakeDirection != 'RIGHT')
                    _currentSnakeDirection = 'LEFT';
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: screensize.height,
                  child: GridView.builder(
                    itemCount: _squareSize + _noOfSquares,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                    _squareSize),
                    itemBuilder: (BuildContext context, int index) {
                      return Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: screensize.height,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/Expansion.gif')
                            )
                          ),
                          //color: logo2,
                          padding: _snake.contains(index) ?
                          EdgeInsets.all(0.1) : EdgeInsets.only(top: 5,bottom: 5.5,
                              left:1,right: 1),
                          child: ClipRRect(
                            borderRadius: index == _snakeFoodPosition ||
                                index == _snake.last ? BorderRadius.
                            only(bottomLeft:Radius.elliptical(12, 44),
                            bottomRight: Radius.elliptical(11, 44),topLeft:
                                Radius.circular(12),
                              topRight: Radius.zero
                            )
                           // all(Radius.elliptical(100, 112))
                                  :
                            _snake.contains(index) ? BorderRadius.only(
                                bottomLeft:Radius.elliptical(11, 1),
                                bottomRight: Radius.elliptical(11, 1),
                                topLeft: Radius.circular(21),
                                topRight: Radius.circular(12)
                            )
                          //  circular(111.5)
                                  :
                            BorderRadius.all(Radius.elliptical(100, 119)),
                            child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: _snake.contains(index) ?
                                        AssetImage('assets/f1.gif'):
                                        index == _snakeFoodPosition ?
                                        AssetImage('assets/f6.png'):
                                        AssetImage('assets/f7.png')
                                    )
                                ),
                                // color: _snake.contains(index) ? backcolor2 :
                                // index == _snakeFoodPosition ? searcecolor : logo3
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}
