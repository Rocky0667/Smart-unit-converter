import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/category.dart';

class ConverterScreen extends StatefulWidget {
  final Category category;
  final SharedPreferences prefs;
  ConverterScreen({required this.category, required this.prefs});

  @override
  _ConverterScreenState createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  final TextEditingController _controller = TextEditingController();
  String fromUnit = 'Unit A';
  String toUnit = 'Unit B';
  String result = '';

  ///===============for length==========================
  final TextEditingController lengthInputController = TextEditingController();
  String lengthResult = "";
  String lengthFromUnit = "Meter";
  String lengthToUnit = "Kilometer";

  final lengthUnits = ["Meter", "Kilometer", "Mile", "Inch"];

  double lengthConvert(double value, String from, String to) {
    Map<String, double> toMeters = {
      "Meter": 1.0,
      "Kilometer": 1000.0,
      "Mile": 1609.34,
      "Inch": 0.0254,
    };

    double valueInMeters = value * toMeters[from]!;
    return valueInMeters / toMeters[to]!;
  }

  ///========================end========================

  ///====================Temperature====================
  final TextEditingController temperatureInputController =
      TextEditingController();
  String temperatureResult = "";
  String temperatureFromUnit = "Celsius";
  String temperatureToUnit = "Fahrenheit";

  final temperatureUnits = ["Celsius", "Fahrenheit", "Kelvin"];

  double temperatureConvert(double value, String from, String to) {
    if (from == to) return value;
    if (from == "Celsius" && to == "Fahrenheit") return (value * 9 / 5) + 32;
    if (from == "Fahrenheit" && to == "Celsius") return (value - 32) * 5 / 9;
    if (from == "Celsius" && to == "Kelvin") return value + 273.15;
    if (from == "Kelvin" && to == "Celsius") return value - 273.15;
    if (from == "Fahrenheit" && to == "Kelvin")
      return ((value - 32) * 5 / 9) + 273.15;
    if (from == "Kelvin" && to == "Fahrenheit")
      return ((value - 273.15) * 9 / 5) + 32;
    return value;
  }

  ///====================================================

  ///===================Currency========================
  final TextEditingController currencyInputController = TextEditingController();
  String currencyResult = "";
  String currencyFromUnit = "USD";
  String currencyToUnit = "BDT";

  final currencyUnits = ["USD", "EUR", "BDT", "INR"];
  final Map<String, double> rates = {
    "USD": 1.0,
    "EUR": 0.9,
    "BDT": 119.5,
    "INR": 83.2,
  };

  double currencyConvert(double value, String from, String to) {
    double usdValue = value / rates[from]!;
    return usdValue * rates[to]!;
  }

  ///===================End=============================

  ///===================weight==========================
  final TextEditingController weightInputController = TextEditingController();
  String weightResult = "";
  String weightFromUnit = "Kilogram";
  String weighToUnit = "Gram";

  final weightUnits = ["Kilogram", "Gram", "Pound"];

  double weightConvert(double value, String from, String to) {
    Map<String, double> toKg = {
      "Kilogram": 1.0,
      "Gram": 0.001,
      "Pound": 0.453592,
    };

    double valueInKg = value * toKg[from]!;
    return valueInKg / toKg[to]!;
  }

