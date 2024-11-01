import 'dart:io';
import 'menu.dart';
import 'rms.dart';

void main() {
  // Initialize the menu
  Menu menu = Menu();
  menu.addMenuItem("Pork", 0);
  menu.addMenuItem("Crispy Chicken", 0);
  menu.addMenuItem("USA Beef", 0);
  menu.addMenuItem("Juicy Beef Ball", 0);
  menu.addMenuItem("Dumpling", 0);
  menu.addMenuItem("Duck blood", 0);
  menu.addMenuItem("Mild Spicy soup", 0);
  menu.addMenuItem("Tomato soup", 0);
  menu.addMenuItem("Shichuan", 1.99);
  menu.addMenuItem("Soda", 1.99);
  menu.addMenuItem("Tea", 1.99);

  // Table Reservation
  RestaurantSys restaurantsystem = RestaurantSys();
  
  while (true) {
    print("Welcome to our Restaurant :)");
    print("1. Add Reservation");
    print("2. View Reservations");
    print("3. View Table Status");
    print("4. Cancel Reservation");
    print("5. Place an Order");
    print("6. Exit");

    stdout.write("Choose an option: ");
    String? choice = stdin.readLineSync();

    switch (choice) {
      case "1":
        restaurantsystem.addReservation();
        break;
      case "2":
        restaurantsystem.viewReservations();
        break;
      case "3":
        restaurantsystem.viewTables();
        break;
      case "4":
        restaurantsystem.cancelReservation();
        break;
      case "5":
        restaurantsystem.createOrder(menu, restaurantsystem);
        break;
      case "6":
        print("Thank you Jub Jub, Goodbye!");
        return;
      default:
        print("\nInvalid option. Choose a valid option.\n");
        break;
    }
  }
}