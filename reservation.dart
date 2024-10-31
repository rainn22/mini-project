import 'customer.dart';

// Enumeration for Reservation Status
enum ReserveStatus { available, reserved }

// Class Table Reservation
class Reservation {
  Customer customer;
  DateTime startTime;
  DateTime endTime;
  int amountofPeople;
  int tableNum;
  ReserveStatus status;

  Reservation(this.customer, this.startTime, this.endTime, this.amountofPeople, this.tableNum, this.status);
}