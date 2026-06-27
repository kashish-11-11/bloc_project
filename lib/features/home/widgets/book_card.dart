import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class book_card extends StatelessWidget {
  String bookname;
  String bookprice;
  String image;
  book_card({
    required this.bookname,
    required this.bookprice,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 150,
        width: 127,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 130,
              width: 120,
              color: Colors.black,

              child: Image.asset(image, fit: BoxFit.cover),
            ),
            Text(bookname),
            Text(bookprice),
          ],
        ),
      ),
    );
  }
}
