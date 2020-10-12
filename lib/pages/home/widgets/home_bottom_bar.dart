import 'package:deezer_app/bloc/home/bloc.dart';
import 'package:deezer_app/models/artist_model.dart';
import 'package:deezer_app/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final HomeBloc bloc = HomeBloc.of(context);

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (_, state) {
        if (state.status == HomeStatus.selecting) {
          final List<ArtistModel> artistsSelected = state.artists
              .where((element) => element.selected == true)
              .toList();
          final int count = artistsSelected.length;
          return Container(
            color: Colors.white,
            padding: EdgeInsets.all(10),
            child: SafeArea(
                top: false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      "Select at least 5 artists",
                      style: TextStyle(fontSize: 15),
                    )),
                    RoundedButton(
                      onPressed: count >= 5
                          ? () {
                              bloc.add(DownloadEvent(artistsSelected));
                            }
                          : null,
                      label: "NEXT",
                    )
                  ],
                )),
          );
        }
        return SizedBox();
      },
    );
  }
}
