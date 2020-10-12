import 'package:deezer_app/bloc/home/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (_, state) {
        return SliverToBoxAdapter(
          child: state.status == HomeStatus.seletecing
              ? Container(
                  padding: EdgeInsets.all(15),
                  child: CupertinoTextField(
                    placeholder: "Search...",
                    style: TextStyle(fontFamily: "Sans"),
                    suffix: Padding(
                      padding: EdgeInsets.only(
                        right: 5,
                      ),
                      child: CupertinoButton(
                        padding: EdgeInsets.all(5),
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(35),
                        minSize: 25,
                        onPressed: () {},
                        child: Icon(Icons.clear),
                      ),
                    ),
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
