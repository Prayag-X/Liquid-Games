import 'package:flutter/material.dart';
import 'controller.dart';
import '../services/ssh.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final SSHClientClass ssh = SSHClientClass();
  final snackBar = const SnackBar(
    content: Text(
      'Error!',
      style: TextStyle(color: Colors.red),
    ),
    duration: Duration(seconds: 2),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: const Color(0x67000000),
        elevation: 0.0,
        toolbarHeight: 70,
        titleSpacing: 0,
        leadingWidth: 0,
        title: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 30,
              width: 64,
            ),
            Column(
              children: const [
                Text(
                  'LIQUID GAMES',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Prayag Biswas',
                  style: TextStyle(fontSize: 11, color: Colors.blue),
                ),
              ],
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/Settings'),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(0),
              ),
              child: const Icon(
                Icons.settings,
                size: 30,
              ),
            ),
          ],
        )),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 120,
              ),
              Container(
                height: 200,
                width: 400,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/lg_logo.png'),
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Galaxy Snake',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () async {
                    try {
                      await ssh.openSnake();
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                  ),
                  child: const HomePageButton(
                    color: Colors.blue,
                    text: 'Open Galaxy Snake in LG rig',
                  )),
              TextButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Controller(game: 1))),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                  ),
                  child: const HomePageButton(
                    color: Colors.yellow,
                    text: 'Open Galaxy Snake controller',
                  )),
              TextButton(
                  onPressed: () async {
                    try {
                      await ssh.closeSnake();
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                  ),
                  child: const HomePageButton(
                    color: Colors.red,
                    text: 'Close Galaxy Snake in LG rig',
                  )),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Galaxy Asteroids',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () async {
                    try {
                      await ssh.openAsteroids();
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                  ),
                  child: const HomePageButton(
                    color: Colors.blue,
                    text: 'Open Galaxy Asteroid in LG rig',
                  )),
              TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/Controller'),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                  ),
                  child: const HomePageButton(
                    color: Colors.yellow,
                    text: 'Open Galaxy Asteroid controller',
                  )),
              TextButton(
                  onPressed: () async {
                    try {
                      await ssh.closeAsteroids();
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                  ),
                  child: const HomePageButton(
                    color: Colors.red,
                    text: 'Close Galaxy Asteroid in LG rig',
                  )),
            ],
          )),
    );
  }
}

class HomePageButton extends StatelessWidget {
  const HomePageButton({
    Key? key,
    required this.text,
    required this.color,
  }) : super(key: key);

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 280,
      decoration: BoxDecoration(
        color: color.withOpacity(0.5),
        border: Border.all(width: 0.6, color: color),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
