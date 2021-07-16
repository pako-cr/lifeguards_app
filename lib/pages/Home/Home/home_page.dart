import 'package:flutter/material.dart';
import 'package:lifeguards_app/global/environment.dart';
import 'package:lifeguards_app/pages/Home/Reports/reports_page.dart';
import 'package:provider/provider.dart';

import '../../../services/auth_service.dart';
import '../../../services/socket_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          authService.user?.name ?? '',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
        ),
        elevation: 1,
        backgroundColor: Colors.red[900],
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                socketService.disconnect();
                this.logOut();
              },
              child: Icon(
                Icons.exit_to_app,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.85,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Divider(),
              Column(children: <Widget>[
                ListTile(
                  title: Text('Todays location: Flamboyant'),
                  subtitle: Text('Tomorrow: Best Western'),
                  leading: CircleAvatar(
                      child: Icon(
                        Icons.location_on,
                        color: Colors.red,
                      ),
                      backgroundColor: Colors.yellow),
                ),
              ]),
              Divider(),
              Column(children: <Widget>[
                ListTile(
                  title: Text('High Tide: 8:12am'),
                  subtitle: Text('5-7 ft'),
                  leading: CircleAvatar(
                    child: Icon(Icons.waves),
                  ),
                ),
                ListTile(
                  title: Text('Low Tide: 3:14pm'),
                  subtitle: Text('5-6 ft'),
                  leading: CircleAvatar(
                    child: Icon(Icons.waves),
                    backgroundColor: Colors.yellow,
                  ),
                ),
              ]),
              Spacer(),
              FloatingActionButton.extended(
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReportsPage(),
                      fullscreenDialog: true,
                    ),
                  )
                  // Navigator..pushNamed(context, 'reports')
                },
                label: const Text('Report Incident'),
                icon: const Icon(Icons.send),
                backgroundColor: Environment.enabledColor,
                elevation: 5.0,
                tooltip: 'Report a prevention or a rescue',
              )
            ],
          ),
        ),
      ),
    );
  }

  void logOut() {
    Navigator.pushReplacementNamed(context, 'signin');
    AuthService.logout();
  }
}
