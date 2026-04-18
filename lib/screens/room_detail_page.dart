
import 'package:flutter/material.dart';
import 'package:gearbo/model/room_model.dart';

class RoomDetailPage extends StatelessWidget {
  final RoomModel room;
  const RoomDetailPage({required this.room,super.key});

  Color _statusColor(String? status) {
    switch (status) {
      case 'Available': return Colors.green;
      case 'Occupied':  return Colors.red;
      case 'Cleaning':  return Colors.orange;
      default:          return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Room ${room.id}',
            style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(child: Column(children: [
        _InfoCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
             Text(room.type ?? 'Unknown Type',style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
             Container(
               padding: const EdgeInsets.symmetric(
                   horizontal: 14, vertical: 6),
               decoration: BoxDecoration(
                 color: _statusColor(room.status).withOpacity(0.15),
                 borderRadius: BorderRadius.circular(20),
               ),
               child: Text(room.status ?? '',style: TextStyle(color: _statusColor(room.status),fontWeight: FontWeight.bold,fontSize: 13)),
             ),
           ]),
          const Divider(height: 24),
          _DetailRow(label: 'Room Number', value: '${room.id}'),
          _DetailRow(label: 'Room ID', value: room.sId ?? '-'),

        ],)),
        const SizedBox(height: 20),
        const Text('Guests',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),

        if (room.guests == null || room.guests!.isEmpty)
          _InfoCard(
            child: Row(
              children: const [
                Icon(Icons.person_off_outlined, color: Colors.grey),
                SizedBox(width: 10),
                Text('No guests in this room',
                    style: TextStyle(color: Colors.grey)),
              ]))
        else
          ...room.guests!.map((guest)=>_InfoCard(child: Row(children: [
          Container(padding: const EdgeInsets.all(10),decoration: BoxDecoration(
              color: const Color(0xFF4F46E5).withOpacity(0.1),shape: BoxShape.circle),
                child: const Icon(Icons.person,color: Color(0xFF4F46E5))),
          const SizedBox(width: 14),
          Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
             Text(guest.name ?? 'Unknown',style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w600)),
             const SizedBox(height: 3),
             Text(guest.phone ?? '-',style: const TextStyle(fontSize: 14, color: Colors.grey)),
    ],)
    ],))
          )

    ]))
    );
  }
}


class _InfoCard extends StatelessWidget {
  final Widget child;
  const _InfoCard({required  this.child,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05),blurRadius: 10,offset: const Offset(0,4))
        ],
      ),
      child: child,
    );
  }
}


class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  const _DetailRow({required this.label,required this.value,super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(vertical: 6),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,style: const TextStyle(color: Colors.grey, fontSize: 14)),
        Text(value,style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
      ],
    ),
    );
  }
}

