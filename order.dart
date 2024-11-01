// Class for Order
import 'dart:io';
import 'menu.dart';
import 'tableReservation.dart';

// Enumeration for Payment Status
enum PaymentStatus { paid, unpaid }

// Enumeration for Order Status
enum OrderStatus { pending, completed }

class Order {
  List<String> items = [];
  double foodPrice = 0.0;
  double buffetPrice = 0.0;
  double totalPrice = 0.0;
  Reservation reservation;
  OrderStatus orderStatus = OrderStatus.pending;
  PaymentStatus paymentStatus = PaymentStatus.unpaid;

  // Constructor to accept a Reservation instance
  Order(this.reservation);

  void calculateTotal(Menu menu) {
    foodPrice = items.fold(0, (sum, item) => sum + (menu.getPrice(item) ?? 0.0));
    buffetPrice = reservation.amountofPeople * 10; 
    totalPrice = foodPrice + buffetPrice;
  }

   void modifyOrder(Menu menu) {
    while (true) {
      print("\nType 'add.item name' or 'remove. item name' \nPress Enter to exit.");
      stdout.write("Please enter what your order: ");
      String? input = stdin.readLineSync();

      // Exit if no input is given
      if (input == null || input.trim().isEmpty) {
        print("Exiting item modification.");
        break;
      }

      if (input.startsWith("add.")) {
        String itemToAdd = input.substring(4);
        if (menu.getPrice(itemToAdd) != null) {
          items.add(itemToAdd);
          print("$itemToAdd has been added to your order.");
        } else {
          print("Item '$itemToAdd' is not available on the menu.");
        }
      } else if (input.startsWith("remove.")) {
        String itemToRemove = input.substring(7);
        if (items.contains(itemToRemove)) {
          items.remove(itemToRemove);
          print("$itemToRemove has been removed from your order.");
        } else {
          print("Item '$itemToRemove' is not in your order.");
        }
      } else {
        print("Invalid command. Please use 'add.<item>' or 'remove.<item>'.");
      }
    }
  }


  void paymentProcess() {
    stdout.write("Would you like to process the payment? (yes/no): ");
    String input = stdin.readLineSync() ?? '';
      
    if (input.toLowerCase() == 'yes') {
      processPayment(PaymentStatus.paid);
      updateStatus(OrderStatus.completed);
      print("Payment processed.");
    } else {
      print("Payment not processed.");
    }

    print("Order Status: $orderStatus");
    print("Payment Status: $paymentStatus");
  }

  void updateStatus(OrderStatus status) {
    orderStatus = status;
  }

  void processPayment(PaymentStatus payment) {
    paymentStatus = payment;
  }

  void showReceipt(Menu menu) {
    print('Receipt');
    print('Customer Name: ${reservation.name}');
    print('Table Number: ${reservation.tableNum}');
    print('Reservation Time: ${reservation.startTime} to ${reservation.endTime}');
    
    items.forEach((item) {
      double? itemPrice = menu.getPrice(item);
      print('Item: $item, Price: \$${itemPrice != null ? itemPrice.toStringAsFixed(2) : 'N/A'}');
    });
    print('Amount for ${reservation.amountofPeople} people: \$${buffetPrice.toStringAsFixed(2)}');
    print('Total: \$${totalPrice.toStringAsFixed(2)}');
  }
}