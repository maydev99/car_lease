import 'package:flutter/material.dart';
import 'package:layout/car_data.dart';
import 'package:layout/database/database.dart';
import 'package:logger/logger.dart';

class Calculator extends StatelessWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppTitle',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  var log = Logger();
  late AppDatabase appDatabase;
 // var $FloorAppDatabase;

  @override
  void initState() {
    super.initState();
  }

  final monthsController = TextEditingController();
  final totalMilesController = TextEditingController();
  final dueAtSigningController = TextEditingController();
  final monthlyPaymentController = TextEditingController();
  final carModelController = TextEditingController();

  double months = 0.0;
  double totalMiles = 0.0;
  double dueAtSigning = 0.0;
  double monthlyPayment = 0.0;

  double totalPrice = 0.0;

  String totalPricePerMonthStr = "0";
  String pricePerMileStr = "0";
  String carModel = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Car Lease'),
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              carModel = carModelController.text.toString();
              var newCarData = CarData(
                  months: months.toString(),
                  totalMiles: totalMiles.toString(),
                  dueAtSigning: dueAtSigning.toString(),
                  monthlyPayment: monthlyPayment.toString(),
                  carModel: carModel,
                  totalPrice: totalPrice.toString(),
                  totalPricePerMonthStr: totalPricePerMonthStr,
                  pricePerMileStr: pricePerMileStr);
              final database = await $FloorAppDatabase.databaseBuilder('database.db').build();
              final carDao = database.carDataDao;
              carDao.insertCarData(newCarData);


              makeASnackBar('Saved', context);

              //save();
            },
            icon: const Icon(Icons.save),
            tooltip: 'Save',
          ),
          IconButton(
            onPressed: () {
              calculateResults();
            },
            icon: const Icon(Icons.auto_fix_high),
            tooltip: 'Calculate',
          )
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 16, bottom: 8.0, right: 8.0, left: 8.0),
            child: TextField(
              controller: monthsController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Months'),
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: totalMilesController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Total Miles'),
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: dueAtSigningController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Due at Signing'),
              keyboardType: TextInputType.number,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: monthlyPaymentController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Monthly Payment'),
              keyboardType: TextInputType.number,
            ),
          ),
          //Result Card
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: carModelController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Car Model'),
              keyboardType: TextInputType.text,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 10,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Total Price: \$$totalPrice',
                        style:
                            const TextStyle(fontSize: 18, color: Colors.blue),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Total Price/Month: \$$totalPricePerMonthStr',
                        style:
                            const TextStyle(fontSize: 18, color: Colors.blue),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Price/ Mile: \$$pricePerMileStr',
                        style:
                            const TextStyle(fontSize: 18, color: Colors.blue),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void calculateResults() {
    months = double.parse(monthsController.text);
    totalMiles = double.parse(totalMilesController.text);
    dueAtSigning = double.parse(dueAtSigningController.text);
    monthlyPayment = double.parse(monthlyPaymentController.text);

    setState(() {
      totalPrice = ((months * monthlyPayment) + dueAtSigning);
      totalPricePerMonthStr = (totalPrice / months).toStringAsFixed(2);
      pricePerMileStr = (totalPrice / totalMiles).toStringAsFixed(2);
    });
  }

  void makeASnackBar(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 300),
      ),
    );
  }
}
