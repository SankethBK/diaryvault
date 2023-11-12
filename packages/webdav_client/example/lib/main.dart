import 'package:flutter/material.dart';
import 'package:webdav_client/webdav_client.dart' as webdav;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  // webdav
  late webdav.Client client;

  // TODO need change your test url && user && pwd
  // if you use browser and received 'XMLHttpRequest error'  you need check cors!!!
  // https://stackoverflow.com/questions/65630743/how-to-solve-flutter-web-api-cors-error-only-with-dart-code
  final url = '';
  final user = '';
  final pwd = '';
  final dirPath = '/';

  @override
  void initState() {
    super.initState();

    // init client
    client = webdav.newClient(
      url,
      user: user,
      password: pwd,
      debug: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty || user.isEmpty || pwd.isEmpty) {
      return const Center(child: Text("you need add url || user || pwd"));
    }
    return Scaffold(
      body: FutureBuilder(
          future: _getData(),
          builder: (BuildContext context,
              AsyncSnapshot<List<webdav.File>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.active:
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                return _buildListView(context, snapshot.data ?? []);
            }
          }),
    );
  }

  Future<List<webdav.File>> _getData() {
    return client.readDir(dirPath);
  }

  Widget _buildListView(BuildContext context, List<webdav.File> list) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          final file = list[index];
          return ListTile(
            leading: Icon(
                file.isDir == true ? Icons.folder : Icons.file_present_rounded),
            title: Text(file.name ?? ''),
            subtitle: Text(file.mTime.toString()),
          );
        });
  }
}
