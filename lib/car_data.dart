import 'package:floor/floor.dart';

@entity
class CarData {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  String months,totalMiles,dueAtSigning,monthlyPayment,carModel,totalPrice,totalPricePerMonthStr,pricePerMileStr;

  CarData(
      {this.id,
      required this.months,
      required this.totalMiles,
      required this.dueAtSigning,
      required this.monthlyPayment,
      required this.carModel,
      required this.totalPrice,
      required this.totalPricePerMonthStr,
      required this.pricePerMileStr});
}
