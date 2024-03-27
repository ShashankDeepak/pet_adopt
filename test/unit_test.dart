import 'package:adopt_pet/view/history/history_functions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Check for proper date format is retured or not", () {
    DateTime date = DateTime(2024, 10, 5);
    String newDate = formatDate(date);
    expect(newDate, "05/10/2024");
  });
}
