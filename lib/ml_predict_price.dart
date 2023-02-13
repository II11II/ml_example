import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:ml_algo/ml_algo.dart';
// ignore: depend_on_referenced_packages
import 'package:ml_dataframe/ml_dataframe.dart';

void predictPrice({required int room, required num distance}) async {
  // The goal of our linear regression model will be to predict
  // home values based on the number of rooms a home has and
  // the distance to employment centers.

  // We have 3 types of data:
  // Rooms= The number of the rooms in home (independent value)
  // Distance= The distance to employment centers (independent value)
  // Value= The cost of the room (the cost is in K f.e 50 = 50k = 50000) (dependent value)
  final file = File('assets/prices.csv');
  final rawContent = await file.readAsString();
  final dataFrame = DataFrame.fromRawCsv(rawContent);
  var lR = LinearRegressor(dataFrame, 'Value');
  var prediction = lR.predict(DataFrame.fromSeries([
    Series('Rooms', [room]),
    Series('Distance', [distance]),
  ]));
  double predictedValue = prediction.series.first.data.first;

  print("Estimated prize is : ${predictedValue.toStringAsPrecision(4)}K");
}
