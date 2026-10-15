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
              
              Text(
                'Southsea Cinema Room',
                 style: TextStyle(fontSize: 15)
                 ),
              const SizedBox(height: 20),

              Text(
                'Thursday 22 October 2026, 18:00 - ends at 19:15',
                style: TextStyle(fontSize: 15)
                ),
              const SizedBox(height: 20),

              Text('Please note that Discounts/Membership Benefits will be applied once you have your tickets',
                style:
                    TextStyle(fontSize: 15),
              ),
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Tickets',
        style: TextStyle(
          fontWeight: FontWeight.w900, fontSize: 20)),
        
        DropdownButton<int>(
          value: _ticketQuantity,
          items: const [
            DropdownMenuItem(value: 1, child: Text('1 Person')),
            DropdownMenuItem(value: 2, child: Text('2 People')),
            DropdownMenuItem(value: 3, child: Text('3 People')),
            DropdownMenuItem(value: 4, child: Text('4 People')),
            DropdownMenuItem(value: 5, child: Text('5 People')),
          ],
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _ticketQuantity = value;
              });
            }
          },
        ),
        const SizedBox(height: 10),
        ElevatedButton(onPressed: () {
          // booking logic can go here later
        }, 
        child: const Text('Add to Order')
        ),
      ],
    );
  }
}
