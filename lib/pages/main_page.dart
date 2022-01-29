part of 'pages.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  //drawer Menu Variable
  static double _minHeight = 80, _maxHeight = 600;
  Offset _offset = Offset(0, _minHeight);
  bool _isOpen = false;

  //list Data Menu
  List<Map<String, dynamic>> listMenu = [
    {"icon": 'assets/images/tv.png', "name": "Live Show"},
    {"icon": 'assets/images/google-cast-logo.png', "name": "Live Class"},
    {"icon": 'assets/images/book.png', "name": "E-Course"},
    {"icon": 'assets/images/community.png', "name": "Community"},
    {"icon": 'assets/images/user.png', "name": "My Profile"},
    {"icon": 'assets/images/diskette.png', "name": "Saved Course"},
    {"icon": 'assets/images/play.png', "name": "Recent Course"},
    {"icon": 'assets/images/list.png', "name": "My List"},
    {"icon": 'assets/images/shopping-cart.png', "name": "My Cart"},
    {"icon": 'assets/images/clipboard.png', "name": "Purchase History"},
    {"icon": 'assets/images/store.png', "name": "Marketplace (Beta)"},
  ];

  ItemProvider itemProvider = ItemProvider();

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      itemProvider.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _buildContent(),
        backgroundColor: _offset.dy <= (_MainPageState._maxHeight * 0.9)
            ? Colors.white
            : Theme.of(context).primaryColor.withOpacity(
                ((_offset.dy - 80) / _MainPageState._maxHeight) * 1),
      ),
    );
  }

  Widget _buildContent() {
    //Preview Menu
    Widget _buildMenu(String icon, String title) {
      return Column(
        children: [
          Flexible(
            flex: 2,
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor),
                child: FractionallySizedBox(
                  widthFactor: 0.6,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: ImageIcon(
                      AssetImage(icon),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              height: double.infinity,
              alignment: Alignment.center,
              child: Text(title),
            ),
          ),
        ],
      );
    }

    //Detail Menu
    Widget _buildMenuList(Map<String, dynamic> data) {
      return Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.15,
            height: MediaQuery.of(context).size.width * 0.15,
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: Theme.of(context).primaryColor),
            child: ImageIcon(
              AssetImage(data['icon']!),
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.2,
            child: Text(
              data['name']!,
              textAlign: TextAlign.center,
            ),
          )
        ],
      );
    }

    return Column(
      children: [
        Stack(
          children: [
            //Appbar List Product
            Opacity(
              opacity: (1 - ((_offset.dy / _MainPageState._maxHeight) * 1)),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 10)
                    ]),
                child: const Text(
                  'List Product',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),

            //AppBar Expanded Menu
            Opacity(
              opacity: ((_offset.dy / _MainPageState._maxHeight) * 1),
              child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: GestureDetector(
                    onTap: () {
                      _handleClick();
                    },
                    child: Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Icon(
                          Icons.arrow_back,
                          color: Colors.white.withOpacity(
                              (_offset.dy / _MainPageState._maxHeight) * 1),
                        ),
                        Text(
                          'Back',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withOpacity(
                                  (_offset.dy / _MainPageState._maxHeight) *
                                      1)),
                        )
                      ],
                    ),
                  )),
            ),
          ],
        ),

        //List Item Section
        Expanded(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              ChangeNotifierProvider<ItemProvider>(
                  create: (context) => itemProvider,
                  child: Consumer<ItemProvider>(
                    builder: (context, itemProvider, _) {
                      if (itemProvider.requestStatus == 0) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (itemProvider.requestStatus == 1) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.03),
                          child: RefreshIndicator(
                            onRefresh: () async {
                              itemProvider.loadData();
                            },
                            child: ListView(
                              children: [
                                SizedBox(
                                    height: MediaQuery.of(context).size.width *
                                        0.05),
                                Wrap(
                                  alignment: WrapAlignment.spaceBetween,
                                  runSpacing:
                                      MediaQuery.of(context).size.width * 0.02,
                                  children: List.generate(
                                      itemProvider.listItem.length, (index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => DetailItemPage(
                                                      data: itemProvider
                                                          .listItem[index],
                                                    )));
                                      },
                                      child: Card(
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.44,
                                          child: Column(
                                            children: [
                                              AspectRatio(
                                                aspectRatio: 2 / 1,
                                                child: Container(
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .only(
                                                              topRight: Radius
                                                                  .circular(4),
                                                              topLeft: Radius
                                                                  .circular(4)),
                                                      color: Colors.black12,
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              itemProvider
                                                                  .listItem[
                                                                      index]
                                                                  .cover),
                                                          fit: BoxFit.cover)),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.02),
                                                width: double.infinity,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      itemProvider
                                                          .listItem[index].name,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    Text(
                                                      moneyChanger(double.parse(
                                                          itemProvider
                                                              .listItem[index]
                                                              .price
                                                              .toString())),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                )
                              ],
                            ),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  )),

              //Navigation Bar
              GestureDetector(
                onPanUpdate: (details) {
                  _offset = Offset(0, _offset.dy - details.delta.dy);

                  if (_offset.dy < _MainPageState._minHeight) {
                    _offset = Offset(0, _MainPageState._minHeight);
                    _isOpen = false;
                  } else if (_offset.dy > _MainPageState._maxHeight) {
                    _offset = Offset(0, _MainPageState._maxHeight);
                    _isOpen = true;
                  }
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: (20 -
                          ((_offset.dy / _MainPageState._maxHeight) * 20)),
                      vertical: (15 -
                          ((_offset.dy / _MainPageState._maxHeight) * 15))),
                  child: AnimatedContainer(
                    duration: Duration.zero,
                    curve: Curves.easeOut,
                    height: _offset.dy,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(30),
                          topRight: const Radius.circular(30),
                          bottomLeft: Radius.circular((30 -
                              ((_offset.dy / _MainPageState._maxHeight) * 30))),
                          bottomRight: Radius.circular((30 -
                              ((_offset.dy / _MainPageState._maxHeight) * 30))),
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 10)
                        ]),
                    child: _offset.dy >= 90
                        ? Container(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.05),
                            height: double.infinity,
                            child: SingleChildScrollView(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 16),
                                const Text(
                                  'Features',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 16),
                                Wrap(
                                  spacing:
                                      MediaQuery.of(context).size.width * 0.03,
                                  runSpacing:
                                      MediaQuery.of(context).size.width * 0.03,
                                  children:
                                      List.generate(listMenu.length, (index) {
                                    return _buildMenuList(listMenu[index]);
                                  }),
                                ),
                              ],
                            )),
                          )
                        : Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(4, (index) {
                                  return Flexible(
                                    flex: 1,
                                    child: _buildMenu(listMenu[index]['icon']!,
                                        listMenu[index]['name']!),
                                  );
                                })),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  //Minimize Menu Function
  void _handleClick() {
    _isOpen = !_isOpen;
    Timer.periodic(const Duration(milliseconds: 5), (timer) {
      if (_isOpen) {
        double value = _offset.dy + 10;
        _offset = Offset(0, value);
        if (_offset.dy > _maxHeight) {
          _offset = Offset(0, _maxHeight);
          timer.cancel();
        }
      } else {
        double value = _offset.dy - 10;
        _offset = Offset(0, value);
        if (_offset.dy < _minHeight) {
          _offset = Offset(0, _minHeight);
          timer.cancel();
        }
      }
      setState(() {});
    });
  }
}
