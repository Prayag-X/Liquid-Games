import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextEditingController ipController = TextEditingController(text: '');
  TextEditingController usernameController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  TextEditingController snakeDirController = TextEditingController(text: '');
  TextEditingController asteroidDirController = TextEditingController(text: '');
  TextEditingController snakePortController = TextEditingController(text: '');
  TextEditingController asteroidPortController = TextEditingController(text: '');

  late String ip;
  late String username;
  late String password;
  late String snakeDir;
  late String asteroidDir;
  late int snakePort;
  late int asteroidPort;
  late SharedPreferences prefs;

  getSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
    ip = prefs.getString('ip') ?? '192.168.56.101';
    username = prefs.getString('username') ?? 'lg';
    password = prefs.getString('password') ?? 'lg';
    snakeDir = prefs.getString('snakeDir') ?? '../home/galaxy-snake/Bash/';
    asteroidDir = prefs.getString('asteroidDir') ?? '../home/galaxy-asteroids/scripts/';
    snakePort = prefs.getInt('snakePort') ?? 8114;
    asteroidPort = prefs.getInt('asteroidPort') ?? 8129;
    setTextControllers();
  }

  setSharedPrefs() async {
    await prefs.setString('ip', ipController.text);
    await prefs.setString('username', usernameController.text);
    await prefs.setString('password', passwordController.text);
    await prefs.setString('snakeDir', snakeDirController.text);
    await prefs.setString('asteroidDir', asteroidDirController.text);
    await prefs.setInt('snakePort', int.parse(snakePortController.text));
    await prefs.setInt('asteroidPort', int.parse(asteroidPortController.text));
  }

  setTextControllers() {
    setState(() {
      ipController.text = ip;
      usernameController.text = username;
      passwordController.text = password;
      snakeDirController.text = snakeDir;
      asteroidDirController.text = asteroidDir;
      snakePortController.text = snakePort.toString();
      asteroidPortController.text = asteroidPort.toString();
    });
  }

  @override
  void initState() {
    super.initState();
    getSharedPrefs();
  }

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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 9,
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
              onPressed: () async {
                await setSharedPrefs();
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(0),
              ),
              child: const Icon(
                Icons.done,
                size: 30,
              ),
            ),
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormFields(
                  icon: Icons.network_check_rounded,
                  hintText: 'IP address',
                  controller: ipController,
                ),
                const SizedBox(height: 15,),
                TextFormFields(
                  icon: Icons.person,
                  hintText: 'LG Username',
                  controller: usernameController,
                ),
                const SizedBox(height: 15,),
                TextFormFields(
                  icon: Icons.key_rounded,
                  hintText: 'LG Password',
                  controller: passwordController,
                ),
                const SizedBox(height: 15,),
                TextFormFields(
                  icon: Icons.folder,
                  hintText: 'Snake Directory',
                  controller: snakeDirController,
                ),
                const SizedBox(height: 15,),
                TextFormFields(
                  icon: Icons.folder,
                  hintText: 'Asteroid Directory',
                  controller: asteroidDirController,
                ),
                const SizedBox(height: 15,),
                TextFormFields(
                  icon: Icons.games,
                  hintText: 'Snake Port',
                  controller: snakePortController,
                ),
                const SizedBox(height: 15,),
                TextFormFields(
                  icon: Icons.games,
                  hintText: 'Asteroid Port',
                  controller: asteroidPortController,
                ),
                const SizedBox(height: 15,),
              ],
            )),
      ),
    );
  }
}

class TextFormFields extends StatelessWidget {
  const TextFormFields({
    Key? key,
    required this.controller,
    required this.icon,
    required this.hintText,
  }) : super(key: key);

  final TextEditingController controller;
  final IconData icon;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
          labelText: hintText,
          labelStyle: TextStyle(
            fontSize: 15,
            color: Colors.white.withOpacity(0.5),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 1),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffffffff), width: 1),
          ),
        ),
        style: const TextStyle(
          fontSize: 17,
          color: Colors.white,
        ),
        controller: controller,
      ),
    );
  }
}
