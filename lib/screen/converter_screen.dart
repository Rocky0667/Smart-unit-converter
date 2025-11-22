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
  String result = '';

  ///===============for length==========================
  final TextEditingController lengthInputController = TextEditingController();
  String lengthResult = "";
  String lengthFromUnit = "Meter";
  String lengthToUnit = "Kilometer";
  final lengthUnits = ["Meter", "Kilometer", "Mile", "Inch"];

  double lengthConvert(double value, String from, String to) {
    Map<String, double> toMeters = {"Meter": 1.0, "Kilometer": 1000.0, "Mile": 1609.34, "Inch": 0.0254};
    double valueInMeters = value * toMeters[from]!;
    return valueInMeters / toMeters[to]!;
  }

  ///====================Temperature====================
  final TextEditingController temperatureInputController = TextEditingController();
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
    if (from == "Fahrenheit" && to == "Kelvin") return ((value - 32) * 5 / 9) + 273.15;
    if (from == "Kelvin" && to == "Fahrenheit") return ((value - 273.15) * 9 / 5) + 32;
    return value;
  }

  ///===================Currency========================
  final TextEditingController currencyInputController = TextEditingController();
  String currencyResult = "";
  String currencyFromUnit = "USD";
  String currencyToUnit = "BDT";
  final currencyUnits = ["USD", "EUR", "BDT", "INR"];
  final Map<String, double> rates = {"USD": 1.0, "EUR": 0.9, "BDT": 119.5, "INR": 83.2};

  double currencyConvert(double value, String from, String to) {
    double usdValue = value / rates[from]!;
    return usdValue * rates[to]!;
  }

  ///===================weight==========================
  final TextEditingController weightInputController = TextEditingController();
  String weightResult = "";
  String weightFromUnit = "Kilogram";
  String weightToUnit = "Gram";
  final weightUnits = ["Kilogram", "Gram", "Pound"];

  double weightConvert(double value, String from, String to) {
    Map<String, double> toKg = {"Kilogram": 1.0, "Gram": 0.001, "Pound": 0.453592};
    double valueInKg = value * toKg[from]!;
    return valueInKg / toKg[to]!;
  }

  ///===============for speed==========================
  final TextEditingController speedInputController = TextEditingController();
  String speedResult = "";
  String speedFromUnit = "m/s";
  String speedToUnit = "km/h";
  final speedUnits = ["m/s", "km/h", "mph", "ft/s"];

  double speedConvert(double value, String from, String to) {
    Map<String, double> toMps = {"m/s": 1.0, "km/h": 0.277778, "mph": 0.44704, "ft/s": 0.3048};
    double valueInMps = value * toMps[from]!;
    return valueInMps / toMps[to]!;
  }

  ///===============for light==========================
  final TextEditingController lightInputController = TextEditingController();
  String lightResult = "";
  String lightFromUnit = "Candela";
  String lightToUnit = "Lumen";
  final lightUnits = ["Candela", "Lumen", "Lux"];

  double lightConvert(double value, String from, String to) {
    Map<String, double> toCandela = {"Candela": 1.0, "Lumen": 1 / (4 * 3.1416), "Lux": 0.0001};
    double valueInCd = value * toCandela[from]!;
    return valueInCd / toCandela[to]!;
  }

  ///===============for volume==========================
  final TextEditingController volumeInputController = TextEditingController();
  String volumeResult = "";
  String volumeFromUnit = "Liter";
  String volumeToUnit = "Milliliter";
  final volumeUnits = ["Liter", "Milliliter", "Cubic Meter", "Gallon"];

  double volumeConvert(double value, String from, String to) {
    Map<String, double> toLiters = {"Liter": 1.0, "Milliliter": 0.001, "Cubic Meter": 1000.0, "Gallon": 3.78541};
    double valueInLiters = value * toLiters[from]!;
    return valueInLiters / toLiters[to]!;
  }

  ///===============for area==========================
  final TextEditingController areaInputController = TextEditingController();
  String areaResult = "";
  String areaFromUnit = "Square Meter";
  String areaToUnit = "Square Kilometer";
  final areaUnits = ["Square Meter", "Square Kilometer", "Hectare", "Acre"];

  double areaConvert(double value, String from, String to) {
    Map<String, double> toSqM = {"Square Meter": 1.0, "Square Kilometer": 1e6, "Hectare": 10000.0, "Acre": 4046.86};
    double valueInSqM = value * toSqM[from]!;
    return valueInSqM / toSqM[to]!;
  }

  ///===============for time==========================
  final TextEditingController timeInputController = TextEditingController();
  String timeResult = "";
  String timeFromUnit = "Second";
  String timeToUnit = "Minute";
  final timeUnits = ["Second", "Minute", "Hour", "Day"];

  double timeConvert(double value, String from, String to) {
    Map<String, double> toSeconds = {"Second": 1.0, "Minute": 60.0, "Hour": 3600.0, "Day": 86400.0};
    double valueInSec = value * toSeconds[from]!;
    return valueInSec / toSeconds[to]!;
  }

  ///===============for pressure==========================
  final TextEditingController pressureInputController = TextEditingController();
  String pressureResult = "";
  String pressureFromUnit = "Pascal";
  String pressureToUnit = "Bar";
  final pressureUnits = ["Pascal", "Bar", "PSI", "Atmosphere"];

  double pressureConvert(double value, String from, String to) {
    Map<String, double> toPascal = {"Pascal": 1.0, "Bar": 100000.0, "PSI": 6894.76, "Atmosphere": 101325.0};
    double valueInPa = value * toPascal[from]!;
    return valueInPa / toPascal[to]!;
  }

  ///==================== Electricity ===================
  final TextEditingController electricityInputController = TextEditingController();
  String electricityResult = "";
  String electricityFromUnit = "Volt";
  String electricityToUnit = "Volt";
  final electricityUnits = ["Volt", "MilliVolt", "kVolt", "Ampere"];

  double electricityConvert(double value, String from, String to) {
    Map<String, double> toVolt = {"Volt": 1.0, "MilliVolt": 0.001, "kVolt": 1000.0};
    double valueInVolt = (toVolt.containsKey(from)) ? value * toVolt[from]! : value;
    return (toVolt.containsKey(to)) ? valueInVolt / toVolt[to]! : valueInVolt;
  }

  ///==================== Fuel =========================
  final TextEditingController fuelInputController = TextEditingController();
  String fuelResult = "";
  String fuelFromUnit = "Liter";
  String fuelToUnit = "Gallon";
  final fuelUnits = ["Liter", "Milliliter", "Gallon", "Cubic Meter"];

  double fuelConvert(double value, String from, String to) {
    Map<String, double> toLiters = {"Liter": 1.0, "Milliliter": 0.001, "Gallon": 3.78541, "Cubic Meter": 1000.0};
    double valueInLiters = value * toLiters[from]!;
    return valueInLiters / toLiters[to]!;
  }

  ///==================== Data =========================
  final TextEditingController dataInputController = TextEditingController();
  String dataResult = "";
  String dataFromUnit = "Byte";
  String dataToUnit = "Kilobyte";
  final dataUnits = ["Bit", "Byte", "Kilobyte", "Megabyte", "Gigabyte"];

  double dataConvert(double value, String from, String to) {
    Map<String, double> toByte = {"Bit": 0.125, "Byte": 1.0, "Kilobyte": 1024.0, "Megabyte": 1048576.0, "Gigabyte": 1073741824.0};
    double valueInByte = value * toByte[from]!;
    return valueInByte / toByte[to]!;
  }

  ///==================== Angle ========================
  final TextEditingController angleInputController = TextEditingController();
  String angleResult = "";
  String angleFromUnit = "Degree";
  String angleToUnit = "Radian";
  final angleUnits = ["Degree", "Radian", "Gradian"];

  double angleConvert(double value, String from, String to) {
    Map<String, double> toDegree = {"Degree": 1.0, "Radian": 180.0 / 3.14159265359, "Gradian": 0.9};
    double valueInDegree = value * toDegree[from]!;
    return valueInDegree / toDegree[to]!;
  }

  ///==================== Sound ========================
  final TextEditingController soundInputController = TextEditingController();
  String soundResult = "";
  String soundFromUnit = "Decibel";
  String soundToUnit = "Decibel";
  final soundUnits = ["Decibel", "Sone", "Phon"];

  double soundConvert(double value, String from, String to) {
    Map<String, double> toDecibel = {"Decibel": 1.0, "Sone": 33.2, "Phon": 1.0};
    double valueInDb = value * toDecibel[from]!;
    return valueInDb / toDecibel[to]!;
  }

  ///==================== Frequency ====================
  final TextEditingController freqInputController = TextEditingController();
  String freqResult = "";
  String freqFromUnit = "Hertz";
  String freqToUnit = "Kilohertz";
  final freqUnits = ["Hertz", "Kilohertz", "Megahertz"];

  double freqConvert(double value, String from, String to) {
    Map<String, double> toHz = {"Hertz": 1.0, "Kilohertz": 1000.0, "Megahertz": 1000000.0};
    double valueInHz = value * toHz[from]!;
    return valueInHz / toHz[to]!;
  }

  ///==================== History ====================
  void saveHistory(String category, String input, String output) async {
    final prefs = widget.prefs;
    // Changed to use 'history' as the key instead of the specific category name.
    final hist = prefs.getStringList('history') ?? [];
    hist.insert(0, "${DateTime.now().toIso8601String()}|$category|$input|$output");
    // Increased the limit to 20 items.
    if (hist.length > 20) hist.removeLast();
    await prefs.setStringList('history', hist);
  }

  List<String> getHistory(String category) {
    return widget.prefs.getStringList(category) ?? [];
  }

  ///==================== Build ====================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.category.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// Length
              if (widget.category.title == 'Length') ...[
                _converterUI(lengthInputController, lengthUnits, lengthFromUnit, lengthToUnit,
                        (val)=>setState(()=>lengthFromUnit=val!),
                        (val)=>setState(()=>lengthToUnit=val!),
                        (){
                      double input = double.tryParse(lengthInputController.text)??0;
                      double output = lengthConvert(input, lengthFromUnit, lengthToUnit);
                      setState(()=>lengthResult="$output $lengthToUnit");
                      saveHistory('Length', input.toString(), lengthResult);
                    }, lengthResult),
              ]

              /// Temperature
              else if (widget.category.title=='Temperature') ...[
                _converterUI(temperatureInputController, temperatureUnits, temperatureFromUnit, temperatureToUnit,
                        (val)=>setState(()=>temperatureFromUnit=val!),
                        (val)=>setState(()=>temperatureToUnit=val!),
                        (){
                      double input = double.tryParse(temperatureInputController.text)??0;
                      double output = temperatureConvert(input, temperatureFromUnit, temperatureToUnit);
                      setState(()=>temperatureResult="$output $temperatureToUnit");
                      saveHistory('Temperature', input.toString(), temperatureResult);
                    }, temperatureResult),
              ]

              /// Currency
              else if (widget.category.title=='Currency') ...[
                  _converterUI(currencyInputController, currencyUnits, currencyFromUnit, currencyToUnit,
                          (val)=>setState(()=>currencyFromUnit=val!),
                          (val)=>setState(()=>currencyToUnit=val!),
                          (){
                        double input = double.tryParse(currencyInputController.text)??0;
                        double output = currencyConvert(input, currencyFromUnit, currencyToUnit);
                        setState(()=>currencyResult="$output $currencyToUnit");
                        saveHistory('Currency', input.toString(), currencyResult);
                      }, currencyResult),
                ]

                /// Weight
                else if (widget.category.title=='Weight') ...[
                    _converterUI(weightInputController, weightUnits, weightFromUnit, weightToUnit,
                            (val)=>setState(()=>weightFromUnit=val!),
                            (val)=>setState(()=>weightToUnit=val!),
                            (){
                          double input = double.tryParse(weightInputController.text)??0;
                          double output = weightConvert(input, weightFromUnit, weightToUnit);
                          setState(()=>weightResult="$output $weightToUnit");
                          saveHistory('Weight', input.toString(), weightResult);
                        }, weightResult),
                  ]

                  /// Speed
                  else if (widget.category.title=='Speed') ...[
                      _converterUI(speedInputController, speedUnits, speedFromUnit, speedToUnit,
                              (val)=>setState(()=>speedFromUnit=val!),
                              (val)=>setState(()=>speedToUnit=val!),
                              (){
                            double input = double.tryParse(speedInputController.text)??0;
                            double output = speedConvert(input, speedFromUnit, speedToUnit);
                            setState(()=>speedResult="$output $speedToUnit");
                            saveHistory('Speed', input.toString(), speedResult);
                          }, speedResult),
                    ]

                    /// Light
                    else if (widget.category.title=='Light') ...[
                        _converterUI(lightInputController, lightUnits, lightFromUnit, lightToUnit,
                                (val)=>setState(()=>lightFromUnit=val!),
                                (val)=>setState(()=>lightToUnit=val!),
                                (){
                              double input = double.tryParse(lightInputController.text)??0;
                              double output = lightConvert(input, lightFromUnit, lightToUnit);
                              setState(()=>lightResult="$output $lightToUnit");
                              saveHistory('Light', input.toString(), lightResult);
                            }, lightResult),
                      ]

                      /// Volume
                      else if (widget.category.title=='Volume') ...[
                          _converterUI(volumeInputController, volumeUnits, volumeFromUnit, volumeToUnit,
                                  (val)=>setState(()=>volumeFromUnit=val!),
                                  (val)=>setState(()=>volumeToUnit=val!),
                                  (){
                                double input = double.tryParse(volumeInputController.text)??0;
                                double output = volumeConvert(input, volumeFromUnit, volumeToUnit);
                                setState(()=>volumeResult="$output $volumeToUnit");
                                saveHistory('Volume', input.toString(), volumeResult);
                              }, volumeResult),
                        ]

                        /// Area
                        else if (widget.category.title=='Area') ...[
                            _converterUI(areaInputController, areaUnits, areaFromUnit, areaToUnit,
                                    (val)=>setState(()=>areaFromUnit=val!),
                                    (val)=>setState(()=>areaToUnit=val!),
                                    (){
                                  double input = double.tryParse(areaInputController.text)??0;
                                  double output = areaConvert(input, areaFromUnit, areaToUnit);
                                  setState(()=>areaResult="$output $areaToUnit");
                                  saveHistory('Area', input.toString(), areaResult);
                                }, areaResult),
                          ]

                          /// Time
                          else if (widget.category.title=='Time') ...[
                              _converterUI(timeInputController, timeUnits, timeFromUnit, timeToUnit,
                                      (val)=>setState(()=>timeFromUnit=val!),
                                      (val)=>setState(()=>timeToUnit=val!),
                                      (){
                                    double input = double.tryParse(timeInputController.text)??0;
                                    double output = timeConvert(input, timeFromUnit, timeToUnit);
                                    setState(()=>timeResult="$output $timeToUnit");
                                    saveHistory('Time', input.toString(), timeResult);
                                  }, timeResult),
                            ]

                            /// Pressure
                            else if (widget.category.title=='Pressure') ...[
                                _converterUI(pressureInputController, pressureUnits, pressureFromUnit, pressureToUnit,
                                        (val)=>setState(()=>pressureFromUnit=val!),
                                        (val)=>setState(()=>pressureToUnit=val!),
                                        (){
                                      double input = double.tryParse(pressureInputController.text)??0;
                                      double output = pressureConvert(input, pressureFromUnit, pressureToUnit);
                                      setState(()=>pressureResult="$output $pressureToUnit");
                                      saveHistory('Pressure', input.toString(), pressureResult);
                                    }, pressureResult),
                              ]

                              /// Electricity
                              else if (widget.category.title=='Electricity') ...[
                                  _converterUI(electricityInputController, electricityUnits, electricityFromUnit, electricityToUnit,
                                          (val)=>setState(()=>electricityFromUnit=val!),
                                          (val)=>setState(()=>electricityToUnit=val!),
                                          (){
                                        double input = double.tryParse(electricityInputController.text)??0;
                                        double output = electricityConvert(input, electricityFromUnit, electricityToUnit);
                                        setState(()=>electricityResult="$output $electricityToUnit");
                                        saveHistory('Electricity', input.toString(), electricityResult);
                                      }, electricityResult),
                                ]

                                /// Fuel
                                else if (widget.category.title=='Fuel') ...[
                                    _converterUI(fuelInputController, fuelUnits, fuelFromUnit, fuelToUnit,
                                            (val)=>setState(()=>fuelFromUnit=val!),
                                            (val)=>setState(()=>fuelToUnit=val!),
                                            (){
                                          double input = double.tryParse(fuelInputController.text)??0;
                                          double output = fuelConvert(input, fuelFromUnit, fuelToUnit);
                                          setState(()=>fuelResult="$output $fuelToUnit");
                                          saveHistory('Fuel', input.toString(), fuelResult);
                                        }, fuelResult),
                                  ]

                                  /// Data
                                  else if (widget.category.title=='Data') ...[
                                      _converterUI(dataInputController, dataUnits, dataFromUnit, dataToUnit,
                                              (val)=>setState(()=>dataFromUnit=val!),
                                              (val)=>setState(()=>dataToUnit=val!),
                                              (){
                                            double input = double.tryParse(dataInputController.text)??0;
                                            double output = dataConvert(input, dataFromUnit, dataToUnit);
                                            setState(()=>dataResult="$output $dataToUnit");
                                            saveHistory('Data', input.toString(), dataResult);
                                          }, dataResult),
                                    ]

                                    /// Angle
                                    else if (widget.category.title=='Angle') ...[
                                        _converterUI(angleInputController, angleUnits, angleFromUnit, angleToUnit,
                                                (val)=>setState(()=>angleFromUnit=val!),
                                                (val)=>setState(()=>angleToUnit=val!),
                                                (){
                                              double input = double.tryParse(angleInputController.text)??0;
                                              double output = angleConvert(input, angleFromUnit, angleToUnit);
                                              setState(()=>angleResult="$output $angleToUnit");
                                              saveHistory('Angle', input.toString(), angleResult);
                                            }, angleResult),
                                      ]

                                      /// Sound
                                      else if (widget.category.title=='Sound') ...[
                                          _converterUI(soundInputController, soundUnits, soundFromUnit, soundToUnit,
                                                  (val)=>setState(()=>soundFromUnit=val!),
                                                  (val)=>setState(()=>soundToUnit=val!),
                                                  (){
                                                double input = double.tryParse(soundInputController.text)??0;
                                                double output = soundConvert(input, soundFromUnit, soundToUnit);
                                                setState(()=>soundResult="$output $soundToUnit");
                                                saveHistory('Sound', input.toString(), soundResult);
                                              }, soundResult),
                                        ]

                                        /// Frequency
                                        else if (widget.category.title=='Frequency') ...[
                                            _converterUI(freqInputController, freqUnits, freqFromUnit, freqToUnit,
                                                    (val)=>setState(()=>freqFromUnit=val!),
                                                    (val)=>setState(()=>freqToUnit=val!),
                                                    (){
                                                  double input = double.tryParse(freqInputController.text)??0;
                                                  double output = freqConvert(input, freqFromUnit, freqToUnit);
                                                  setState(()=>freqResult="$output $freqToUnit");
                                                  saveHistory('Frequency', input.toString(), freqResult);
                                                }, freqResult),
                                          ]

            ],
          ),
        ),
      ),
    );
  }


  Widget _converterUI(
      TextEditingController controller,
      List<String> units,
      String from,
      String to,
      Function(String?) onFromChanged,
      Function(String?) onToChanged,
      VoidCallback onConvert,
      String output) {
    return Column(
      children: [
        TextField(
          controller: controller,
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
              value: from,
              items: units.map((u) => DropdownMenuItem(value: u, child: Text(u))).toList(),
              onChanged: onFromChanged,
            ),
            const Icon(Icons.arrow_forward),
            DropdownButton<String>(
              value: to,
              items: units.map((u) => DropdownMenuItem(value: u, child: Text(u))).toList(),
              onChanged: onToChanged,
            ),
          ],
        ),
        const SizedBox(height: 20),
        ElevatedButton(onPressed: onConvert, child: const Text("Convert")),
        const SizedBox(height: 20),
        Text(
          output,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
