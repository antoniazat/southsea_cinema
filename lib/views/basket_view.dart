import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/database/movie_db.dart';
import 'package:southsea_cinema/models/cart_item.dart';
import 'package:southsea_cinema/models/order_record.dart';
import 'package:southsea_cinema/repositories/cart_repository.dart';
import 'package:southsea_cinema/widgets/basket_button.dart';
import 'package:southsea_cinema/widgets/bookings_button.dart';
import 'package:southsea_cinema/widgets/primary_button.dart';

class BasketView extends StatefulWidget {
  const BasketView({super.key});

  @override
  State<BasketView> createState() => _BasketViewState();
}

class _BasketViewState extends State<BasketView> {
  String _confirmationMessage = '';

  String _buildSummary(List<CartItem> items) {
    final List<String> parts = [];
    for (final CartItem item in items) {
      parts.add('${item.ticketQuantity} x ${item.movie.title}');
    }
    return parts.join(', ');
  }

  String _formatDate(DateTime now) {
    final String day = now.day.toString().padLeft(2, '0');
    final String month = now.month.toString().padLeft(2, '0');
    final String hour = now.hour.toString().padLeft(2, '0');
    final String minute = now.minute.toString().padLeft(2, '0');
    return '$day/$month/${now.year} $hour:$minute';
  }

  Widget _buildEmptyState() {
    return const Center(
        child: Padding(
      padding: EdgeInsets.symmetric(vertical: 32.0),
      child: Text(
        'Your basket is empty',
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    ));
  }

  Future<void> _checkout(CartRepository cart, List<CartItem> items) async {
    final String summary = _buildSummary(items);
    final double total = cart.getTotalDue();
    final String date = _formatDate(DateTime.now());

    try {
      final MovieDatabase database = MovieDatabase.instance;
      final int orderNumber = await database.getNextOrderNumber();
      final OrderRecord record = OrderRecord(
        orderNumber: orderNumber,
        summary: summary,
        total: total,
        date: date,
      );

      await database.insertOrder(record);
      cart.clear();
      if (!mounted) {
        return;
      }
      setState(() {
        _confirmationMessage = 'Order $orderNumber saved';
      });
      Navigator.pushNamed(context, '/orders');
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _confirmationMessage = 'Could not save your order: $error';
      });
    }
  }

  Widget _buildLineItem(CartRepository cart, CartItem item, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${item.ticketQuantity} x ${item.movie.title}',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text('£${item.lineTotal.toStringAsFixed(2)}'),
            ],
          )),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: () {
              setState(() {
                cart.removeItem(index);
              });
            },
          )
        ],
      ),
    );
  }

  Widget _buildTotalRow(String label, String value, {bool emphasise = false}) {
    final TextStyle style;
    if (emphasise) {
      style = const TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
    } else {
      style = const TextStyle(color: cinemaSurface);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(value, style: style),
        ],
      ),
    );
  }

  Widget _buildBasketList(CartRepository cart, List<CartItem> items) {
    final List<Widget> children = [];

    children.add(const Text('Your basket', style: cinemaHeaderStyle));
    children.add(const SizedBox(height: 16));

    for (int index = 0; index < items.length; index++) {
      final CartItem item = items[index];
      children.add(_buildLineItem(cart, item, index));
    }

    children.add(const SizedBox(height: 24));
    children.add(
      _buildTotalRow(
        'Items subtotal',
        '£${cart.getSubtotal().toStringAsFixed(2)}',
      ),
    );
    children.add(
      _buildTotalRow(
        'Booking',
        '£${cart.getBookingFee().toStringAsFixed(2)}',
      ),
    );
    children.add(
      _buildTotalRow(
        'Total to pay',
        '£${cart.getTotalDue().toStringAsFixed(2)}',
        emphasise: true,
      ),
    );
    children.add(const SizedBox(height: 24));

    children.add(SizedBox(
      width: double.infinity,
      child: PrimaryButton(
        label: 'Checkout',
        onPressed: () {
          _checkout(cart, items);
        },
      ),
    ));

    if (_confirmationMessage.isNotEmpty) {
      children.add(const SizedBox(height: 12));
      children.add(
        Text(
          _confirmationMessage,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    final CartRepository cart = CartRepository.instance;
    final List<CartItem> items = cart.getItems();
    final Widget content;
    if (items.isEmpty) {
      if (_confirmationMessage.isNotEmpty) {
        content = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildEmptyState(),
            const SizedBox(height: 12),
            Text(_confirmationMessage,
                style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        );
      } else {
        content = _buildEmptyState();
      }
    } else {
      content = _buildBasketList(cart, items);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(appTitle, style: cinemaHeaderStyle),
        actions: [BookingsButton(), BasketButton()],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: content,
      ),
    );
  }
}
