import 'package:skarbonka/model/expense.dart';

class MockedExpenses {
  static List<Expense> build() {
    return [
      //SIERPIEN
      Expense(name: "Mieszkanie", value: 1000.0, date: DateTime(2020, 8, 1), categoryId: 0),
      Expense(name: "Karnet na siłownie", value: 50.0, date: DateTime(2020, 8, 1), categoryId: 0),
      Expense(name: "Catering", value: 800.0, date: DateTime(2020, 8, 1), categoryId: 0),

      Expense(name: "Cyberpunk 2077", value: 219.0, date: DateTime(2020, 8, 10), categoryId: 5),
      Expense(name: "Kurtka ziomowa", value: 200.0, date: DateTime(2020, 8, 15), categoryId: 4),
      Expense(name: "Buty zimowe", value: 230.0, date: DateTime(2020, 8, 16), categoryId: 4),
      Expense(name: "Spodnie zimowe", value: 300.0, date: DateTime(2020, 8, 12), categoryId: 4),
      Expense(name: "Chińczyk", value: 20.0, date: DateTime(2020, 8, 17), categoryId: 2),
      Expense(name: "Chińczyk", value: 20.0, date: DateTime(2020, 8, 19), categoryId: 2),
      Expense(name: "Chińczyk", value: 20.0, date: DateTime(2020, 8, 2), categoryId: 2),
      Expense(name: "Thai Wok", value: 40.0, date: DateTime(2020, 8, 18), categoryId: 2),
      Expense(name: "Thai Wok", value: 40.0, date: DateTime(2020, 8, 5), categoryId: 2),
      Expense(name: "Zegarek", value: 500.0, date: DateTime(2020, 8, 22), categoryId: 3),
      Expense(name: "Pizza", value: 40.0, date: DateTime(2020, 8, 25), categoryId: 3),

      //WRZESIEN
      Expense(name: "Mieszkanie", value: 1000.0, date: DateTime(2020, 9, 1), categoryId: 0),
      Expense(name: "Karnet na siłownie", value: 50.0, date: DateTime(2020, 9, 1), categoryId: 0),
      Expense(name: "Catering", value: 800.0, date: DateTime(2020, 9, 1), categoryId: 0),

      Expense(name: "GhostRunner", value: 100.0, date: DateTime(2020, 9, 10), categoryId: 5),
      Expense(name: "Chińczyk", value: 20.0, date: DateTime(2020, 9, 17), categoryId: 2),
      Expense(name: "Chińczyk", value: 20.0, date: DateTime(2020, 9, 19), categoryId: 2),
      Expense(name: "Chińczyk", value: 20.0, date: DateTime(2020, 9, 2), categoryId: 2),
      Expense(name: "Thai Wok", value: 40.0, date: DateTime(2020, 9, 18), categoryId: 2),
      Expense(name: "Thai Wok", value: 40.0, date: DateTime(2020, 9, 5), categoryId: 2),
      Expense(name: "Naszyjnik", value: 400.0, date: DateTime(2020, 9, 22), categoryId: 3),
      Expense(name: "Pizza", value: 40.0, date: DateTime(2020, 9, 25), categoryId: 3),

      //PAZDIERNIK
      Expense(name: "Mieszkanie", value: 1000.0, date: DateTime(2020, 10, 1), categoryId: 0),
      Expense(name: "Karnet na siłownie", value: 50.0, date: DateTime(2020, 10, 1), categoryId: 0),

      Expense(name: "Chińczyk", value: 20.0, date: DateTime(2020, 10, 17), categoryId: 2),
      Expense(name: "Chińczyk", value: 20.0, date: DateTime(2020, 10, 19), categoryId: 2),
      Expense(name: "Chińczyk", value: 20.0, date: DateTime(2020, 10, 2), categoryId: 2),
      Expense(name: "Thai Wok", value: 40.0, date: DateTime(2020, 10, 18), categoryId: 2),
      Expense(name: "Thai Wok", value: 40.0, date: DateTime(2020, 10, 5), categoryId: 2),
      Expense(name: "Burger", value: 45.0, date: DateTime(2020, 10, 8), categoryId: 2),
      Expense(name: "Burger", value: 50.0, date: DateTime(2020, 10, 11), categoryId: 2),
      Expense(name: "Pierścionek", value: 1400.0, date: DateTime(2020, 10, 22), categoryId: 3),
      Expense(name: "Brylant", value: 600.0, date: DateTime(2020, 10, 22), categoryId: 3),
      Expense(name: "Pizza", value: 40.0, date: DateTime(2020, 10, 26), categoryId: 2),
      Expense(name: "Pizza", value: 45.0, date: DateTime(2020, 10, 25), categoryId: 2),
      Expense(name: "Pizza", value: 60.0, date: DateTime(2020, 10, 28), categoryId: 2),
      Expense(name: "Zakupy Auchan", value: 300.0, date: DateTime(2020, 10, 28), categoryId: 1),
      Expense(name: "Zakupy Mediamarkt", value: 300.0, date: DateTime(2020, 10, 5), categoryId: 1),
      Expense(name: "Zakupy Arkadia", value: 400.0, date: DateTime(2020, 10, 3), categoryId: 1),
      Expense(name: "Zakupy Arkadia", value: 400.0, date: DateTime(2020, 10, 20), categoryId: 1),

      //LISTOPAD
      Expense(name: "Mieszkanie", value: 1000.0, date: DateTime(2020, 11, 1), categoryId: 0),
      Expense(name: "Karnet na siłownie", value: 50.0, date: DateTime(2020, 11, 1), categoryId: 0),

      Expense(name: "Chińczyk", value: 20.0, date: DateTime(2020, 11, 17), categoryId: 2),
      Expense(name: "Chińczyk", value: 20.0, date: DateTime(2020, 11, 19), categoryId: 2),
      Expense(name: "Chińczyk", value: 20.0, date: DateTime(2020, 11, 2), categoryId: 2),
      Expense(name: "Thai Wok", value: 40.0, date: DateTime(2020, 11, 18), categoryId: 2),
      Expense(name: "Thai Wok", value: 40.0, date: DateTime(2020, 11, 5), categoryId: 2),
      Expense(name: "Burger", value: 45.0, date: DateTime(2020, 11, 8), categoryId: 2),
      Expense(name: "Burger", value: 50.0, date: DateTime(2020, 11, 11), categoryId: 2),
      Expense(name: "Pizza", value: 40.0, date: DateTime(2020, 11, 26), categoryId: 2),
      Expense(name: "Pizza", value: 45.0, date: DateTime(2020, 11, 25), categoryId: 2),
      Expense(name: "Pizza", value: 60.0, date: DateTime(2020, 11, 28), categoryId: 2),
      Expense(name: "Zakupy Auchan", value: 300.0, date: DateTime(2020, 11, 28), categoryId: 1),
      Expense(name: "Zakupy Mediamarkt", value: 300.0, date: DateTime(2020, 11, 5), categoryId: 1),
      Expense(name: "Zakupy Arkadia", value: 400.0, date: DateTime(2020, 11, 3), categoryId: 1),
      Expense(name: "Naszyjnik", value: 400.0, date: DateTime(2020, 11, 20), categoryId: 3),
    ];
  }
}