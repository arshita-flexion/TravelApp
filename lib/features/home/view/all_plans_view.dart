import 'package:codefest_travel_app/core/routes/app_routes.dart';
import 'package:codefest_travel_app/core/utils/navigator_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:codefest_travel_app/models/plan.dart';
import 'package:codefest_travel_app/core/constants/app_constants.dart';

class AllPlansView extends StatelessWidget {
  final List<Plan> plans;
  const AllPlansView({super.key, required this.plans});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'ALL PLANS',
          style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1, color: Colors.black),
        ),
      ),
      body: plans.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.explore_off, size: 48, color: Colors.black38),
                  const SizedBox(height: 16),
                  Text(
                    'No plans available',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: plans.length,
              itemBuilder: (context, index) {
                return _buildPlanCard(plans[index], theme);
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
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        plan.categoryName!.toUpperCase(),
                        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 0.5, color: Color(0xFF666666)),
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
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 11, letterSpacing: 1),
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
