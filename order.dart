// Class for Order
import 'main.dart';
import 'menu.dart';

class Order {
  List<String> items = [];
  double foodPrice = 0.0;
  double buffetPrice = 0.0;
  double totalPrice = 0.0;
  // call something that can get amount of people from TableReservation
  int amount = 2;
  OrderStatus orderStatus = OrderStatus.pending;
  PaymentStatus paymentStatus = PaymentStatus.unpaid;

  void calculateTotal(Menu menu) {
    foodPrice =
        items.fold(0, (sum, item) => sum + (menu.getPrice(item) ?? 0.0));
    buffetPrice = amount * 10;
    totalPrice = foodPrice + buffetPrice;
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
    print('Amount $amount: \$${buffetPrice.toStringAsFixed(2)}');
    print('Total: \$${(totalPrice).toStringAsFixed(2)}');
  }
}