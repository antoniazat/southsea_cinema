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
      body: Container(child: Column(
        children: [Text('Dracula')],
      )),
    );
  }
}


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
