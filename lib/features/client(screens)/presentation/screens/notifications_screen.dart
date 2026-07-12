// notifications_screen.dart
// Responsible for: showing the notifications list ("الإشعارات") screen,
// matching the provided mockup pixel-for-pixel as closely as possible.
//
// NOTE (temporary): all notification data below is STATIC/DEMO data.
// This is intentional for now — the plan is to wire it to Firebase later.
// Everything is marked with // TODO: replace with Firestore stream so it's
// easy to find later.

import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});
  static const String id = 'notifications-screen';

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // ── Design tokens (kept local/static for now, matches the mockup) ──
  static const Color _green = Color(0xFF1B8A5A);
  static const Color _greenDark = Color(0xFF146B47);
  static const Color _greenLight = Color(0xFFEAF7F0);
  static const Color _orange = Color(0xFFF5A623);
  static const Color _textDark = Color(0xFF1F2A24);
  static const Color _textGrey = Color(0xFF8A9A93);
  static const Color _cardBg = Color(0xFFFFFFFF);
  static const Color _pageBg = Color(0xFFF6FAF8);

  int _selectedFilter = 0;

  // TODO: replace with Firestore stream (e.g. NotificationsRepository.watchAll())
  final List<_AppNotification> _notifications = const [
    _AppNotification(
      category: _NotifCategory.reminder,
      time: 'منذ 5 دقائق',
      title: 'حان وقت دواء الضغط',
      titleEmoji: '⏰',
      description: 'لا تنس تناول دواء Amlodipine 5mg في تمام 08:30 PM',
      icon: Icons.alarm_rounded,
      iconBg: _greenLight,
      iconColor: _green,
      badgeText: 'جديد',
      badgeFilled: false,
      unread: true,
    ),
    _AppNotification(
      category: _NotifCategory.orders,
      time: 'منذ 1 ساعة',
      title: 'تم توصيل طلبك بنجاح',
      titleEmoji: '📦',
      description: 'تم توصيل طلبك رقم #1245 بنجاح. شكراً لاختيارك صيدليتك.',
      icon: Icons.moped_rounded,
      iconBg: _greenLight,
      iconColor: _green,
    ),
    _AppNotification(
      category: _NotifCategory.offers,
      time: 'منذ 2 ساعة',
      title: 'عرض خاص لك!',
      titleEmoji: '🏷️',
      description: 'خصم 20% على منتجات العناية بالبشرة اليوم فقط',
      icon: Icons.sell_rounded,
      iconBg: _greenLight,
      iconColor: _green,
      badgeText: 'عرض العرض',
      badgeFilled: true,
    ),
    _AppNotification(
      category: _NotifCategory.reminder,
      time: 'منذ 3 ساعات',
      title: 'تذكير بالدواء القادم',
      titleEmoji: '🔔',
      description: 'دواء Metformin 500mg في تمام 12:00 PM',
      icon: Icons.medication_rounded,
      iconBg: _greenLight,
      iconColor: _green,
    ),
    _AppNotification(
      category: _NotifCategory.orders,
      time: 'منذ يوم',
      title: 'تم تحديث حالة طلبك',
      titleEmoji: '📋',
      description: 'طلبك رقم #1244 الآن قيد التجهيز في الصيدلية',
      icon: Icons.assignment_rounded,
      iconBg: _greenLight,
      iconColor: _green,
    ),
    _AppNotification(
      category: _NotifCategory.updates,
      time: 'منذ يومين',
      title: 'نصيحة صحية اليوم',
      titleEmoji: '💚',
      description: 'اشرب الماء بانتظام للحفاظ على صحتك ونشاطك طوال اليوم',
      icon: Icons.favorite_rounded,
      iconBg: _greenLight,
      iconColor: _green,
      badgeText: 'اقرأ المزيد',
      badgeFilled: true,
    ),
    _AppNotification(
      category: _NotifCategory.reminder,
      time: 'منذ 3 أيام',
      title: 'دوائك على وشك الانتهاء',
      titleEmoji: '⚠️',
      description: 'دواء Vitamin D3 سينتهي خلال 3 أيام. اطلب الآن.',
      icon: Icons.medication_liquid_rounded,
      iconBg: Color(0xFFFDF0DC),
      iconColor: _orange,
      badgeText: 'اطلب الآن',
      badgeFilled: true,
      badgeColor: _orange,
    ),
  ];

  static const List<_FilterTab> _filters = [
    _FilterTab(label: 'الكل', count: 12, category: null),
    _FilterTab(label: 'الطلبات', count: 4, category: _NotifCategory.orders),
    _FilterTab(label: 'التذكيرات', count: 5, category: _NotifCategory.reminder),
    _FilterTab(label: 'العروض', count: 2, category: _NotifCategory.offers),
    _FilterTab(label: 'التحديثات', count: 1, category: _NotifCategory.updates),
  ];

  List<_AppNotification> get _visibleNotifications {
    final category = _filters[_selectedFilter].category;
    if (category == null) return _notifications;
    return _notifications.where((n) => n.category == category).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: _pageBg,
        body: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(bottom: 24),
                children: [
                  const SizedBox(height: 16),
                  _buildFilterTabs(),
                  const SizedBox(height: 16),
                  ..._visibleNotifications.map(
                    (n) => Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      child: _NotificationCard(notification: n),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: _buildBottomNav(context),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        ClipRRect(
          borderRadius:
              const BorderRadius.only(bottomLeft: Radius.circular(55), bottomRight: Radius.circular(55)),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 16,
              bottom: 46,
              left: 20,
              right: 20,
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [_green, _greenDark],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -6,
                  right: -6,
                  child: Opacity(
                    opacity: 0.12,
                    child: Icon(Icons.add_rounded, size: 64, color: Colors.white),
                  ),
                ),
                Positioned(
                  bottom: 4,
                  left: 4,
                  child: Opacity(
                    opacity: 0.12,
                    child: Transform.rotate(
                      angle: -0.5,
                      child: const Icon(Icons.medication_rounded,
                          size: 46, color: Colors.white),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        _HeaderIconButton(
                          icon: Icons.arrow_back_ios_new_rounded,
                          onTap: () => Navigator.of(context).maybePop(),
                        ),
                        const Spacer(),
                        _HeaderIconButton(
                          icon: Icons.tune_rounded,
                          onTap: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'الإشعارات',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'سنخبرك بكل ما يهم صحتك',
                      style: TextStyle(fontSize: 13, color: Colors.white70),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: -28,
          child: Container(
            width: 66,
            height: 66,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.10),
                  blurRadius: 14,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Stack(
              children: [
                const Center(
                  child: Icon(Icons.notifications_rounded,
                      color: _green, size: 30),
                ),
                Positioned(
                  top: 14,
                  right: 14,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: _orange,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterTabs() {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final tab = _filters[index];
          final selected = index == _selectedFilter;
          return InkWell(
            onTap: () => setState(() => _selectedFilter = index),
            borderRadius: BorderRadius.circular(24),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: selected ? _green : Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: selected ? _green : const Color(0xFFE1EAE6),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    tab.label,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: selected ? Colors.white : _textDark,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                    decoration: BoxDecoration(
                      color: selected ? Colors.white : const Color(0xFFF0F4F2),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${tab.count}',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: selected ? _green : _textGrey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return SizedBox(
      height: 78,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 12,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _NavItem(
                      icon: Icons.person_outline_rounded,
                      label: 'الحساب',
                      selected: false,
                    ),
                  ),
                  Expanded(
                    child: _NavItem(
                      icon: Icons.shopping_cart_outlined,
                      label: 'الطلبات',
                      selected: false,
                    ),
                  ),
                  const Expanded(child: SizedBox()), // space for FAB
                  Expanded(
                    child: _NavItem(
                      icon: Icons.notifications_rounded,
                      label: 'الإشعارات',
                      selected: true,
                      badgeCount: 12,
                    ),
                  ),
                  Expanded(
                    child: _NavItem(
                      icon: Icons.home_rounded,
                      label: 'الرئيسية',
                      selected: false,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -22,
            child: Column(
              children: [
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    color: _green,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                    boxShadow: [
                      BoxShadow(
                        color: _green.withOpacity(0.35),
                        blurRadius: 14,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.add_rounded,
                      color: Colors.white, size: 30),
                ),
                const SizedBox(height: 2),
                const Text('طلب دواء',
                    style: TextStyle(
                        fontSize: 10.5,
                        color: _textDark,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _HeaderIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.18),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final int? badgeCount;
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    this.badgeCount,
  });

  static const Color _green = Color(0xFF1B8A5A);
  static const Color _grey = Color(0xFF9AA8A2);

  @override
  Widget build(BuildContext context) {
    final color = selected ? _green : _grey;
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(icon, color: color, size: 24),
                if (badgeCount != null)
                  Positioned(
                    top: -6,
                    right: -10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF5A623),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '$badgeCount',
                        style: const TextStyle(
                            fontSize: 9,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(label,
                style: TextStyle(
                    fontSize: 10.5, color: color, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

enum _NotifCategory { reminder, orders, offers, updates }

class _FilterTab {
  final String label;
  final int count;
  final _NotifCategory? category; // null = "الكل"
  const _FilterTab({required this.label, required this.count, required this.category});
}

class _AppNotification {
  final _NotifCategory category;
  final String time;
  final String title;
  final String titleEmoji;
  final String description;
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String? badgeText;
  final bool badgeFilled;
  final Color? badgeColor;
  final bool unread;

  const _AppNotification({
    required this.category,
    required this.time,
    required this.title,
    required this.titleEmoji,
    required this.description,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    this.badgeText,
    this.badgeFilled = false,
    this.badgeColor,
    this.unread = false,
  });
}

class _NotificationCard extends StatelessWidget {
  final _AppNotification notification;
  const _NotificationCard({required this.notification});

  static const Color _green = Color(0xFF1B8A5A);
  static const Color _textDark = Color(0xFF1F2A24);
  static const Color _textGrey = Color(0xFF8A9A93);

  @override
  Widget build(BuildContext context) {
    final n = notification;
    final badgeBg = n.badgeColor ?? _green;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFEFF3F1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(color: n.iconBg, shape: BoxShape.circle),
                  child: Icon(n.icon, color: n.iconColor, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${n.title} ${n.titleEmoji}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: _textDark,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        n.description,
                        style: const TextStyle(
                          fontSize: 12,
                          color: _textGrey,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      n.time,
                      style: const TextStyle(fontSize: 10.5, color: _textGrey),
                    ),
                    if (n.badgeText != null) ...[
                      const SizedBox(height: 6),
                      Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: n.badgeFilled ? badgeBg : badgeBg.withOpacity(0.10),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          n.badgeText!,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: n.badgeFilled ? Colors.white : badgeBg,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          if (n.unread)
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(color: _green, shape: BoxShape.circle),
              ),
            ),
          if (n.unread)
            Positioned(
              top: 0,
              bottom: 0,
              right: 0,
              child: Container(
                width: 4,
                decoration: const BoxDecoration(
                  color: _green,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(18),
                    bottomRight: Radius.circular(18),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
