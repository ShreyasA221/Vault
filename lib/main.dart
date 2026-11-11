
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const VaultApp());
}

class VaultApp extends StatelessWidget {
  const VaultApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vault',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF315C72),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF6F7F8),
        fontFamily: 'Segoe UI',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF6F7F8),
          elevation: 0,
          centerTitle: false,
        ),
      ),
      home: const VaultHome(),
    );
  }
}

class VaultHome extends StatefulWidget {
  const VaultHome({super.key});

  @override
  State<VaultHome> createState() => _VaultHomeState();
}

class _VaultHomeState extends State<VaultHome> {
  int _selectedIndex = 0;

  final List<NavigationItem> _navigationItems = [
    NavigationItem(
      title: 'Dashboard',
      icon: Icons.dashboard_outlined,
      selectedIcon: Icons.dashboard_rounded,
    ),
    NavigationItem(
      title: 'Fixed Deposits',
      icon: Icons.account_balance_outlined,
      selectedIcon: Icons.account_balance_rounded,
    ),
    NavigationItem(
      title: 'Family',
      icon: Icons.people_outline_rounded,
      selectedIcon: Icons.people_rounded,
    ),
    NavigationItem(
      title: 'Reminders',
      icon: Icons.notifications_none_rounded,
      selectedIcon: Icons.notifications_rounded,
    ),
    NavigationItem(
      title: 'Documents',
      icon: Icons.folder_outlined,
      selectedIcon: Icons.folder_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          _buildSidebar(),
          Expanded(
            child: Column(
              children: [
                _buildTopBar(),
                Expanded(
                  child: _buildContent(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 245,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(24, 28, 24, 36),
            child: Row(
              children: [
                Icon(
                  Icons.shield_outlined,
                  size: 30,
                  color: Color(0xFF315C72),
                ),
                SizedBox(width: 12),
                Text(
                  'VAULT',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'WORKSPACE',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.4,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 12),
          ...List.generate(
            _navigationItems.length,
            (index) => _buildNavigationItem(index),
          ),
          const Spacer(),
          const Divider(height: 1),
          _buildNavigationItem(
            -1,
            item: NavigationItem(
              title: 'Settings',
              icon: Icons.settings_outlined,
              selectedIcon: Icons.settings_rounded,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(24),
            child: Text(
              'VAULT  •  VERSION 1.0.0',
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationItem(
    int index, {
    NavigationItem? item,
  }) {
    final navigationItem =
        item ?? _navigationItems[index];

    final selected = _selectedIndex == index;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 3,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: selected
                ? const Color(0xFFEAF0F3)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                selected
                    ? navigationItem.selectedIcon
                    : navigationItem.icon,
                size: 20,
                color: selected
                    ? const Color(0xFF315C72)
                    : Colors.grey.shade600,
              ),
              const SizedBox(width: 12),
              Text(
                navigationItem.title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight:
                      selected ? FontWeight.w600 : FontWeight.w500,
                  color: selected
                      ? const Color(0xFF315C72)
                      : Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    final title = _selectedIndex == -1
        ? 'Settings'
        : _navigationItems[_selectedIndex].title;

    return Container(
      height: 76,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      decoration: const BoxDecoration(
        color: Color(0xFFF6F7F8),
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE8EAEC),
          ),
        ),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search_rounded),
            tooltip: 'Search',
          ),
          const SizedBox(width: 12),
          CircleAvatar(
            radius: 17,
            backgroundColor: const Color(0xFFE3EBEF),
            child: const Icon(
              Icons.person_outline_rounded,
              size: 19,
              color: Color(0xFF315C72),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    switch (_selectedIndex) {
      case 0:
        return const DashboardPage();
      case 1:
        return const PlaceholderPage(
          title: 'Fixed Deposits',
          description: 'Manage and monitor family fixed deposits.',
          icon: Icons.account_balance_outlined,
        );
      case 2:
        return const PlaceholderPage(
          title: 'Family',
          description: 'Manage family members and ownership details.',
          icon: Icons.people_outline_rounded,
        );
      case 3:
        return const PlaceholderPage(
          title: 'Reminders',
          description: 'Track upcoming FD maturity dates.',
          icon: Icons.notifications_none_rounded,
        );
      case 4:
        return const PlaceholderPage(
          title: 'Documents',
          description: 'Store and organize financial documents.',
          icon: Icons.folder_outlined,
        );
      default:
        return const PlaceholderPage(
          title: 'Settings',
          description: 'Configure your Vault application.',
          icon: Icons.settings_outlined,
        );
    }
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Good evening',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Here is your family FD portfolio overview.',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 30),
          const Wrap(
            spacing: 18,
            runSpacing: 18,
            children: [
              SummaryCard(
                title: 'Total FD Principal',
                value: '₹ 0.00',
                subtitle: 'Across all family members',
                icon: Icons.account_balance_wallet_outlined,
              ),
              SummaryCard(
                title: 'Expected Maturity',
                value: '₹ 0.00',
                subtitle: 'Principal + expected interest',
                icon: Icons.trending_up_rounded,
              ),
              SummaryCard(
                title: 'Active Deposits',
                value: '0',
                subtitle: 'Currently active FDs',
                icon: Icons.receipt_long_outlined,
              ),
              SummaryCard(
                title: 'Upcoming Maturities',
                value: '0',
                subtitle: 'Within the next 30 days',
                icon: Icons.event_outlined,
              ),
            ],
          ),
          const SizedBox(height: 36),
          const Text(
            'Upcoming maturities',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFFE8EAEC),
              ),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.event_available_outlined,
                  size: 38,
                  color: Colors.grey.shade400,
                ),
                const SizedBox(height: 12),
                const Text(
                  'No fixed deposits added yet',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Your upcoming maturities will appear here.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;

  const SummaryCard({
    super.key,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE8EAEC),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 21,
            color: const Color(0xFF315C72),
          ),
          const SizedBox(height: 18),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}

class PlaceholderPage extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const PlaceholderPage({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 48,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Coming in the next development phase',
            style: TextStyle(
              fontSize: 11,
              color: Color(0xFF315C72),
            ),
          ),
        ],
      ),
    );
  }
}

class NavigationItem {
  final String title;
  final IconData icon;
  final IconData selectedIcon;

  NavigationItem({
    required this.title,
    required this.icon,
    required this.selectedIcon,
  });
}
