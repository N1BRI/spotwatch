import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotwatch/data/reverse_beacon/bloc/reverse_beacon_bloc.dart';

class ReverseBeaconLivefeed extends StatelessWidget {
  const ReverseBeaconLivefeed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReverseBeaconBloc, ReverseBeaconState>(
        listener: (context, state) {
          if (state is ReverseBeaconUpdated) {
            context.read<ReverseBeaconBloc>().add(const ReverseBeaconWaiting());
          }
        },
        builder: (context, state) {
          switch (state) {
            case ReverseBeaconInitial():
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text('Initial'),
                      
                    ],
                  ),
                ),
              );
            case ReverseBeaconListening():
            case ReverseBeaconUpdated():
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: ListView.builder(physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: state.reverseBeaconFeed.beaconSpots.length,
                        itemBuilder: (context, index) {
                          return 
                          Card(child:
                          ListTile(
                            title: Text(state.reverseBeaconFeed.beaconSpots[index].spottedCall),
                            subtitle: Text(state.reverseBeaconFeed.beaconSpots[index]
                                .toString()),
                          ));
                        },
                      ),
                    ),
                  ],
                ),
              );
          }
        },
      );
  }
}
