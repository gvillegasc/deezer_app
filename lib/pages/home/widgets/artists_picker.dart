import 'package:cached_network_image/cached_network_image.dart';
import 'package:deezer_app/bloc/home/bloc.dart';
import 'package:deezer_app/models/artist_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArtistsPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (_, state) {
        return SliverPadding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate((_, index) {
              final ArtistModel artist = state.artists[index];
              return Column(children: <Widget>[
                Expanded(
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: artist.picture,
                      placeholder: (_, __) {
                        return CupertinoActivityIndicator();
                      },
                    ),
                  ),
                ),
                Text(
                  artist.name,
                  textAlign: TextAlign.center,
                )
              ]);
            }, childCount: state.artists.length),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 130,
                mainAxisSpacing: 10,
                crossAxisSpacing: 20),
          ),
        );
      },
    );
  }
}
