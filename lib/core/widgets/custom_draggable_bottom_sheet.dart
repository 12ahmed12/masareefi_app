import 'package:flutter/material.dart';

Widget makeDismissible(
        {required Widget child, required BuildContext context}) =>
    GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.pop(context),
      child: GestureDetector(
        onTap: () {},
        child: child,
      ),
    );

Widget buildSheet(
        {required BuildContext context, required Function function}) =>
    makeDismissible(
      child: DraggableScrollableSheet(
        initialChildSize: .9,
        minChildSize: .3,
        maxChildSize: .9,
        builder: (_, controller) => Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -10,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                width: 60,
                height: 7,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
              padding: EdgeInsets.all(20),
              width: double.infinity,
              child: ListView(
                controller: controller,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white),
                      onPressed: () {
                        Navigator.of(context).pop();
                        function;
                      },
                      child: Text(
                        'close',
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      context: context,
    );
