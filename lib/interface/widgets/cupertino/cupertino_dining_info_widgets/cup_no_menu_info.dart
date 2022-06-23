import 'package:flutter/cupertino.dart';

class CupNoMenuInfo extends StatelessWidget {
  const CupNoMenuInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('No menu selected yet'),
        ],
      ),
    );
  }
}
