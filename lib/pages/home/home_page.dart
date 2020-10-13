import 'package:deezer_app/db/app_theme.dart';
import 'package:deezer_app/db/artists_store.dart';
import 'package:deezer_app/libs/auth.dart';
import 'package:deezer_app/pages/home/widgets/artists_picker.dart';
import 'package:deezer_app/pages/home/widgets/home_bottom_bar.dart';
import 'package:deezer_app/pages/home/widgets/my_artists.dart';
import 'package:deezer_app/pages/home/widgets/search.dart';
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

  Future<void> _logOut() async {
    await ArtistsStore.instance.clear();
    await MyAppTheme.instance.setTheme(false);
    await Auth.instance.logOut(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: _bloc,
        child: InnerDrawer(
            key: _drawerKey,
            onTapClose: true,
            rightChild: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FlatButton(
                      onPressed: this._logOut,
                      child: Text("Log out"),
                    )
                  ],
                ),
              ),
            ),
            scaffold: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Scaffold(
                bottomNavigationBar: HomeBottomBar(),
                body: CustomScrollView(
                  slivers: <Widget>[
                    HomeHeader(
                      drawerKey: _drawerKey,
                    ),
                    Search(),
                    BlocBuilder<HomeBloc, HomeState>(
                      builder: (_, state) {
                        if (state.status == HomeStatus.selecting) {
                          return ArtistsPicker();
                        } else if (state.status == HomeStatus.ready) {
                          return MyArtists();
                        }
                        String text = "";
                        switch (state.status) {
                          case HomeStatus.checking:
                            text = "Checking Database ...";
                            break;
                          case HomeStatus.loading:
                            text = "Loading Artist ...";
                            break;
                          case HomeStatus.downloading:
                            text = "Downloading Tracks ...";
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
              ),
            )));
  }
}
