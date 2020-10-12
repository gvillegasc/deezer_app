import 'package:deezer_app/bloc/home/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    this._controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final Bloc bloc = HomeBloc.of(context);
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (_, state) {
        return SliverToBoxAdapter(
          child: state.status == HomeStatus.selecting
              ? Container(
                  padding: EdgeInsets.all(15),
                  child: CupertinoTextField(
                    controller: this._controller,
                    placeholder: "Search...",
                    onChanged: (text) {
                      bloc.add(OnSearchEvent(text));
                    },
                    style: TextStyle(fontFamily: "Sans"),
                    suffix: state.searchText.length > 0
                        ? Padding(
                            padding: EdgeInsets.only(
                              right: 5,
                            ),
                            child: CupertinoButton(
                              padding: EdgeInsets.all(5),
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(35),
                              minSize: 25,
                              onPressed: () {
                                this._controller.clear();
                                bloc.add(OnSearchEvent(''));
                              },
                              child: Icon(Icons.clear),
                            ),
                          )
                        : null,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                    decoration: BoxDecoration(
                        color: Color(0xffdddddd),
                        borderRadius: BorderRadius.circular(30)),
                  ),
                )
              : null,
        );
      },
    );
  }
}
