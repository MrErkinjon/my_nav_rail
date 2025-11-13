import 'package:flutter/material.dart';

/// Responsive navigation breakpoints configuration
class ResponsiveBreakpoints {
  static const double tablet = 720.0;
  static const double desktop = 1440.0;
  static const double minHeight = 400.0;

  const ResponsiveBreakpoints._();
}

/// Navigation rail dimensions
class NavigationDimensions {
  static const double drawerWidth = 280.0;
  static const double railWidth = 72.0;
  static const double compactRailWidth = 56.0;
  static const double extendedRailWidth = 256.0;

  const NavigationDimensions._();
}

/// {@template responsive_navigation_scaffold}
/// A highly adaptive navigation scaffold that automatically adjusts its layout
/// based on screen size and device type:
///
/// - **Mobile** (`< 720dp`): Bottom navigation bar
/// - **Tablet** (`≥ 720dp`): Collapsed navigation rail
/// - **Desktop** (`≥ 1440dp`): Persistent drawer with extended rail
///
/// ## Features:
/// - Single source of truth for navigation items
/// - Automatic layout adaptation
/// - Customizable breakpoints and styling
/// - Support for drawer header/footer
/// - Integrated FAB positioning
///
/// ## Example:
/// ```dart
/// ResponsiveNavigationScaffold(
///   currentIndex: _selectedIndex,
///   onDestinationSelected: (index) => setState(() => _selectedIndex = index),
///   destinations: [
///     NavigationDestination(
///       icon: Icon(Icons.home_outlined),
///       selectedIcon: Icon(Icons.home),
///       label: 'Home',
///     ),
///     NavigationDestination(
///       icon: Icon(Icons.explore_outlined),
///       selectedIcon: Icon(Icons.explore),
///       label: 'Explore',
///     ),
///   ],
///   body: _pages[_selectedIndex],
///   title: Text('My App'),
/// )
/// ```
/// {@endtemplate}
class MyNavRail extends StatelessWidget {
  /// Currently selected navigation index
  final int currentIndex;

  /// Callback when navigation destination is selected
  final ValueChanged<int> onDestinationSelected;

  /// List of navigation destinations
  final List<NavigationMyDestination> destinations;

  /// Main content body
  final Widget body;

  /// App bar title widget
  final Widget? title;

  /// App bar action buttons
  final List<Widget>? actions;

  /// Floating action button
  final FloatingActionButton? floatingActionButton;

  /// Custom drawer header widget builder
  final WidgetBuilder? drawerHeader;

  /// Custom drawer footer widget builder
  final WidgetBuilder? drawerFooter;

  /// Global key for scaffold state control
  final GlobalKey<ScaffoldState>? scaffoldKey;

  /// Custom tablet breakpoint (default: 720dp)
  final double tabletBreakpoint;

  /// Custom desktop breakpoint (default: 1440dp)
  final double desktopBreakpoint;

  /// Minimum height threshold (default: 400dp)
  final double minHeight;

  /// Drawer width in desktop mode (default: 280dp)
  final double drawerWidth;

  /// Bottom navigation bar type
  final NavigationBarTheme? bottomNavigationTheme;

  /// Selected item color (defaults to theme primary)
  final Color? selectedItemColor;

  /// Unselected item color (defaults to theme outline)
  final Color? unselectedItemColor;

  /// Use compact navigation rail on tablet
  final bool useCompactRail;

  /// Hide app bar across all layouts
  final bool hideAppBar;

  /// Enable elevation on navigation components
  final bool elevation;

  /// {@macro responsive_navigation_scaffold}
  const MyNavRail({
    super.key,
    required this.currentIndex,
    required this.onDestinationSelected,
    required this.destinations,
    required this.body,
    this.title,
    this.actions,
    this.floatingActionButton,
    this.drawerHeader,
    this.drawerFooter,
    this.scaffoldKey,
    this.tabletBreakpoint = ResponsiveBreakpoints.tablet,
    this.desktopBreakpoint = ResponsiveBreakpoints.desktop,
    this.minHeight = ResponsiveBreakpoints.minHeight,
    this.drawerWidth = NavigationDimensions.drawerWidth,
    this.bottomNavigationTheme,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.useCompactRail = false,
    this.hideAppBar = false,
    this.elevation = true,
  }) : assert(
  destinations.length >= 2,
  'At least 2 destinations are required',
  ),
        assert(
        currentIndex >= 0 && currentIndex < destinations.length,
        'currentIndex must be within destinations range',
        );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        final theme = Theme.of(context);
        final colorScheme = theme.colorScheme;

