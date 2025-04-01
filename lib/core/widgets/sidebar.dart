import 'package:flutter/material.dart';
import 'package:velp_lite/core/utils/assets_paths.dart';
import 'package:velp_lite/core/widgets/app_listview.dart';

import '../../features/appointments/presentation/screens/appointment_screen.dart'; // Add if exists
import '../../features/authentication/presentation/screens/login_screen.dart';
import '../../features/chat/presentation/screens/chat_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';

class SideBarItem {
  final String title;
  final IconData icon;
  final Widget screen;

  const SideBarItem({
    required this.title,
    required this.icon,
    required this.screen,
  });
}

class SideBarItems {
  static final List<SideBarItem> items = [
    const SideBarItem(title: 'My Pets', icon: Icons.pets, screen: HomeScreen()),
    const SideBarItem(
        title: 'Appointments',
        icon: Icons.calendar_today,
        screen: AppointmentsScreen()),
    const SideBarItem(title: 'Chat', icon: Icons.chat, screen: ChatScreen()),
  ];
}

class SideBar extends StatefulWidget {
  final String currentRoute; // To indicate the current screen

  const SideBar({super.key, required this.currentRoute});

  @override
  SideBarState createState() => SideBarState();
}

class SideBarState extends State<SideBar> {
  void goToScreen(Widget screen) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            // Header
            Row(
              spacing: 12,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundImage: AssetImage(AssetsPaths.logo),
                ),
                Text(
                  'VELP LITE',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(fontSize: 25),
                ),
              ],
            ),
            // Menu Items
            Expanded(
              child: AppListview(
                itemCount: SideBarItems.items.length, // Exclude Logout
                itemBuilder: (context, index) {
                  final item = SideBarItems.items[index];
                  final isSelected = widget.currentRoute == item.title;
                  return ListTile(
                      leading: Icon(item.icon,
                          color: isSelected
                              ? Theme.of(context).primaryColor
                              : Colors.grey),
                      title: Text(
                        item.title,
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: isSelected
                                      ? Theme.of(context).primaryColor
                                      : Colors.black,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                ),
                      ),
                      onTap: () => goToScreen(item.screen));
                },
              ),
            ),
            // Logout at the bottom
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              title: Text(
                'Logout',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(color: Colors.redAccent),
              ),
              onTap: () => goToScreen(const LoginScreen()),
            ),
          ],
        ),
      ),
    );
  }
}