  ///====================End============================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.category.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ///for length screen
            if (widget.category.title == 'Length') ...[
              Column(
                children: [
                  TextField(
                    controller: lengthInputController,
                    decoration: const InputDecoration(
                      labelText: "Enter value",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DropdownButton<String>(
                        value: lengthFromUnit,
                        items: lengthUnits
                            .map(
                              (u) => DropdownMenuItem(value: u, child: Text(u)),
                            )
                            .toList(),
                        onChanged: (val) =>
                            setState(() => lengthFromUnit = val!),
                      ),
                      const Icon(Icons.arrow_forward),
                      DropdownButton<String>(
                        value: lengthToUnit,
                        items: lengthUnits
                            .map(
                              (u) => DropdownMenuItem(value: u, child: Text(u)),
                            )
                            .toList(),
                        onChanged: (val) => setState(() => lengthToUnit = val!),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      double input =
                          double.tryParse(lengthInputController.text) ?? 0;
                      double output = lengthConvert(
                        input,
                        lengthFromUnit,
                        lengthToUnit,
                      );
                      setState(() {
                        lengthResult = "$output $lengthToUnit";
                      });
                    },
                    child: const Text("Convert"),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    lengthResult,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ]
            ///end of length
            ///for temperature
            else if (widget.category.title == 'Temperature')
              Column(
                children: [
                  TextField(
                    controller: temperatureInputController,
                    decoration: const InputDecoration(
                      labelText: "Enter value",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DropdownButton<String>(
                        value: temperatureFromUnit,
                        items: temperatureUnits
                            .map(
                              (u) => DropdownMenuItem(value: u, child: Text(u)),
                            )
                            .toList(),
                        onChanged: (val) =>
                            setState(() => temperatureFromUnit = val!),
                      ),
                      const Icon(Icons.arrow_forward),
                      DropdownButton<String>(
                        value: temperatureToUnit,
                        items: temperatureUnits
                            .map(
                              (u) => DropdownMenuItem(value: u, child: Text(u)),
                            )
                            .toList(),
                        onChanged: (val) =>
                            setState(() => temperatureToUnit = val!),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      double input =
                          double.tryParse(temperatureInputController.text) ?? 0;
                      double output = temperatureConvert(
                        input,
                        temperatureFromUnit,
                        temperatureToUnit,
                      );
                      setState(() {
                        temperatureResult = "$output $temperatureToUnit";
                      });
                    },
                    child: const Text("Convert"),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    temperatureResult,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ///end of temperature
            ///for temperature
            else if (widget.category.title == 'Currency')
              Column(
                children: [
                  TextField(
                    controller: currencyInputController,
                    decoration: const InputDecoration(
                      labelText: "Enter amount",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DropdownButton<String>(
                        value: currencyFromUnit,
                        items: currencyUnits
                            .map(
                              (u) => DropdownMenuItem(value: u, child: Text(u)),
                            )
                            .toList(),
                        onChanged: (val) =>
                            setState(() => currencyFromUnit = val!),
                      ),
                      const Icon(Icons.arrow_forward),
                      DropdownButton<String>(
                        value: currencyToUnit,
                        items: currencyUnits
                            .map(
                              (u) => DropdownMenuItem(value: u, child: Text(u)),
                            )
                            .toList(),
                        onChanged: (val) =>
                            setState(() => currencyToUnit = val!),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      double input =
                          double.tryParse(currencyInputController.text) ?? 0;
                      double output = currencyConvert(
                        input,
                        currencyFromUnit,
                        currencyToUnit,
                      );
                      setState(() {
                        currencyResult = "$output $currencyToUnit";
                      });
                    },
                    child: const Text("Convert"),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    currencyResult,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ///end of temperature
            ///for temperature
            else if (widget.category.title == 'Weight')
              Column(
                children: [
                  TextField(
                    controller: weightInputController,
                    decoration: const InputDecoration(
                      labelText: "Enter value",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DropdownButton<String>(
                        value: weightFromUnit,
                        items: weightUnits
                            .map(
                              (u) => DropdownMenuItem(value: u, child: Text(u)),
                            )
                            .toList(),
                        onChanged: (val) =>
                            setState(() => weightFromUnit = val!),
                      ),
                      const Icon(Icons.arrow_forward),
                      DropdownButton<String>(
                        value: weighToUnit,
                        items: weightUnits
                            .map(
                              (u) => DropdownMenuItem(value: u, child: Text(u)),
                            )
                            .toList(),
                        onChanged: (val) => setState(() => weighToUnit = val!),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      double input =
                          double.tryParse(weightInputController.text) ?? 0;
                      double output = weightConvert(
                        input,
                        weightFromUnit,
                        weighToUnit,
                      );
                      setState(() {
                        weightResult = "$output $weighToUnit";
                      });
                    },
                    child: const Text("Convert"),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    weightResult,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ///end of temperature
            else ...[
              Row(
                children: [
                  Expanded(
                    child: _unitCard(title: 'From', valueWidget: _inputField()),
                  ),
                  SizedBox(width: 12),
                  Icon(Icons.swap_horiz, size: 34),
                  SizedBox(width: 12),
                  Expanded(
                    child: _unitCard(title: 'To', valueWidget: _resultBox()),
                  ),
                ],
              ),
              SizedBox(height: 18),
              ElevatedButton.icon(
                onPressed: _convert,
                icon: Icon(Icons.calculate),
                label: Text('Convert'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                ),
              ),
              SizedBox(height: 14),
              if (result.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Result saved to history',
                      style: TextStyle(color: Colors.grey),
                    ),
                    IconButton(
                      icon: Icon(Icons.bookmark_border),
                      onPressed: () {},
                    ),
                  ],
                ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _unitCard({required String title, required Widget valueWidget}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 12, color: Colors.grey)),
            SizedBox(height: 8),
            valueWidget,
          ],
        ),
      ),
    );
  }

  Widget _inputField() {
    return TextField(
      controller: _controller,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        hintText: 'Enter value',
        border: InputBorder.none,
      ),
    );
  }

  Widget _resultBox() {
    return Container(
      height: 48,
      alignment: Alignment.centerLeft,
      child: Text(
        result.isEmpty ? '--' : result,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }

  void _convert() async {
    final txt = _controller.text.trim();
    if (txt.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please enter a value')));
      return;
    }

    final value = double.tryParse(txt);
    if (value == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Invalid number')));
      return;
    }

    // Placeholder conversion: identity. Replace with real logic per category.
    final out = value; // TODO: apply conversion logic

    setState(() {
      result = out.toString();
    });

    // Save to history (simple JSON string append)
    final prefs = widget.prefs;
    final hist = prefs.getStringList('history') ?? [];
    hist.insert(
      0,
      '${DateTime.now().toIso8601String()}|${widget.category.title}|$value|$out',
    );
    await prefs.setStringList('history', hist);
  }
}
