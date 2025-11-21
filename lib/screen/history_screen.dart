import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryScreen extends StatefulWidget {
  final SharedPreferences prefs;
  HistoryScreen({required this.prefs});

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<String> history = [];

  @override
  void initState() {
    super.initState();
    history = widget.prefs.getStringList('history') ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('History')),
      body: history.isEmpty
          ? Center(child: Text('No history yet'))
          : ListView.separated(
        itemCount: history.length,
        separatorBuilder: (_,__) => Divider(height: 1),
        itemBuilder: (context, i) {
          final parts = history[i].split('|');
          final time = parts[0];
          final cat = parts[1];
          final inVal = parts[2];
          final outVal = parts[3];
          return ListTile(
            title: Text('$cat • $inVal → $outVal'),
            subtitle: Text(time),
            trailing: IconButton(icon: Icon(Icons.copy), onPressed: () {}),
            onTap: () {},
          );
        },
      ),
    );
  }
}