import 'package:deezer_app/libs/auth.dart';
import 'package:deezer_app/pages/home/widgets/artists_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:deezer_app/bloc/home/bloc.dart';

// Widgets
import 'widgets/home_header.dart';

class HomePage extends StatefulWidget {
  static final routeName = 'home';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc _bloc = HomeBloc();

  final GlobalKey<InnerDrawerState> _drawerKey = GlobalKey();

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: _bloc,
        child: InnerDrawer(
            key: _drawerKey,
            onTapClose: true,
            rightChild: Container(
              color: Colors.white,
            ),
            scaffold: Scaffold(
              body: CustomScrollView(
                slivers: <Widget>[
                  HomeHeader(
                    drawerKey: _drawerKey,
                  ),
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (_, state) {
                      if (state.status == HomeStatus.seletecing) {
                        return ArtistsPicker();
                      }
                      String text = "";
                      switch (state.status) {
                        case HomeStatus.checking:
                          text = "Checking Database ...";
                          break;
                        case HomeStatus.loading:
                          text = "Loading Artist ...";
                          break;
                        default:
                          text = "";
                      }

                      return SliverFillRemaining(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              child: LinearProgressIndicator(),
                            ),
                            Text(text)
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            )));
  }
}
