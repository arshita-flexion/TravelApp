import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:codefest_travel_app/features/home/bloc/home_bloc.dart';
import 'package:codefest_travel_app/models/plan.dart';
import 'package:codefest_travel_app/core/constants/app_constants.dart';
import 'package:codefest_travel_app/core/routes/app_routes.dart';
import 'package:codefest_travel_app/core/utils/navigator_service.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<HomeBloc>().add(SearchPackagesRequested(query));
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: TextField(
          controller: _searchController,
          autofocus: true,
          onChanged: _onSearchChanged,
          style: const TextStyle(fontFamily: 'Satoshi', fontWeight: FontWeight.bold),
          decoration: const InputDecoration(
            hintText: 'Search destination...',
            hintStyle: TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.normal),
            border: InputBorder.none,
          ),
        ),
        toolbarHeight: 90,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: const Color(0xFFEEEEEE), height: 1),
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.searchQuery.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.travel_explore, size: 60, color: Color(0xFFEEEEEE)),
                  const SizedBox(height: 16),
                  const Text(
                    'START EXPLORING',
                    style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 2, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Search for your next adventure!',
                    style: TextStyle(color: Color(0xFF999999), fontFamily: 'Satoshi'),
                  ),
                ],
              ),
            );
          }
          if (state.planSearchResults.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off, size: 64, color: Color(0xFFEEEEEE)),
                  SizedBox(height: 16),
                  Text(
                    'NO RESULTS FOUND',
                    style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w900, letterSpacing: 1),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: state.planSearchResults.length,
            itemBuilder: (context, index) {
              final plan = state.planSearchResults[index];
              return _buildPlanCard(plan, theme);
            },
          );
        },
      ),
    );
  }

  Widget _buildPlanCard(Plan plan, ThemeData theme) {
    final nextDeparture = plan.nextDeparture;
    return GestureDetector(
      onTap: () => NavigatorService.pushNamed(AppRoutes.packageDetailsRoute, arguments: plan.id),
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFEEEEEE)),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              child: Stack(
                children: [
                  Image.network(
                    plan.fullCoverImageUrl.isEmpty ? AppConstants.placeholderImage : plan.fullCoverImageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 200,
                      color: const Color(0xFFF5F5F5),
                      child: const Center(child: Icon(Icons.image, size: 48, color: Colors.black26)),
                    ),
                  ),
                  // Duration badge
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.schedule, color: Colors.white, size: 14),
                          const SizedBox(width: 4),
                          Text(
                            plan.durationText,
                            style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Availability badge
                  if (nextDeparture != null)
                    Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: nextDeparture.availabilityStatus == 'ongoing'
                              ? Colors.green.withValues(alpha: 0.85)
                              : Colors.orange.withValues(alpha: 0.85),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${nextDeparture.availableSeats} seats left',
                          style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category + Title
                  if (plan.categoryName != null)
                    Container(
                      margin: const EdgeInsets.only(bottom: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(6)),
                      child: Text(
                        plan.categoryName!.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                          color: Color(0xFF666666),
                        ),
                      ),
                    ),
                  Text(
                    plan.name,
                    style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  // Short description
                  Text(
                    plan.shortDescription,
                    style: const TextStyle(color: Color(0xFF999999), fontSize: 13, height: 1.3),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  // Departure dates
                  if (nextDeparture != null)
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 14, color: Color(0xFF999999)),
                        const SizedBox(width: 6),
                        Text(
                          '${DateFormat('dd MMM').format(nextDeparture.startDate)} - ${DateFormat('dd MMM yyyy').format(nextDeparture.endDate)}',
                          style: const TextStyle(color: Color(0xFF666666), fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  const SizedBox(height: 12),
                  // Price and button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Starting from', style: TextStyle(color: Color(0xFF999999), fontSize: 11)),
                          Text(
                            plan.formattedPrice,
                            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 20, color: Colors.black),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(12)),
                        child: const Text(
                          'VIEW DETAILS',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 11,
                            letterSpacing: 1,
                          ),
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