        final effectiveSelectedColor = selectedItemColor ?? colorScheme.primary;
        final effectiveUnselectedColor =
            unselectedItemColor ?? colorScheme.onSurfaceVariant;

        // Desktop layout: Persistent drawer
        if (width >= desktopBreakpoint && height > minHeight) {
          return _DesktopNavigationLayout(
            destinations: destinations,
            currentIndex: currentIndex,
            onDestinationSelected: onDestinationSelected,
            body: body,
            title: title,
            actions: actions,
            floatingActionButton: floatingActionButton,
            drawerHeader: drawerHeader,
            drawerFooter: drawerFooter,
            drawerWidth: drawerWidth,
            scaffoldKey: scaffoldKey,
            hideAppBar: hideAppBar,
            selectedItemColor: effectiveSelectedColor,
            elevation: elevation,
          );
        }

        // Tablet layout: Navigation rail
        if (width >= tabletBreakpoint && height > minHeight) {
          return _TabletNavigationLayout(
            destinations: destinations,
            currentIndex: currentIndex,
            onDestinationSelected: onDestinationSelected,
            body: body,
            title: title,
            actions: actions,
            floatingActionButton: floatingActionButton,
            drawerHeader: drawerHeader,
            drawerFooter: drawerFooter,
            scaffoldKey: scaffoldKey,
            hideAppBar: hideAppBar,
            useCompactRail: useCompactRail,
            selectedItemColor: effectiveSelectedColor,
            unselectedItemColor: effectiveUnselectedColor,
            elevation: elevation,
          );
        }

        // Mobile layout: Bottom navigation bar
        return _MobileNavigationLayout(
          destinations: destinations,
          currentIndex: currentIndex,
          onDestinationSelected: onDestinationSelected,
          body: body,
          title: title,
          actions: actions,
          floatingActionButton: floatingActionButton,
          drawerHeader: drawerHeader,
          drawerFooter: drawerFooter,
          scaffoldKey: scaffoldKey,
          hideAppBar: hideAppBar,
          navigationBarTheme: bottomNavigationTheme,
          selectedItemColor: effectiveSelectedColor,
          unselectedItemColor: effectiveUnselectedColor,
          elevation: elevation,
        );
      },
    );
  }
}

/// Navigation destination item with icon and label
class NavigationMyDestination {
  /// Icon displayed when destination is not selected
  final Widget icon;

  /// Icon displayed when destination is selected
  final Widget? selectedIcon;

  /// Label text for the destination
  final String label;

  /// Optional badge to display on the destination
  final Widget? badge;

  /// Tooltip for accessibility
  final String? tooltip;

  const NavigationMyDestination({
    required this.icon,
    required this.label,
    this.selectedIcon,
    this.badge,
    this.tooltip,
  });

  /// Convert to Material 3 NavigationDestination
  BottomNavigationBarItem toMaterial3() => BottomNavigationBarItem(
    icon: badge != null ? Badge(child: icon) : icon,
    activeIcon: selectedIcon,
    label: label,
    tooltip: tooltip,
  );

  /// Convert to NavigationRailDestination
  NavigationRailDestination toRailDestination() =>
      NavigationRailDestination(
        icon: badge != null ? Badge(child: icon) : icon,
        selectedIcon: selectedIcon ?? icon,
        label: Text(label),
        padding: const EdgeInsets.symmetric(vertical: 4),
      );
}

// =============================================================================
// Layout Implementations
// =============================================================================

