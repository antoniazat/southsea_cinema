import 'package:southsea_cinema/models/movie.dart';

class CartItem {
  final Movie movie;
  final int ticketQuantity;

  const CartItem({required this.movie, required this.ticketQuantity});

  double get lineTotal {
    return movie.pricing * ticketQuantity;
  }
}
