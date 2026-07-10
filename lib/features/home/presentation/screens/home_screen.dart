import 'package:flutter/material.dart';
import 'package:paranubhutifoundation/features/home/presentation/widgets/item_list_widget.dart';
import 'package:paranubhutifoundation/shared/widgets/appbar_screen.dart';
import 'package:paranubhutifoundation/shared/widgets/bottam_navigation_screen.dart';
import 'package:paranubhutifoundation/shared/widgets/custom_image_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(centerTitle: false),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          /*Navigate to donate screen*/
        },
        shape: CircleBorder(),
        backgroundColor: Colors.redAccent,
        child: Icon(Icons.volunteer_activism, color: Colors.white),
      ),

      bottomNavigationBar: BottamNavigationScreen(selectindex: 0),

      body: SizedBox(
        height: 290,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
        
            return CustomImageCard(
        imageUrl: item["image"]!,
        title: item["title"]!,
        description: item["description"]!,
        onTap: () {
          debugPrint(item["title"]);
        },
            );
          },
        ),
      ),
      
    
    );
  }
}
