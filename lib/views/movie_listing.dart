import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/models/movie.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

class MovieListing extends StatelessWidget {
  final Movie movie;

  const MovieListing({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle, style: cinemaHeaderStyle),
        backgroundColor: cinemaSurface,
        iconTheme: const IconThemeData(color: cinemaBrand),
        elevation: 0,
      ),
      drawer: const NavDrawer(),
      body: Container(
        color: cinemaBackground,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Image.asset(
              movie.posterImagePath,
              height: 240,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),
            Text(
              '${movie.title} (${movie.ageRating})',
              style: const TextStyle(fontSize: 25),
            ),
            const SizedBox(height: 12),
            Text('${movie.duration}  |  ${movie.formattedPrice} per ticket'),
            const SizedBox(height: 20),
            Text(movie.synopsis),
            const SizedBox(height: 32),
            const Text(
              'Select quantities (up to 5 people in total)',
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 16),
            BookingWidget(movie: movie),
          ],
        ),
      ),
    );
  }
}

class BookingWidget extends StatefulWidget {
  final Movie movie;

  const BookingWidget({super.key, required this.movie});

  @override
  State<BookingWidget> createState() => _BookingWidgetState();
}

class _BookingWidgetState extends State<BookingWidget> {
  int _ticketQuantity = 1;
  String _bookingMessage = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Order ${widget.movie.title}',
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
        DropdownButton<int>(
          value: _ticketQuantity,
          onChanged: (int? value) {
            if (value != null) {
              setState(() {
                _ticketQuantity = value;
              });
            }
          },
          items: const [
            DropdownMenuItem(value: 1, child: Text('1 Person')),
            DropdownMenuItem(value: 2, child: Text('2 People')),
            DropdownMenuItem(value: 3, child: Text('3 People')),
            DropdownMenuItem(value: 4, child: Text('4 People')),
            DropdownMenuItem(value: 5, child: Text('5 People')),
          ],
        ),
        Text(_bookingMessage),
        const SizedBox(height: 10),
        ElevatedButton(
            onPressed: () {
              setState(() {
                _bookingMessage = 'Added $_ticketQuantity tickets to the order';
              });
            },
            child: const Text('Add to Order')),
      ],
    );
  }
}

// so his OrderScreen is my BookingWidget, and his OrderitemDisplay
// is my DropdownMenuItem
