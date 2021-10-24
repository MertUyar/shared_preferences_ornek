import 'package:flutter/material.dart';

class PageviewScreen extends StatelessWidget {
  const PageviewScreen({Key? key, this.image, this.text}) : super(key: key);
  final text;
  final image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          image,
          height: 200,
        ),
        const SizedBox(height: 50,),
        SizedBox(
          width: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
