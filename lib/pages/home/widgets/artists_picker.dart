import 'package:cached_network_image/cached_network_image.dart';
import 'package:deezer_app/bloc/home/bloc.dart';
import 'package:deezer_app/models/artist_model.dart';
import 'package:deezer_app/utils/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArtistsPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final Responsive responsive = Responsive.of(context);
    final HomeBloc bloc = HomeBloc.of(context);
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (_, state) {
        final List<ArtistModel> artists = state.artists
            .where((element) => element.name
                .toLowerCase()
                .contains(state.searchText.toLowerCase()))
            .toList();

        return SliverPadding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate((_, index) {
              final ArtistModel artist = artists[index];
              return Column(children: <Widget>[
                Expanded(
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      bloc.add(OnSelectedEvent(artist.id));
                    },
                    child: ClipOval(
                      child: Stack(
                        children: <Widget>[
                          CachedNetworkImage(
                            imageUrl: artist.picture,
                            placeholder: (_, __) {
                              return CupertinoActivityIndicator();
                            },
                          ),
                          Positioned.fill(
                              child: AnimatedContainer(
                            duration: Duration(microseconds: 300),
                            child: Container(
                              color: Colors.black26,
                              child: Icon(
                                Icons.check_circle,
                                color: artist.selected
                                    ? Colors.white
                                    : Colors.transparent,
                              ),
                            ),
                          ))
                        ],
                      ),
                    ),
                  ),
                ),
                Text(
                  artist.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: "Sans",
                      fontSize: responsive.ip(
                        1.5,
                      )),
                )
              ]);
            }, childCount: artists.length),
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
