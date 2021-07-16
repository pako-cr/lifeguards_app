import 'package:flutter/material.dart';
import 'package:lifeguards_app/global/environment.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Report Incident',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
        ),
        elevation: 1,
        backgroundColor: Colors.red[900],
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
                  title: Text('Name'),
                  subtitle: Text('Full name'),
                ),
                TextField(
                  onChanged: (_) => {null},
                  // controller: textController,
                  autocorrect: false,
                  // keyboardType: this.keyboardType,
                  decoration: InputDecoration(
                    // prefixIcon: Icon(this.icon),
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                    // hintText: this.placeholder,
                  ),
                ),
              ]),
              Divider(),
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
                label: const Text('Send Report'),
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
}
