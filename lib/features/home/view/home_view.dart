import 'package:codefest_travel_app/core/utils/app_exports.dart';
import 'package:codefest_travel_app/features/home/bloc/home_bloc.dart';
import 'package:codefest_travel_app/features/auth/bloc/auth_bloc.dart';
import 'package:codefest_travel_app/features/profile/bloc/profile_bloc.dart';
import 'package:codefest_travel_app/models/category.dart';
import 'package:codefest_travel_app/models/plan.dart';
import 'package:codefest_travel_app/core/constants/app_constants.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(LoadHomeDataRequested());
    context.read<ProfileBloc>().add(LoadProfileRequested());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          _buildHeader(theme),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'CATEGORIES',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 1),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildCategorySection(theme),
                  const SizedBox(height: 20),
                  _buildSectionTitle(
                    'TRENDING PLANS',
                    theme,
                    onSeeAll: () {
                      final plans = context.read<HomeBloc>().state.plans;
                      NavigatorService.pushNamed(AppRoutes.allPlansRoute, arguments: plans);
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildTrendingPlansList(theme),
                  const SizedBox(height: 20),
                  _buildSectionTitle(
                    'Upcoming Plans',
                    theme,
                    onSeeAll: () {
                      final plans = context.read<HomeBloc>().state.upcomingPlans;
                      NavigatorService.pushNamed(AppRoutes.allPlansRoute, arguments: plans);
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildExplorePlansList(theme),
                  const SizedBox(height: 20), // Space for bottom nav
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, profileState) {
        return BlocBuilder<AuthBloc, AuthState>(
          builder: (context, authState) {
            final user = profileState.user ?? authState.user;
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10, offset: const Offset(0, 2)),
                ],
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: const Color(0xFFF5F5F5),
                            backgroundImage: NetworkImage(
                              user?.fullProfileImageUrl ??
                                  'https://t3.ftcdn.net/jpg/08/05/28/22/360_F_805282248_LHUxw7t2pnQ7x8lFEsS2IZgK8IGFXePS.jpg',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'HELLO, ${user?.name?.toUpperCase() ?? 'TRAVELER'} 👋',
                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900, letterSpacing: 1),
                                ),
                                const Text(
                                  'Explore the world',
                                  style: TextStyle(color: Color(0xFF999999), fontSize: 13, fontFamily: 'Satoshi'),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 30),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildSearchField(theme),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCategorySection(ThemeData theme) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.status == HomeStatus.loading) {
          return _buildCategoryShimmer();
        }
        if (state.categories.isEmpty) {
          return const SizedBox.shrink();
        }
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            spacing: 20.0,
            children: List.generate(state.categories.length, (index) {
              final category = state.categories[index];
              return _categoryItem(category, theme);
            }),
          ),
        );
      },
    );
  }

  Widget _categoryItem(Category category, ThemeData theme) {
    return GestureDetector(
      onTap: () => NavigatorService.pushNamed(AppRoutes.categoryPackagesRoute, arguments: category),
      child: Column(
        children: [
          Container(
            width: 65,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFEEEEEE)),
            ),
            child: category.fullCoverImageUrl.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      category.fullCoverImageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(Icons.category, color: Colors.black, size: 24),
                    ),
                  )
                : const Icon(Icons.category, color: Colors.black, size: 24),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 70,
            child: Text(
              category.name.toUpperCase(),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 0.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField(ThemeData theme) {
    return InkWell(
      onTap: () => NavigatorService.pushNamed(AppRoutes.searchRoute),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(16)),
        child: Row(
          children: [
            Image.asset(
              'assets/images/png/others/png_search.png',
              width: 20,
              height: 20,
              color: const Color(0xFF999999),
            ),
            const SizedBox(width: 12),
            Text(
              'Search your destination...',
              style: TextStyle(color: Color(0xFF999999), fontSize: 15, fontFamily: 'Satoshi'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, ThemeData theme, {VoidCallback? onSeeAll}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 1)),
          TextButton(
            onPressed: onSeeAll,
            child: const Text(
              'SEE ALL',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 12, letterSpacing: 1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingPlansList(ThemeData theme) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.status == HomeStatus.loading) {
          return _buildTrendingPlansShimmer();
        }
        final trendingPlans = state.plans.take(3).toList();
        if (trendingPlans.isEmpty) {
          return const SizedBox.shrink();
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: 20.0,
            children: List.generate(trendingPlans.length, (index) {
              final plan = trendingPlans[index];
              return _buildPlanCard(plan, theme);
            }),
          ),
        );
      },
    );
  }

  Widget _buildExplorePlansList(ThemeData theme) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.status == HomeStatus.loading) {
          return _buildExplorePlansShimmer();
        }
        final explorePlans = state.upcomingPlans;
        if (explorePlans.isEmpty) {
          return const SizedBox.shrink();
        }
        return ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: explorePlans.length,
          itemBuilder: (context, index) {
            final plan = explorePlans[index];
            return PlanHorizontalCard(plan: plan);
          },
        );
      },
    );
  }

  Widget _buildPlanCard(Plan plan, ThemeData theme) {
    final nextDeparture = plan.nextDeparture;
    return GestureDetector(
      onTap: () => NavigatorService.pushNamed(AppRoutes.packageDetailsRoute, arguments: plan.id),
      child: Container(
        width: 220,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFEEEEEE)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              child: Stack(
                children: [
                  Image.network(
                    plan.fullCoverImageUrl.isEmpty ? AppConstants.placeholderImage : plan.fullCoverImageUrl,
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 160,
                      width: double.infinity,
                      color: const Color(0xFFF5F5F5),
                      child: const Center(child: Icon(Icons.image, size: 40, color: Colors.black26)),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        plan.durationText,
                        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plan.name.toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14, letterSpacing: -0.5),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    plan.shortDescription,
                    style: const TextStyle(color: Color(0xFF999999), fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        plan.formattedPrice,
                        style: const TextStyle(fontWeight: FontWeight.w900, color: Colors.black, fontSize: 16),
                      ),
                      if (nextDeparture != null)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '${nextDeparture.availableSeats} seats',
                            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 10),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryShimmer() {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFEEEEEE),
      highlightColor: const Color(0xFFF9F9F9),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          spacing: 20.0,
          children: List.generate(5, (index) {
            return Column(
              children: [
                Container(
                  width: 65,
                  height: 80,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 50,
                  height: 10,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildTrendingPlansShimmer() {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFEEEEEE),
      highlightColor: const Color(0xFFF9F9F9),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          spacing: 20.0,
          children: List.generate(3, (index) {
            return Container(
              width: 220,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFEEEEEE)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 160,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 120,
                          height: 14,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: 180,
                          height: 12,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 60,
                              height: 16,
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                            ),
                            Container(
                              width: 40,
                              height: 16,
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildExplorePlansShimmer() {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFEEEEEE),
      highlightColor: const Color(0xFFF9F9F9),
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16, left: 20.0, right: 20.0),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: const Color(0xFFEEEEEE)),
            ),
            child: Row(
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 120,
                        height: 14,
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 180,
                        height: 12,
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 60,
                            height: 16,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                          ),
                          Container(
                            width: 40,
                            height: 16,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class PlanHorizontalCard extends StatelessWidget {
  final Plan plan;
  const PlanHorizontalCard({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => NavigatorService.pushNamed(AppRoutes.packageDetailsRoute, arguments: plan.id),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16, left: 20.0, right: 20.0),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFEEEEEE)),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                plan.fullCoverImageUrl.isEmpty ? AppConstants.placeholderImage : plan.fullCoverImageUrl,
                width: 90,
                height: 90,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 90,
                  height: 90,
                  color: const Color(0xFFF5F5F5),
                  child: const Center(child: Icon(Icons.image, size: 32, color: Colors.black26)),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plan.name.toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14, letterSpacing: -0.5),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    plan.shortDescription,
                    style: const TextStyle(color: Color(0xFF999999), fontSize: 12, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        plan.formattedPrice,
                        style: const TextStyle(fontWeight: FontWeight.w900, color: Colors.black, fontSize: 16),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.schedule, size: 12, color: Colors.black),
                            const SizedBox(width: 4),
                            Text(plan.durationText, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 10)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
