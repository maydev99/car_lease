import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:layout/car_data.dart';
import 'package:logger/logger.dart';

import 'database/database.dart';

class Saved extends StatelessWidget {
  const Saved({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppTitle',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SavedPage(),
    );
  }
}

class SavedPage extends StatefulWidget {
  const SavedPage({Key? key}) : super(key: key);

  @override
  _SavedPageState createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  var log = Logger();
  List<CarData> myList = [];


  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('database.db').build();
    var myDao = database.carDataDao;
    Stream<List<CarData>> myData = myDao.getAllCarData();
    myData.listen((value) {
      for (var item in value) {
        myList.add(CarData(
            months: item.months,
            totalMiles: item.totalMiles,
            dueAtSigning: item.dueAtSigning,
            monthlyPayment: item.monthlyPayment,
            carModel: item.carModel,
            totalPrice: item.totalPrice,
            totalPricePerMonthStr: item.totalPricePerMonthStr,
            pricePerMileStr: item.pricePerMileStr));
      }
    });
    log.i(myList.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved'),
        actions: [
          IconButton(onPressed: () async {
            makeASnackBar("Delete Not working yet", context);
          }, icon: const Icon(Icons.delete))
        ],
      ),
      body: ListView(
        children: List.generate(myList.length, (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: _myCard(myList, index),
          );
        }),
      ),
    );
  }

  Card _myCard(List<CarData> myList, int index) {
    return Card(
      color: Colors.white,
      elevation: 10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              myList[index].carModel,
              style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '${myList[index].months} months',
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '${myList[index].totalMiles} miles',
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '\$${myList[index].dueAtSigning} down',
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '\$${myList[index].monthlyPayment} per month',
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
            child: Text(
              '\$${myList[index].totalPrice} total lease',
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '\$${myList[index].totalPricePerMonthStr} total per month',
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 16.0),
            child: Text(
              '\$${myList[index].pricePerMileStr} per mile',
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.purple),
            ),
          )
        ],
      ),
    );
  }
}

void makeASnackBar(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(milliseconds: 1000),
    ),
  );
}
