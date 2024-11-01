// Class Table Reservation
// Class Table Reservation
import 'dart:io';
import 'menu.dart';
import 'order.dart';
import 'tableReservation.dart';

class RestaurantSys {
  List<Order> orders = [];
  List<Reservation> reservations = [];
  int totalTables = 10; // Total number of tables in the restaurant
  Duration reservationDuration = Duration(hours: 1, minutes: 30);

  void createOrder(Menu menu, RestaurantSys restaurantsystem) {
    // Display available reservations
    restaurantsystem.viewReservations();
    stdout.write("Select a reservation number to place an order: ");
    int? reservationChoice = int.tryParse(stdin.readLineSync() ?? '');

    if (reservationChoice != null && reservationChoice > 0 && reservationChoice <= restaurantsystem.reservations.length) {
      Reservation selectedReservation = restaurantsystem.reservations[reservationChoice - 1];
      Order order = Order(selectedReservation);

      // Loop to add/remove items or finish order
      while (true) {
        print("\nOptions:");
        print("1. Order");
        print("2. Done");
        
        stdout.write("Choose an option: ");
        String? option = stdin.readLineSync();

        switch (option) {
          case "1": // Add an item
            order.modifyOrder(menu);
            break;

          case "2": // Finish the order
            print("Finishing your order...");
            order.calculateTotal(menu);
            restaurantsystem.placeOrder(order);
            order.showReceipt(menu);
            order.paymentProcess();
            return; // Exit the ordering loop

          default:
            print("Invalid option. Please choose a valid option.");
            break;
        }
      }
    } else {
      print("Invalid reservation selection.");
    }
  }
  
  void placeOrder(Order order) {
    orders.add(order);
  }

  void removeOrder(Order order) {
    orders.remove(order);
  }

  void addReservation() {
    stdout.write("Enter name for reservation: ");
    String name = stdin.readLineSync() ?? '';

    stdout.write("Enter reservation time (HH:mm format, e.g., 8:30PM): ");
    String? timeInput = stdin.readLineSync();
    DateTime? startTime = _parseTime(timeInput);

    if (startTime == null) {
      print("\nInvalid time format. Please use HH:mm format.\n");
      return;
    }

    DateTime endTime = startTime.add(reservationDuration);

    stdout.write("Enter the amount of people: ");
    int? amountofPeople = int.tryParse(stdin.readLineSync() ?? '');

    stdout.write("Enter table number (1 - $totalTables): ");
    int? tableNum = int.tryParse(stdin.readLineSync() ?? '');

    if (amountofPeople != null && tableNum != null && tableNum > 0 && tableNum <= totalTables) {
      if (_isTableAvailable(tableNum, startTime, endTime)) {
        reservations.add(Reservation(name, startTime, endTime, amountofPeople, tableNum));
        print("\nReservation for $name at ${_formatTime(startTime)} for $amountofPeople people at table $tableNum has been added.\n");
      } else {
        print("\nTable $tableNum is not available at this time. Please choose a different time or table.\n");
      }
    } else {
      print("\nInvalid input. Please enter valid details.\n");
    }
  }

  DateTime? _parseTime(String? timeInput) {
    try {
      if (timeInput == null) return null;
      List<String> parts = timeInput.split(":");
      int hour = int.parse(parts[0]);
      int minute = int.parse(parts[1]);
      DateTime now = DateTime.now();
      return DateTime(now.year, now.month, now.day, hour, minute);
    } catch (e) {
      return null;
    }
  }

  String _formatTime(DateTime time) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
  }

  bool _isTableAvailable(int tableNum, DateTime startTime, DateTime endTime) {
    for (var reservation in reservations) {
      if (reservation.tableNum == tableNum) {
        bool overlaps = startTime.isBefore(reservation.endTime) && endTime.isAfter(reservation.startTime);
        if (overlaps) return false;
      }
    }
    return true;
  }

  void viewReservations() {
    if (reservations.isEmpty) {
      print("\nNo reservations found.\n");
    } else {
      print("\nCurrent Reservations:");
      for (int i = 0; i < reservations.length; i++) {
        Reservation reservation = reservations[i];
        print(
          "${i + 1}. Name: ${reservation.name}, Time: ${_formatTime(reservation.startTime)} - ${_formatTime(reservation.endTime)}, "
          "Number of People: ${reservation.amountofPeople}, Table: ${reservation.tableNum}"
        );
      }
      print("");
    }
  }

  void viewTables() {
    print("\nTable Status:");
    for (int i = 1; i <= totalTables; i++) {
      bool tableAvailable = true;
      for (var reservation in reservations) {
        if (reservation.tableNum == i) {
          tableAvailable = false;
          print("Table $i: Reserved from ${_formatTime(reservation.startTime)} to ${_formatTime(reservation.endTime)}");
          break;
        }
      }
      if (tableAvailable) {
        print("Table $i: Available");
      }
    }
    print("");
  }

  void cancelReservation() {
    viewReservations();
    stdout.write("Enter the reservation number to cancel: ");
    int? reservationNum = int.tryParse(stdin.readLineSync() ?? '');

    if (reservationNum != null && reservationNum > 0 && reservationNum <= reservations.length) {
      Reservation cancelledReservation = reservations.removeAt(reservationNum - 1);
      print("\nReservation for ${cancelledReservation.name} at table ${cancelledReservation.tableNum} has been canceled.\n");
    } else {
      print("\nInvalid reservation number.\n");
    }
  }
}