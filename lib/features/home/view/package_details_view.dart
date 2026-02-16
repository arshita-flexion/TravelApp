import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:codefest_travel_app/models/plan.dart';
import 'package:codefest_travel_app/core/api_config/client/api_client.dart';
import 'package:codefest_travel_app/core/api_config/endpoints/api_endpoint.dart';
import 'package:codefest_travel_app/core/constants/app_constants.dart';
import 'package:codefest_travel_app/core/routes/app_routes.dart';
import 'package:codefest_travel_app/core/utils/navigator_service.dart';
import 'package:shimmer/shimmer.dart';

class PackageDetailsView extends StatefulWidget {
  final String planId;
  const PackageDetailsView({super.key, required this.planId});

  @override
  State<PackageDetailsView> createState() => _PackageDetailsViewState();
}

class _PackageDetailsViewState extends State<PackageDetailsView> {
  Plan? _plan;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchPlanDetails();
  }

  Future<void> _fetchPlanDetails() async {
    try {
      final apiClient = context.read<ApiClient>();
      final response = await apiClient.request(RequestType.GET, ApiEndPoint.planDetails(widget.planId));
      if (response['plan'] != null) {
        setState(() {
          _plan = Plan.fromJson(response['plan']);
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Plan not found';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (_isLoading) {
      return Scaffold(
        body: Shimmer.fromColors(
          baseColor: const Color(0xFFE0E0E0),
          highlightColor: const Color(0xFFF5F5F5),
          child: Column(
            children: [
              Container(height: 350, color: Colors.white),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height: 28, width: 200, color: Colors.white),
                      const SizedBox(height: 16),
                      Container(height: 16, width: 150, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (_errorMessage != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.black38),
              const SizedBox(height: 16),
              const Text(
                'Something went wrong',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {
                  setState(() {
                    _isLoading = true;
                    _errorMessage = null;
                  });
                  _fetchPlanDetails();
                },
                child: const Text(
                  'RETRY',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, letterSpacing: 1),
                ),
              ),
            ],
          ),
        ),
      );
    }

    final plan = _plan!;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context, plan),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitleSection(plan, theme),
                  const SizedBox(height: 20),
                  _buildInfoChips(plan),
                  const SizedBox(height: 24),
                  const Text(
                    'DESCRIPTION',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, letterSpacing: 1),
                  ),
                  const SizedBox(height: 8),
                  Text(plan.description, style: const TextStyle(color: Color(0xFF666666), height: 1.6, fontSize: 14)),
                  const SizedBox(height: 24),
                  _buildPricingSection(plan),
                  const SizedBox(height: 24),
                  _buildDeparturesSection(plan),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomButton(context, plan, theme),
    );
  }

  Widget _buildSliverAppBar(BuildContext context, Plan plan) {
    final images = plan.fullImagesList.isEmpty ? [AppConstants.placeholderImage] : plan.fullImagesList;
    return SliverAppBar(
      expandedHeight: 350,
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.white,
      leadingWidth: 70,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 400,
                viewportFraction: 1,
                autoPlay: images.length > 1,
                onPageChanged: (index, reason) {},
              ),
              items: images.map((url) {
                return Image.network(
                  url.isEmpty ? AppConstants.placeholderImage : url,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 400,
                    width: double.infinity,
                    color: const Color(0xFFF5F5F5),
                    child: const Center(child: Icon(Icons.image, size: 60, color: Colors.black26)),
                  ),
                );
              }).toList(),
            ),
            if (images.length > 1)
              Positioned(
                bottom: 16,
                right: 20,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${images.length} Photos',
                    style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleSection(Plan plan, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (plan.categoryName != null)
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(8)),
            child: Text(
              plan.categoryName!.toUpperCase(),
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
                color: Color(0xFF666666),
              ),
            ),
          ),
        Text(plan.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, letterSpacing: -0.5)),
        const SizedBox(height: 8),
        Text(plan.shortDescription, style: const TextStyle(color: Color(0xFF999999), fontSize: 15, height: 1.4)),
      ],
    );
  }

  Widget _buildInfoChips(Plan plan) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        _infoChip(Icons.schedule, plan.durationText),
        _infoChip(Icons.currency_rupee, '${plan.currency} ${plan.adultPrice.toStringAsFixed(0)}/adult'),
        if (plan.childPrice > 0)
          _infoChip(Icons.child_care, '${plan.currency} ${plan.childPrice.toStringAsFixed(0)}/child'),
        if (plan.nextDeparture != null)
          _infoChip(Icons.event_seat, '${plan.nextDeparture!.availableSeats} seats available'),
      ],
    );
  }

  Widget _infoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.black54),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF444444)),
          ),
        ],
      ),
    );
  }

  Widget _buildPricingSection(Plan plan) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('PRICING', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, letterSpacing: 1)),
          const SizedBox(height: 16),
          _priceRow('Adult', '${plan.currency} ${plan.adultPrice.toStringAsFixed(0)}', 'per person'),
          if (plan.childPrice > 0) ...[
            const SizedBox(height: 12),
            _priceRow('Child', '${plan.currency} ${plan.childPrice.toStringAsFixed(0)}', 'per child'),
          ],
        ],
      ),
    );
  }

  Widget _priceRow(String label, String price, String subtitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            Text(subtitle, style: const TextStyle(fontSize: 12, color: Color(0xFF999999))),
          ],
        ),
        Text(price, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
      ],
    );
  }

  Widget _buildDeparturesSection(Plan plan) {
    if (plan.departures.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('DEPARTURES', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, letterSpacing: 1)),
        const SizedBox(height: 12),
        ...plan.departures.map(
          (dep) => Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFEEEEEE)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(12)),
                  child: const Icon(Icons.calendar_today, size: 20, color: Colors.black54),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${DateFormat('dd MMM yyyy').format(dep.startDate)} - ${DateFormat('dd MMM yyyy').format(dep.endDate)}',
                        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${dep.availableSeats} seats available',
                        style: const TextStyle(color: Color(0xFF999999), fontSize: 12),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: dep.availabilityStatus == 'ongoing'
                        ? Colors.green.withValues(alpha: 0.1)
                        : Colors.orange.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    dep.availabilityStatus.toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                      color: dep.availabilityStatus == 'ongoing' ? Colors.green : Colors.orange,
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

  Widget _buildBottomButton(BuildContext context, Plan plan, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Price', style: TextStyle(color: Color(0xFF999999), fontSize: 12)),
              Text(
                plan.formattedAdultPrice,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.black),
              ),
            ],
          ),
          const SizedBox(width: 24),
          Expanded(
            child: GestureDetector(
              onTap: () => NavigatorService.pushNamed(AppRoutes.bookingRoute, arguments: plan),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(16)),
                child: Text(
                  'BOOK NOW',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 14, letterSpacing: 1),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
