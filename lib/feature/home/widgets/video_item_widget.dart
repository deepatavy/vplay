import 'package:flutter/material.dart';

class VideoItemWidget extends StatelessWidget {
  final String image;
  final String title;
  final Widget navigateTo;

  const VideoItemWidget({super.key, required this.image, required this.title, required this.navigateTo});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => navigateTo));
      },
      child: Card(
          margin: const EdgeInsets.all(16),
          elevation: 4,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                image,
                height: 200,
              ),
              Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          )),
    );
  }
}
