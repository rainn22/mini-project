import 'dart:io';
import 'customer.dart';
import 'reservation.dart';

class ReservationSys {
  List<Reservation> reservations = [];
  int totalTables = 10; // Total number of tables in the restaurant
  Duration reservationDuration = Duration(hours: 1, minutes: 30);

  // Method to add a reservation for an existing customer
  void addReservation(Customer customer) {
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
        reservations.add(Reservation(customer, startTime, endTime, amountofPeople, tableNum, ReserveStatus.reserved));
        print("\nReservation for ${customer.name} at ${_formatTime(startTime)} for $amountofPeople people at table $tableNum has been added.\n");
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
          "${i + 1}. Name: ${reservation.customer.name}, Time: ${_formatTime(reservation.startTime)} - ${_formatTime(reservation.endTime)}, "
          "Number of People: ${reservation.amountofPeople}, Table: ${reservation.tableNum}"
        );
      }
      print("");
    }
  }


  void viewTables() {
    print("\nTable Status:");
    for (int i = 1; i <= totalTables; i++) {
      ReserveStatus status = ReserveStatus.available;
      for (var reservation in reservations) {
        if (reservation.tableNum == i && reservation.status == ReserveStatus.reserved) {
          status = ReserveStatus.reserved;
          print("Table $i: Reserved from ${_formatTime(reservation.startTime)} to ${_formatTime(reservation.endTime)}");
          break;
        }
      }
      if (status == ReserveStatus.available) {
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
      cancelledReservation.status = ReserveStatus.available;
      print("\nReservation for ${cancelledReservation.customer.name} at table ${cancelledReservation.tableNum} has been canceled.\n");
    } else {
      print("\nInvalid reservation number.\n");
    }
  }


  void run() {
    Customer? currentCustomer;

    while (true) {
      print("Welcome to our Restaurant :)");
      print("1. Create Account");
      print("2. Add Reservation");
      print("3. View Reservations");
      print("4. View Table Status");
      print("5. Cancel Reservation");
      print("6. Exit");

      stdout.write("Choose an option: ");
      String? choice = stdin.readLineSync();

      switch (choice) {
        case "1":
          // Create Customer
          stdout.write("Enter customer name: ");
          String customerName = stdin.readLineSync() ?? '';

          stdout.write("Enter customer phone number: ");
          String phoneNum = stdin.readLineSync() ?? '';

          currentCustomer = Customer(name: customerName, phoneNum: phoneNum);
          print("\nCustomer ${currentCustomer.name} has been created.\n");
          break;

        case "2":
          if (currentCustomer == null) {
            print("\nNo customer created. Please create a customer first.\n");
          } else {
            addReservation(currentCustomer);
          }
          break;

        case "3":
          viewReservations();
          break;

        case "4":
          viewTables();
          break;

        case "5":
          cancelReservation();
          break;

        case "6":
          print("Thank you Jub Jub!");
          return;

        default:
          print("\nInvalid option. Choose a valid option.\n");
          break;
      }
    }
  }
}