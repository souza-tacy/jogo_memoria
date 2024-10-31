import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class MemoryGame extends StatefulWidget {
  const MemoryGame({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MemoryGameState createState() => _MemoryGameState();
}

class _MemoryGameState extends State<MemoryGame> {
  final List<String> images = [
    'assets/imagem/img1.jpeg',
    'assets/imagem/img2.jpeg',
    'assets/imagem/img3.jpeg',
  ];

  late List<String> gameImages;
  late List<bool> selected;
  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    resetGame();
  }

  void resetGame() {
    gameImages = [...images, ...images]..shuffle(Random());
    selected = List.filled(gameImages.length, false);
    selectedIndex = -1;
  }

  void handleTileTap(int index) {
    if (!selected[index]) {
      setState(() {
        selected[index] = true;
      });

      if (selectedIndex == -1) {
        selectedIndex = index;
      } else {
        if (gameImages[selectedIndex] != gameImages[index]) {
          Timer(const Duration(seconds: 1), () {
            setState(() {
              selected[selectedIndex] = false;
              selected[index] = false;
              selectedIndex = -1;
            });
          });
        } else {
          selectedIndex = -1;

          if (selected.every((element) => element)) {
            _showWinDialog();
          }
        }
      }
    }
  }

  void _showWinDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        bool isSmallScreen = MediaQuery.of(context).size.width < 320;
        double buttonFontSize = isSmallScreen ? 12 : 16;

        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 246, 242, 247),
          title: const Center(
            child: Text(
              "Parabéns!",
              style: TextStyle(
                color: Color.fromARGB(255, 202, 14, 139),
                fontFamily: 'Cursive',
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: const SizedBox.shrink(),
          actions: [
            const SizedBox(height: 20),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  resetGame();
                  setState(() {});
                },
                style: TextButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 191, 16, 207),
                  padding: EdgeInsets.symmetric(
                      horizontal: 20 * (isSmallScreen ? 0.8 : 1),
                      vertical: 10 * (isSmallScreen ? 0.8 : 1)),
                ),
                child: Text(
                  isSmallScreen ? "Novo Jogo" : "Jogar Novamente",
                  style: TextStyle(
                    color: const Color.fromARGB(255, 94, 10, 66),
                    fontSize: buttonFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    int crossAxisCount = (width ~/ 100).clamp(2, 3);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 252, 252),
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Jogo da Memória",
            style: TextStyle(
              fontFamily: 'Cursive',
              color: Color.fromARGB(255, 161, 33, 119),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              resetGame();
              setState(() {});
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.0,
        ),
        itemCount: gameImages.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => handleTileTap(index),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(188, 195, 114, 241),
                border: Border.all(
                    width: 4, color: const Color.fromARGB(188, 195, 114, 241)),
                borderRadius: BorderRadius.circular(10),
                image: selected[index]
                    ? DecorationImage(
                        image: AssetImage(gameImages[index]),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: !selected[index]
                  ? const Center(
                      child:
                          Icon(Icons.favorite, color: Colors.white, size: 40),
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }
}
