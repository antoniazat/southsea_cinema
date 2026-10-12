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
                'Dracula (1931)',
                style: TextStyle(fontSize: 25),
              ),
              Text(
                '1931',
                style:
                    TextStyle(backgroundColor: Color.fromARGB(0, 133, 45, 45)),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(onPressed: () {}, child: Text('Book Now'))
            ],
          )),
    );
  }
}

// name () {}
// DropdownMenu<int>(
//   initialSelection: 5,
//   onSelected: (int? value) {
//     if (value != null) {
//       setState(() {
//         _totalPrice = value;
//       });
//     }
//   },
//   dropdownMenuEntries: [
//     DropDownMenuEntry(value: 1, label: '1 Person'),
//     DropDownMenuEntry(value: 2, label: '2 People'),
//     DropDownMenuEntry(value: 3, label: '3 People'),
//     DropDownMenuEntry(value: 4, label: '4 People'),
//     DropDownMenuEntry(value: 5, label: '5 People'),
//   ],
// ),
