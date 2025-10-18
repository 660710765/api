import 'package:api_app/components/custom_profile.dart';
import 'package:flutter/material.dart';

class SimpleCustomWidget extends StatefulWidget {
  const SimpleCustomWidget({super.key});

  @override
  State<SimpleCustomWidget> createState() => _SimpleCustomWidgetState();
}

class _SimpleCustomWidgetState extends State<SimpleCustomWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Custom widget')),
      body: Center( 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
           CustomProfile(name: 'Prabda Pleannuam', position: '660710765', email: 'pleannuam_p@silpakorm.edu', phoneNumber: '888-888-888', imgUrl: 'https://wallpapers.com/picture/funny-anime-900-x-899-picture-6gwcdizxqxmqu38w.html')
          ],
        ),
      ),
    );
  }
}