/// Desktop layout with persistent drawer
class _DesktopNavigationLayout extends StatelessWidget {
  const _DesktopNavigationLayout({
    required this.destinations,
    required this.currentIndex,
    required this.onDestinationSelected,
    required this.body,
    required this.drawerWidth,
    required this.selectedItemColor,
    required this.elevation,
    this.title,
    this.actions,
    this.floatingActionButton,
    this.drawerHeader,
    this.drawerFooter,
    this.scaffoldKey,
    required this.hideAppBar,
  });

  final List<NavigationMyDestination> destinations;
  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;
  final Widget body;
  final Widget? title;
  final List<Widget>? actions;
  final FloatingActionButton? floatingActionButton;
  final WidgetBuilder? drawerHeader;
  final WidgetBuilder? drawerFooter;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final double drawerWidth;
  final Color selectedItemColor;
  final bool hideAppBar;
  final bool elevation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: theme.scaffoldBackgroundColor,
      child: Row(
        children: [
          // Persistent navigation drawer
          Container(
            width: drawerWidth,
            decoration: elevation
                ? BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: theme.dividerColor,
                  width: 1,
                ),
              ),
            )
                : null,
            child: _PersistentDrawerContent(
              destinations: destinations,
              currentIndex: currentIndex,
              onDestinationSelected: onDestinationSelected,
              header: drawerHeader?.call(context),
              footer: drawerFooter?.call(context),
              selectedItemColor: selectedItemColor,
            ),
          ),
          // Main content area
          Expanded(
            child: Scaffold(
              key: scaffoldKey,
              appBar: hideAppBar
                  ? null
                  : AppBar(
                title: title,
                actions: actions,
                automaticallyImplyLeading: false,
                elevation: elevation ? null : 0,
              ),
              body: body,
              floatingActionButton: floatingActionButton,
              floatingActionButtonLocation:
              FloatingActionButtonLocation.endFloat,
            ),
          ),
        ],
      ),
    );
  }
}

/// Tablet layout with navigation rail
class _TabletNavigationLayout extends StatelessWidget {
  const _TabletNavigationLayout({
    required this.destinations,
    required this.currentIndex,
    required this.onDestinationSelected,
    required this.body,
    required this.selectedItemColor,
    required this.unselectedItemColor,
    required this.elevation,
    this.title,
    this.actions,
    this.floatingActionButton,
    this.drawerHeader,
    this.drawerFooter,
    this.scaffoldKey,
    required this.hideAppBar,
    required this.useCompactRail,
  });

  final List<NavigationMyDestination> destinations;
  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;
  final Widget body;
  final Widget? title;
  final List<Widget>? actions;
  final FloatingActionButton? floatingActionButton;
  final WidgetBuilder? drawerHeader;
  final WidgetBuilder? drawerFooter;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final Color selectedItemColor;
  final Color unselectedItemColor;
  final bool hideAppBar;
  final bool useCompactRail;
  final bool elevation;

