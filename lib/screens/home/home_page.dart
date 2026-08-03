import 'dart:io';

import 'package:Echo/themes/colors.dart';
import 'package:Echo/themes/typography.dart';
import 'package:expressive_refresh/expressive_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:Echo/core/utils/service_locator.dart';
import 'package:Echo/screens/home/cubit/home_cubit.dart';
import 'package:Echo/core/widgets/section_item.dart';
import 'package:Echo/core/widgets/premium_surface.dart';
import 'package:Echo/utils/internet_guard.dart';
import 'package:loading_indicator_m3e/loading_indicator_m3e.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../generated/l10n.dart';
import '../../utils/adaptive_widgets/adaptive_widgets.dart';
import '../../themes/text_styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(sl())..fetch(),
      child: _HomePage(),
    );
  }
}

class _HomePage extends StatefulWidget {
  const _HomePage();

  @override
  State<_HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _checkFirstLaunch();
  }

  Future<void> _checkFirstLaunch() async {
    // Import hive at the top
    final box = Hive.box('SETTINGS');
    final hasSeenSupport = box.get(
      'has_seen_support_dialog',
      defaultValue: false,
    );

    if (!hasSeenSupport) {
      // Wait for the frame to build before showing dialog
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showSupportDialog();
      });
      await box.put('has_seen_support_dialog', true);
    }
  }

  void _showSupportDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Support Echo Music'),
        content: const Text(
          'This app requires time and hard work to develop and maintain. '
        'If you enjoy using Echo Music, please consider supporting the developer.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Maybe Later'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.of(context).pop();
              final uri = Uri.parse('https://support.iad1tya.cyou/');
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              }
            },
            child: const Text('Support'),
          ),
        ],
      ),
    );
  }

  Future<void> _scrollListener() async {
    if (!_scrollController.hasClients) return;
    if (_scrollController.position.pixels >=
      _scrollController.position.maxScrollExtent - 220) {
      await context.read<HomeCubit>().fetchNext();
      }
  }

  @override
  void dispose() {
    _scrollController
    ..removeListener(_scrollListener)
    ..dispose();
    super.dispose();
  }

  Widget _hero(BuildContext context) {
    final scheme = AppColors.colorScheme(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 18),
      child: PremiumSurface(
        padding: const EdgeInsets.all(24),
        borderRadius: BorderRadius.circular(30),
        color: scheme.primary.withValues(alpha: 0.12),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 620;
            final copy = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'YOUR DAILY SOUNDTRACK',
                  style: appTextTheme().labelMedium?.copyWith(
                    color: scheme.primary,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.7,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Find your next\nfavorite sound.',
                  style: appTextTheme().headlineMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    height: 1.05,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Fresh charts, mixes, and deep cuts — all in one calm listening space.',
                  style: appTextTheme().bodyMedium?.copyWith(
                    color: scheme.onSurface.withValues(alpha: 0.72),
                  ),
                ),
                const SizedBox(height: 18),
                FilledButton.icon(
                  onPressed: () => context.push('/search'),
                  icon: const Icon(Icons.search_rounded),
                  label: const Text('Search music'),
                ),
              ],
            );
            final visual = Container(
              width: compact ? double.infinity : 190,
              height: compact ? 110 : 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    scheme.primary.withValues(alpha: 0.85),
                    scheme.secondary.withValues(alpha: 0.55),
                  ],
                ),
              ),
              child: Icon(
                Icons.graphic_eq_rounded,
                size: compact ? 56 : 74,
                color: scheme.onPrimary.withValues(alpha: 0.92),
              ),
            );

            if (compact) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [copy, const SizedBox(height: 18), visual],
              );
            }
            return Row(
              children: [
                Expanded(child: copy),
                const SizedBox(width: 24),
                visual,
              ],
            );
          },
        ),
      ),
    );
  }

  // Future<void> refresh() async {
  //   if (initialLoading) return;
  //   Map<String, dynamic> home = await ytMusic.browse();
  //   if (mounted) {
  //     setState(() {
  //       initialLoading = false;
  //       nextLoading = false;
  //       chips = home['chips'] ?? [];
  //       sections = home['sections'];
  //       continuation = home['continuation'];
  //     });
  //   }
  // }

  Widget _horizontalChipsRow(List data) {
    final scheme = Theme.of(context).colorScheme;
    var list = <Widget>[const SizedBox(width: 16)];
    for (var element in data) {
      list.add(
        AdaptiveInkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () => context.go('/chip', extra: element),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHighest.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.outline(context).withValues(alpha: 0.12)),
            ),
            child: Text(element['title']),
          ),
        ),
      );
      list.add(const SizedBox(width: 8));
    }
    list.add(const SizedBox(width: 8));
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: list),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InternetGuard(
      onInternetRestored: context.read<HomeCubit>().fetch,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: AppBar().preferredSize,
          child: AppBar(
            automaticallyImplyLeading: false,
            title: Text('Echo Music', style: appBarTitleStyle()),
            centerTitle: true,
          ),
        ),
        body: ExpressiveRefreshIndicator(
          onRefresh: context.read<HomeCubit>().refresh,
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              switch (state) {
                case HomeLoading():
                  return Center(child: LoadingIndicatorM3E());
                case HomeError():
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: PremiumSurface(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.cloud_off_rounded,
                              size: 42,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(height: 12),
                            const Text('Could not load your feed'),
                            const SizedBox(height: 6),
                            Text(
                              'Check your connection and try again.',
                              style: TextStyle(
                                color: AppColors.colorScheme(context).onSurface.withValues(alpha: 0.65),
                              ),
                            ),
                            const SizedBox(height: 16),
                            FilledButton.icon(
                              onPressed: context.read<HomeCubit>().fetch,
                              icon: const Icon(Icons.refresh_rounded),
                              label: const Text('Try again'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                case HomeSuccess():
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    controller: _scrollController,
                    child: SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _hero(context),
                          _horizontalChipsRow(state.chips),
                          Column(
                            children: [
                              ...state.sections.map((section) {
                                return SectionItem(section: section);
                              }),
                              if (!state.loadingMore &&
                                state.continuation != null)
                                const SizedBox(height: 50),
                                if (state.loadingMore)
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: ExpressiveLoadingIndicator(),
                                  ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}
