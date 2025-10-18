import 'package:flutter/material.dart';

class CustomProfile extends StatelessWidget {
  final String name;
  final String position;
  final String email;
  final String phoneNumber;
  final String imgUrl;
  const CustomProfile({
    super.key,
    required this.name,
    required this.position,
    required this.email,
    required this.phoneNumber,
    required this.imgUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 600,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 8,
            offset: Offset(3, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
            clipBehavior: Clip.hardEdge,
            child: Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTAsobTUQb0EI3__8-L2Kd5KAQvJLg2Wnu96Q&s',
              fit: BoxFit.fill,
            ),
          ),

          Text(
            name,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Text(
            position,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.email, color: Colors.redAccent, size: 22),
              SizedBox(width: 10),
              Text(
                email,
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.phone, color: Colors.green, size: 22),
              SizedBox(width: 10),
              Text(
                phoneNumber,
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
