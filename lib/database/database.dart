import 'package:floor/floor.dart';
import 'package:layout/car_dao.dart';
import 'package:layout/car_data.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';

part 'database.g.dart';

@Database(version:1, entities:[CarData])
abstract class AppDatabase extends FloorDatabase{
  CarDataDao get carDataDao;
}