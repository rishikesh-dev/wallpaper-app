import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:toastification/toastification.dart';
import 'package:wallpaper_app/core/constants/app_constants.dart';
import 'package:wallpaper_app/core/routes/app_router_constants.dart';
import 'package:wallpaper_app/features/profile/presentation/section/download_sections.dart';
import 'package:wallpaper_app/features/profile/presentation/section/favourite_section.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  TextEditingController nameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hive = Hive;
    final box = hive.box(AppConstants.user);
    final name = box.get('name');
    return SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 50),
                CircleAvatar(
                  backgroundColor: Theme.of(context).cardColor,
                  radius: 60,
                  child: Text(
                    name.toString().characters.first,
                    style: TextStyle(
                      fontSize: 54,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                ),
                const SizedBox(height: 20),
                Row(
                  spacing: 20,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        deleteAccount(context, hive, box);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(10),
                        ),
                        backgroundColor: Theme.of(context).cardColor,
                        foregroundColor: Theme.of(
                          context,
                        ).scaffoldBackgroundColor,
                      ),
                      child: Text(
                        'Delete Account',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    IconButton.filled(
                      style: IconButton.styleFrom(
                        backgroundColor: Theme.of(context).cardColor,
                      ),
                      onPressed: () {
                        editAccount(context, name, box, nameController);
                      },
                      icon: Icon(
                        Icons.edit,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _StickyTabBarDelegate(
              TabBar(
                dividerHeight: 0,
                enableFeedback: true,
                controller: _tabController,
                tabs: const [
                  Tab(icon: Icon(LucideIcons.heart)),
                  Tab(icon: Icon(LucideIcons.folderHeart)),
                ],
              ),
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: const [FavouriteSection(), DownloadSections()],
        ),
      ),
    );
  }

  Future<dynamic> editAccount(
    BuildContext context,
    name,
    Box hive,
    TextEditingController controller,
  ) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Want to change your name?'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: name,
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                try {
                  hive.putAt(0, controller.text);
                } catch (e) {
                  toastification.show(
                    title: Text("Failed to change name🥲"),
                    description: Text('$e'),
                    type: ToastificationType.error,
                  );
                }
                context.pop();
                setState(() {});
              },
              child: Text('Change'),
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> deleteAccount(
    BuildContext context,
    HiveInterface hive,
    Box<dynamic> box,
  ) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text('Your all data will be gone'),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final favorites = hive.box(AppConstants.favorites);
              final downloads = hive.box(AppConstants.downloads);
              box.deleteFromDisk();
              favorites.deleteFromDisk();
              downloads.deleteFromDisk();
              context.goNamed(AppRouterConstants.getStarted);
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _StickyTabBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return _tabBar;
  }

  @override
  bool shouldRebuild(covariant _StickyTabBarDelegate oldDelegate) {
    return false;
  }
}