  @override
  Widget build(BuildContext context) {
    final hasDrawerContent = drawerHeader != null || drawerFooter != null;

    return Scaffold(
      key: scaffoldKey,
      appBar: hideAppBar
          ? null
          : AppBar(
        title: title,
        actions: actions,
        elevation: elevation ? null : 0,
      ),
      drawer: hasDrawerContent
          ? _ModalDrawerContent(
        header: drawerHeader?.call(context),
        footer: drawerFooter?.call(context),
      )
          : null,
      body: Row(
        children: [
          // Navigation rail
          _NavigationRailWidget(
            destinations: destinations,
            currentIndex: currentIndex,
            onDestinationSelected: onDestinationSelected,
            extended: false,
            useCompact: useCompactRail,
            selectedItemColor: selectedItemColor,
            unselectedItemColor: unselectedItemColor,
            elevation: elevation,
          ),
          const VerticalDivider(width: 1),
          // Main content
          Expanded(child: body),
        ],
      ),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

/// Mobile layout with bottom navigation bar
class _MobileNavigationLayout extends StatelessWidget {
  const _MobileNavigationLayout({
    required this.destinations,
    required this.currentIndex,
    required this.onDestinationSelected,
    required this.body,
    required this.selectedItemColor,
    required this.elevation,
    this.title,
    this.actions,
    this.floatingActionButton,
    this.drawerHeader,
    this.drawerFooter,
    this.scaffoldKey,
    required this.hideAppBar,
    this.navigationBarTheme,
    this.unselectedItemColor,
  });

  final List<NavigationMyDestination> destinations;
  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;
  final Widget body;
  final Widget? title;
  final List<Widget>? actions;
  final FloatingActionButton? floatingActionButton;
  final WidgetBuilder? drawerHeader;
  final WidgetBuilder? drawerFooter;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final bool hideAppBar;
  final NavigationBarTheme? navigationBarTheme;
  final Color selectedItemColor;
  final Color? unselectedItemColor;
  final bool elevation;

  @override
  Widget build(BuildContext context) {
    final hasDrawerContent = drawerHeader != null || drawerFooter != null;

    return Scaffold(
      key: scaffoldKey,
      appBar: hideAppBar
          ? null
          : AppBar(
        title: title,
        actions: actions,
        elevation: elevation ? null : 0,
      ),
      drawer: hasDrawerContent
          ? _ModalDrawerContent(
        header: drawerHeader?.call(context),
        footer: drawerFooter?.call(context),
      )
          : null,
      body: body,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onDestinationSelected,
        items: destinations.map((d) => d.toMaterial3()).toList(),
        elevation: elevation ? null : 0,
      ),
    );
  }
}

// =============================================================================
// Shared Navigation Widgets
// =============================================================================

/// Navigation rail widget
class _NavigationRailWidget extends StatelessWidget {
  const _NavigationRailWidget({
    required this.destinations,
    required this.currentIndex,
    required this.onDestinationSelected,
    required this.extended,
    required this.useCompact,
    required this.selectedItemColor,
    required this.unselectedItemColor,
    required this.elevation,
  });

  final List<NavigationMyDestination> destinations;
  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;
  final bool extended;
  final bool useCompact;
  final Color selectedItemColor;
  final Color unselectedItemColor;
  final bool elevation;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      extended: extended,
      minWidth: useCompact
          ? NavigationDimensions.compactRailWidth
          : NavigationDimensions.railWidth,
      minExtendedWidth: NavigationDimensions.extendedRailWidth,
      selectedIndex: currentIndex,
      onDestinationSelected: onDestinationSelected,
      labelType: extended ? null : NavigationRailLabelType.all,
      selectedIconTheme: IconThemeData(
        color: selectedItemColor,
        size: 24,
      ),
      selectedLabelTextStyle: TextStyle(
        color: selectedItemColor,
        fontWeight: FontWeight.w600,
      ),
      unselectedIconTheme: IconThemeData(
        color: unselectedItemColor,
        size: 24,
      ),
      unselectedLabelTextStyle: TextStyle(
        color: unselectedItemColor,
      ),
      destinations: destinations.map((d) => d.toRailDestination()).toList(),
      elevation: elevation ? 1 : 0,
    );
  }
}

/// Persistent drawer content for desktop
class _PersistentDrawerContent extends StatelessWidget {
  const _PersistentDrawerContent({
    required this.destinations,
    required this.currentIndex,
    required this.onDestinationSelected,
    required this.selectedItemColor,
    this.header,
    this.footer,
  });

  final List<NavigationMyDestination> destinations;
  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;
  final Widget? header;
  final Widget? footer;
  final Color selectedItemColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: theme.colorScheme.surface,
      child: SafeArea(
        child: Column(
          children: [
            if (header != null) header!,
            Expanded(
              child: _NavigationRailWidget(
                destinations: destinations,
                currentIndex: currentIndex,
                onDestinationSelected: onDestinationSelected,
                extended: true,
                useCompact: false,
                selectedItemColor: selectedItemColor,
                unselectedItemColor: theme.colorScheme.onSurfaceVariant,
                elevation: false,
              ),
            ),
            if (footer != null) footer!,
          ],
        ),
      ),
    );
  }
}

/// Modal drawer content for mobile/tablet
class _ModalDrawerContent extends StatelessWidget {
  const _ModalDrawerContent({
    this.header,
    this.footer,
  });

  final Widget? header;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            if (header != null) header!,
            const Spacer(),
            if (footer != null) footer!,
          ],
        ),
      ),
    );
  }
}