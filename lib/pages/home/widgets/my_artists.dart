import 'package:cached_network_image/cached_network_image.dart';
import 'package:deezer_app/bloc/home/home_bloc.dart';
import 'package:deezer_app/bloc/home/home_state.dart';
import 'package:deezer_app/models/artist_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyArtists extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (_, state) {
        return SliverList(
          delegate: SliverChildBuilderDelegate((_, index) {
            final ArtistModel artist = state.artists[index];
            return Padding(
              padding: EdgeInsets.all(8),
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: [
                          ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: artist.picture,
                              width: 60,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                artist.name,
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Sans"),
                              ),
                              Text("${artist.tracks.length} tracks"),
                            ],
                          ),
                        ],
                      ),
                      CircleAvatar(
                        child: Icon(Icons.play_arrow),
                      )
                    ],
                  ),
                ),
              ),
            );
          }, childCount: state.artists.length),
        );
      },
    );
  }
}
