import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_converter/screen/converter_screen.dart';
import 'package:smart_converter/screen/history_screen.dart' show HistoryScreen;

import '../model/category.dart';

class HomeScreen extends StatefulWidget {
  final Function(ThemeMode) onThemeChanged;
  final SharedPreferences prefs;
  HomeScreen({required this.onThemeChanged, required this.prefs});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Category> categories = [
    Category('Area', Icons.crop_square, 0xFF4FC3F7),
    Category('Currency', Icons.money, 0xFFF06292),
    Category('Length', Icons.straighten, 0xFF81C784),
    Category('Temperature', Icons.thermostat_outlined, 0xFFFFB74D),
    Category('Speed', Icons.speed, 0xFF64B5F6),
    Category('Electricity', Icons.bolt, 0xFFFFAB91),
    Category('Fuel', Icons.local_gas_station, 0xFF90CAF9),
    Category('Volume', Icons.inbox, 0xFFCE93D8),
    Category('Time', Icons.access_time, 0xFF80DEEA),
    Category('Weight', Icons.fitness_center, 0xFFB39DDB),
    Category('Pressure', Icons.compress, 0xFFB0BEC5),
    Category('Data', Icons.storage, 0xFF9FA8DA),
    Category('Angle', Icons.square_foot, 0xFFA5D6A7),
    Category('Sound', Icons.volume_up, 0xFFFFCC80),
    Category('Frequency', Icons.wifi_tethering, 0xFFFFAB91),
  ];

  String search = '';

  @override
  Widget build(BuildContext context) {
    /// theme are deciding here
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text('Smart Unit Converter'),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              final newMode = isDark ? ThemeMode.light : ThemeMode.dark;
              widget.onThemeChanged(newMode);
            },
          ),
        ],
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          );
        }),
      ),
      drawer: _buildDrawer(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
        child: Column(
          children: [
            _buildSearchBar(),
            SizedBox(height: 12),
            Expanded(child: _buildGrid()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => HistoryScreen(prefs: widget.prefs)));
        },
        child: Icon(Icons.history),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      onChanged: (v) => setState(() => search = v.trim()),
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).cardColor,
        hintText: 'Search conversions...'
        ,
        prefixIcon: Icon(Icons.search),
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
      ),
    );
  }

  Widget _buildGrid() {
    final filtered = categories.where((c) => c.title.toLowerCase().contains(search.toLowerCase())).toList();
    return GridView.builder(
      itemCount: filtered.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.9,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
      ),
      itemBuilder: (context, i) {
        final cat = filtered[i];
        return GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => ConverterScreen(category: cat, prefs: widget.prefs))),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10, offset: Offset(0, 6)),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Color(cat.color).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(cat.icon, size: 30, color: Color(cat.color)),
                ),
                SizedBox(height: 12),
                Text(cat.title, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDrawer(BuildContext ctx) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            ListTile(title: Text('Settings', style: TextStyle(fontWeight: FontWeight.bold))),
            ListTile(
              leading: Icon(Icons.brightness_6),
              title: Text('Theme: System'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.star_border),
              title: Text('Bookmarks'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.delete_outline),
              title: Text('Clear History'),
              onTap: () async {
                await widget.prefs.remove('history');
                ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text('History cleared')));
              },
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text('----All Rights reserved by Rockys World ❤️ •', style: TextStyle(color: Colors.grey)),
            )
          ],
        ),
      ),
    );
  }
}