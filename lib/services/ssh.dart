import 'dart:convert';

import 'package:dartssh2/dartssh2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SSHClientClass {
  String? username;
  String? password;
  String? snakeDir;
  String? asteroidDir;
  String? ip;
  int port = 22;
  int? snakePort;
  int? asteroidPort;

  final encoder = const Utf8Encoder();

  getSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    ip = prefs.getString('ip') ?? '192.168.56.101';
    username = prefs.getString('username') ?? 'lg';
    password = prefs.getString('password') ?? 'lg';
    snakeDir = prefs.getString('snakeDir') ?? '../home/galaxy-snake/Bash/';
    asteroidDir =
        prefs.getString('asteroidDir') ?? '../home/galaxy-asteroids/scripts/';
    snakePort = prefs.getInt('snakePort') ?? 8114;
    asteroidPort = prefs.getInt('asteroidPort') ?? 8129;
  }

  openSnake() async {
    await getSharedPrefs();

    final client = SSHClient(
      await SSHSocket.connect(ip!, port),
      username: username!,
      onPasswordRequest: () => password!,
    );

    final shell = await client.shell();

    shell.write(encoder.convert(
        'echo $password | sudo -S chown $username:$username /home/$username/.pm2/rpc.sock /home/$username/.pm2/pub.sock\n'));
    shell.write(encoder.convert('bash ${snakeDir}open-snake.sh\n'));
    shell.write(encoder.convert('exit\n'));
    await shell.stdout.join();

    client.close();
  }

  closeSnake() async {
    await getSharedPrefs();

    final client = SSHClient(
      await SSHSocket.connect(ip!, port),
      username: username!,
      onPasswordRequest: () => password!,
    );

    final shell = await client.shell();

    shell.write(encoder.convert(
        'echo $password | sudo -S chown $username:$username /home/$username/.pm2/rpc.sock /home/$username/.pm2/pub.sock\n'));
    shell.write(encoder.convert('bash ${snakeDir}kill-snake.sh\n'));
    shell.write(encoder.convert('exit\n'));
    await shell.stdout.join();

    client.close();
  }

  openAsteroids() async {
    await getSharedPrefs();

    final client = SSHClient(
      await SSHSocket.connect(ip!, port),
      username: username!,
      onPasswordRequest: () => password!,
    );

    final shell = await client.shell();

    shell.write(encoder.convert(
        'echo $password | sudo -S chown $username:$username /home/$username/.pm2/rpc.sock /home/$username/.pm2/pub.sock\n'));
    shell.write(encoder.convert('bash ${asteroidDir}open.sh\n'));
    shell.write(encoder.convert('exit\n'));
    await shell.stdout.join();

    client.close();
  }

  closeAsteroids() async {
    await getSharedPrefs();

    final client = SSHClient(
      await SSHSocket.connect(ip!, port),
      username: username!,
      onPasswordRequest: () => password!,
    );

    final shell = await client.shell();

    shell.write(encoder.convert(
        'echo $password | sudo -S chown $username:$username /home/$username/.pm2/rpc.sock /home/$username/.pm2/pub.sock\n'));
    shell.write(encoder.convert('bash ${asteroidDir}close.sh\n'));
    shell.write(encoder.convert('exit\n'));
    await shell.stdout.join();

    client.close();
  }
}
