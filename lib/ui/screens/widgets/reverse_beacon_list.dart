import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotwatch/data/reverse_beacon/bloc/reverse_beacon_bloc.dart';
import 'package:spotwatch/models/enums.dart';

class ReverseBeaconList extends StatelessWidget {
  const ReverseBeaconList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReverseBeaconBloc, ReverseBeaconState>(
        listener: (context, state) {
          // if (state.reverseBeaconStatus == ReverseBeaconStatus.listening) {
          //   context.read<ReverseBeaconBloc>().add(const ReverseBeaconListening());
          // }
        },
        builder: (context, state) {
          switch (state.reverseBeaconStatus) {
            case ReverseBeaconStatus.initial:
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text('Fetching Spots...'),
                      
                    ],
                  ),
                ),
              );
            case ReverseBeaconStatus.listening:
            case ReverseBeaconStatus.updated:
            case ReverseBeaconStatus.paused:
              return SingleChildScrollView(
                child: Column(
                  children: [
                     ListView.builder(physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: state.reverseBeaconFeed.beaconSpots.length,
                        itemBuilder: (context, index) {
                          return 
                          Card(child:
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Row(children: [Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text(state.reverseBeaconFeed.beaconSpots[index].spottedCall, style: const TextStyle(fontWeight: FontWeight.w800),),
                                 Text(state.reverseBeaconFeed.beaconSpots[index].toString(), style: const TextStyle(fontSize: 12),)
                               ],
                             ),
                             ],),
                           )
                          );
                        },
                      ),
                    
                  ],
                ),
              );
            case ReverseBeaconStatus.error:
              return const Center(child: Text('Error'));
            case ReverseBeaconStatus.closed:
              return const Center(child: Text('Closed'));
          }
        },
      );
  }
}
