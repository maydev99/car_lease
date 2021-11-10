import 'package:floor/floor.dart';
import 'package:layout/car_data.dart';

@dao
abstract class CarDataDao{
  @Query('SELECT * FROM CarData')
  Stream<List<CarData>> getAllCarData();

  @Query('SELECT * FROM CarData WHERE id = :id')
  Stream<CarData?> getAllCarDataById(int id);

  @Query('DELETE FROM CarData')
  Future<void> deleteAllCarData();

  @insert
  Future<void> insertCarData(CarData carData);

  @update
  Future<void> updateCarData(CarData carData);

  @delete
  Future<void> deleteCarData(CarData carData);

}