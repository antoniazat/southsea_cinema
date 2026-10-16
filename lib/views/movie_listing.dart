import 'package:flutter/material.dart';
import 'package:southsea_cinema/constants.dart';
import 'package:southsea_cinema/widgets/nav_drawer.dart';

class MovieListing extends StatelessWidget {
  const MovieListing({super.key});

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
          padding: EdgeInsets.all(10),
          color: cinemaBackground,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dracula (1931) (PG)',
                style: TextStyle(fontSize: 25),
              ),
              const SizedBox(height: 20),
              Text('Southsea Cinema Room', style: TextStyle(fontSize: 15)),
              const SizedBox(height: 20),
              Text('Thursday 22 October 2026, 18:00 - ends at 19:15',
                  style: TextStyle(fontSize: 15)),
              const SizedBox(height: 50),
              Text(
                'Please note that Discounts/Membership Benefits will be applied once you have your tickets',
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 20),
              Text(
                'Select Quantities (Up to 5 People in total)',
                style: TextStyle(fontSize: 15),
              ),
              const SizedBox(height: 40),
              BookingWidget(),
            ],
          )),
    );
  }
}

class BookingWidget extends StatefulWidget {
  const BookingWidget({super.key});

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
        Text('Tickets',
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
