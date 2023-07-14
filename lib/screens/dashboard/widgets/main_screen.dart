part of '../dashboard.dart';

class _MainScreen extends StatefulWidget {
  const _MainScreen({Key? key}) : super(key: key);

  @override
  State<_MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<_MainScreen> {
  final views = [
    const HomeScreen(),
    const LikedScreen(),
    const AddScreen(),
    const SearchScreen(),
    const ListenLaterScreen(),
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final songProvider = Provider.of<SongProvider>(context, listen: false);
      songProvider.fetch();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    App.init(context);
    final appProvider = Provider.of<AppProvider>(context);
    final bottomProvider = Provider.of<BottomProvider>(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: appProvider.isDark ? Colors.grey[850] : Color(0xffe8dede),
        body: views[bottomProvider.index],
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const PlayerMini(),
            BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border),
                  label: 'Liked',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add),
                  label: 'Add',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.watch_later_outlined),
                  label: 'Listen Later',
                ),
              ],
              currentIndex: bottomProvider.index,

              unselectedItemColor:
                  appProvider.isDark ? Colors.white : Colors.grey,
              selectedItemColor: AppTheme.c!.primary,
              onTap: (value) {
                setState(() {
                  bottomProvider.setIndex = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
