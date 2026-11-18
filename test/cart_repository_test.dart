import 'package:flutter_test/flutter_test.dart';
import 'package:southsea_cinema/models/cart_item.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/repositories/cart_repository.dart';

const Movie testMovie1 = Movie(
  id: '1',
  title: 'Wildwood',
  ageRating: 'PG13',
  duration: '2h 10m',
  pricing: 10.99,
  synopsis:
      'After her baby brother is abducted by a murder of crows, headstrong teenager Prue McKeel launches a desperate rescue mission into an enchanted forest hidden just beyond Portland, Ore.',
  posterImagePath: 'assets/images/wildwood.jpg',
);

const Movie testMovie2 = Movie(
  id: '2',
  title: 'Wake Up Dead Man: A Knives Out Mystery',
  synopsis:
      'Detective Benoit Blanc heads to church to solve a perfectly impossible murder with help from a young priest.',
  ageRating: 'PG13',
  duration: '2h 26m',
  pricing: 10.99,
  posterImagePath: 'assets/images/wake-up-dead-man-a-knives-out-mystery.jpg',
);

void main() {
  setUp(() {
    CartRepository.instance.clear();
  });

  group('CartRepository tests', () {
    test('starts with empty basket and zero totals', () {
      final CartRepository cart = CartRepository.instance;
      expect(cart.getItems().length, 0);
      expect(cart.getTotalItems(), 0);
      expect(cart.totalItemCount, 0);
      expect(cart.getSubtotal(), 0.0);
      expect(cart.getBookingFee(), 0.0);
      expect(cart.getTotalDue(), 0.0);
    });

    test('adds items and calculates subtotal and booking fee correctly', () {
      final CartRepository cart = CartRepository.instance;
      const CartItem item1 = CartItem(
        movie: testMovie1,
        ticketQuantity: 2,
      );
      const CartItem item2 = CartItem(
        movie: testMovie2,
        ticketQuantity: 1,
      );

      cart.addItem(item1);
      cart.addItem(item2);

      expect(cart.getItems().length, 2);
      expect(cart.getTotalItems(), 3);
      expect(cart.totalItemCount, 3);
      expect(cart.getSubtotal(), 32.97);
      expect(cart.getBookingFee(), 1.50);
      expect(cart.getTotalDue(), 34.47);
    });

    test('removes items correctly', () {
      final CartRepository cart = CartRepository.instance;
      const CartItem item = CartItem(
        movie: testMovie1,
        ticketQuantity: 1,
      );
      cart.addItem(item);
      expect(cart.getItems().length, 1);

      cart.removeItem(0);
      expect(cart.getItems().length, 0);
      expect(cart.getTotalDue(), 0.0);
    });
  });
}
