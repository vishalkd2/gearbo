

import 'package:flutter/material.dart';
import 'package:gearbo/provider/user_provider.dart';
import 'package:gearbo/screens/landing_page.dart';
import 'package:gearbo/screens/room_list_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context,listen: false);
    final user = provider.currentUser;
    final token = provider.currentUser?.token??'Token not available';
    return Scaffold(
      appBar: AppBar(title: Text(user!.user!.name??"Unknown",style: TextStyle(fontWeight: FontWeight.bold)),
      centerTitle: true,backgroundColor: Colors.white,foregroundColor: Colors.black,elevation: 0.5,
        actions: [
          IconButton(onPressed: (){
            provider.logout();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LandingPage()));
          }, icon: Icon(Icons.logout))
        ],
      ),
      body:  Padding(padding: EdgeInsets.all(20.0),child: Column(children: [
        const Text('Select a section to manage',style: TextStyle(fontSize: 14, color: Colors.grey)),
        const SizedBox(height: 28),
        _SectionCard(icon: Icons.hotel_rounded, title: 'Hotel Section', subtitle: 'Manage rooms, guests & status', color:const Color(0xFF4F46E5),
            onTap: (){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>RoomListPage(token:token)));
            }
        ),
        const SizedBox(height: 16),
        _SectionCard(icon: Icons.directions_car_filled_rounded, title: 'Fleet Section', subtitle: 'Manage vehicles & assignments', color: const Color(0xFF0EA5E9),
            onTap: (){
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Fleet section coming soon!')));
            }
        ),
      ],),)
    );
  }
}

class _SectionCard extends StatelessWidget {
  final  IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;
  const _SectionCard({required this.icon,required this.title,required this.subtitle,required this.color,required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [BoxShadow(color: color.withOpacity(0.35),blurRadius: 16,offset: const Offset(0, 8),)]
        ),
        child: Row(children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.2),borderRadius: BorderRadius.circular(14)),
            child: Icon(icon, color: Colors.white, size: 32),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(subtitle, style: TextStyle(color: Colors.white.withOpacity(0.85), fontSize: 13)),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18),
        ],),
      ),
    );
  }
}

