import 'menu.dart';
import 'Reservation.dart';

// Enumeration for Payment Status
enum PaymentStatus { paid, unpaid }

// Enumeration for Order Status
enum OrderStatus { pending, completed }

// Class for Order
class Order {
  List<String> items = [];
  double foodPrice = 0.0;
  double buffetPrice = 0.0;
  double totalPrice = 0.0;
  // Reservation amountofPeople;
  OrderStatus orderStatus = OrderStatus.pending;
  PaymentStatus paymentStatus = PaymentStatus.unpaid;

  // Order(this.amountofPeople);

  void calculateTotal(Menu menu) {
    foodPrice =
        items.fold(0, (sum, item) => sum + (menu.getPrice(item) ?? 0.0));
    // buffetPrice = amountofPeople * 10;
    totalPrice = foodPrice;
  }

  void updateStatus(OrderStatus status) {
    orderStatus = status;
  }

  void processPayment(PaymentStatus payment) {
    paymentStatus = payment;
  }

  void showReceipt(Menu menu) {
    print('Receipt');
    // print Customer name
    // print Customer table
    // print time
    items.forEach((item) {
      double? itemPrice = menu.getPrice(item);
      print(
          'Item: $item, Price: \$${itemPrice != null ? itemPrice.toStringAsFixed(2) : 'N/A'}');
    });
    // print('Amount ${amountofPeople}: \$${buffetPrice.toStringAsFixed(2)}');
    print('Total: \$${(totalPrice).toStringAsFixed(2)}');
  }
}