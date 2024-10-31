// import 'menu.dart';
// import 'order.dart';
import 'tableReservation.dart';

void main() {
  // Initialize the menu
  // Menu menu = Menu();
  // menu.addMenuItem("Pork", 0);
  // menu.addMenuItem("Crispy Chicken", 0);
  // menu.addMenuItem("USA Beef", 0);
  // menu.addMenuItem("Juicy Beef Ball", 0);
  // menu.addMenuItem("Dumpling", 0);
  // menu.addMenuItem("Duck blood", 0);
  // menu.addMenuItem("Mild Spicy soup", 0);
  // menu.addMenuItem("Tomato soup", 0);
  // menu.addMenuItem("Shichuan", 1.99);
  // menu.addMenuItem("Soda", 1.99);
  // menu.addMenuItem("Tea", 1.99);

  ReservationSys reservationSystem = ReservationSys();
  reservationSystem.run();

  // Customer places an order
  // menu.showMenu();
  // Order order1 = Order();
  // order1.items.addAll(["Pork", "Soda"]);
  // order1.items.addAll(["USA Beef"]);
  // order1.calculateTotal(menu);
  // customer.placeOrder(order1);
  // order1.showReceipt(menu);
  // // print("Order Total: \$${order1.totalPrice}");

  // // Processing payment and completing the order
  // order1.processPayment(PaymentStatus.paid);
  // order1.updateStatus(OrderStatus.completed);
  // print("Order Status: ${order1.orderStatus}");
  // print("Payment Status: ${order1.paymentStatus}");
}
