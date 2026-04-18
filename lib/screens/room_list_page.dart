

import 'package:flutter/material.dart';
import 'package:gearbo/model/room_model.dart';
import 'package:gearbo/provider/room_provider.dart';
import 'package:gearbo/screens/room_detail_page.dart';
import 'package:provider/provider.dart';

class RoomListPage extends StatefulWidget {
  final String token;
  const RoomListPage({required this.token,super.key});
  @override
  State<RoomListPage> createState() => _RoomListPageState();
}
class _RoomListPageState extends State<RoomListPage> {

@override
void initState(){
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_){
    Provider.of<RoomProvider>(context,listen: false).fetchRooms(widget.token);
  });
}

Color _statusColor(String? status){
  switch(status){
    case 'Available':
      return Colors.green;
    case 'Occupied':
      return Colors.red;
    case 'Cleaning':
      return Colors.orange;
    default:
      return Colors.grey;
  }
}

IconData _statusIcon(String? status){
  switch (status) {
    case 'Available':
      return Icons.check_circle_rounded;
    case 'Occupied':
      return Icons.person_rounded;
    case 'Cleaning':
      return Icons.cleaning_services_rounded;
    default:
      return Icons.help_outline;
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(title: Text('Hotel Rooms',style: TextStyle(fontWeight: FontWeight.bold)),
     centerTitle: true,backgroundColor: Colors.white,foregroundColor: Colors.black,elevation: 0.5,
     ),

      body: Consumer<RoomProvider>(builder: (context,provider,_){
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (provider.errorMessage != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 60, color: Colors.red),
                const SizedBox(height: 12),
                Text(provider.errorMessage!,style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => provider.fetchRooms(widget.token),
                  child: const Text('Retry'),
                )
              ],
            ),
          );
        }
        if (provider.rooms.isEmpty) {
          return const Center(child: Text('Room not availablee'));
        }

        return ListView.builder(
          padding:const EdgeInsets.all(16),
          itemCount: provider.rooms.length,
            itemBuilder: (context,index){
              final RoomModel room = provider.rooms[index];
              return GestureDetector(
                onTap:() {Navigator.push(context, MaterialPageRoute(builder: (context)=>RoomDetailPage(room: room)));},
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(14),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05),blurRadius: 10,offset: const Offset(0, 4),)],
                  ),
                  child: Row(children: [
                    Container(width: 52,height: 52,decoration: BoxDecoration(
                        color: const Color(0xFF4F46E5).withOpacity(0.1),borderRadius: BorderRadius.circular(12)),
                      child: Center(child: Text('${room.id}',style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Color(0xFF4F46E5))))),
                    const SizedBox(width: 14),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                      Text(room.type ?? 'Unknown',style: const TextStyle(
                          fontSize: 16,fontWeight: FontWeight.w600)),
                      const SizedBox(height: 4),
                      Row(children: [
                        Icon(_statusIcon(room.status),size: 14,color: _statusColor(room.status)),
                        const SizedBox(width: 4),
                        Text(room.status ?? 'Unknown',style: TextStyle(fontSize: 13,
                            color: _statusColor(room.status),fontWeight: FontWeight.w500)),
                      ]),

                    ])),
                    if (room.guests != null && room.guests!.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${room.guests!.length} guest${room.guests!.length > 1 ? 's' : ''}',
                          style: const TextStyle(fontSize: 12, color: Colors.red),
                        ),
                      ),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward_ios,size: 16, color: Colors.grey),

                  ]),

                ),
              );
            });


      }),

    );
  }
}
