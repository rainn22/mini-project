// Class for Customer
import 'order.dart';

class Customer {
  String name;
  String phoneNum;
  List<Order> orders = [];
  // List<TableReservation> reservations = [];

  Customer({required this.name, required this.phoneNum});

  void placeOrder(Order order) {
    orders.add(order);
  }

  void removeOrder(Order order) {
    orders.remove(order);
  }
}