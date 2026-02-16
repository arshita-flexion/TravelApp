import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:codefest_travel_app/features/profile/bloc/profile_bloc.dart';
import 'package:codefest_travel_app/models/booking.dart';
import 'package:intl/intl.dart';

class BookingHistoryView extends StatefulWidget {
  const BookingHistoryView({super.key});

  @override
  State<BookingHistoryView> createState() => _BookingHistoryViewState();
}

class _BookingHistoryViewState extends State<BookingHistoryView> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(LoadProfileRequested());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'BOOKINGS',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, letterSpacing: 2, fontSize: 18),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state.status == ProfileStatus.loading) {
            return const Center(child: CircularProgressIndicator(color: Colors.black));
          }
          if (state.bookingHistory.isEmpty) {
            return _buildEmptyState();
          }
          return RefreshIndicator(
            color: Colors.black,
            onRefresh: () async {
              context.read<ProfileBloc>().add(LoadProfileRequested());
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: state.bookingHistory.length,
              itemBuilder: (context, index) {
                final booking = state.bookingHistory[index];
                return _buildBookingCard(booking, theme);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.confirmation_number_outlined, size: 80, color: const Color(0xFFEEEEEE)),
          const SizedBox(height: 16),
          const Text(
            'NO BOOKINGS YET',
            style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w900, letterSpacing: 1),
          ),
          const SizedBox(height: 8),
          const Text(
            'Your travel history will appear here',
            style: TextStyle(color: Color(0xFF999999), fontFamily: 'Satoshi'),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingCard(Booking booking, ThemeData theme) {
    Color statusColor = Colors.orange;
    if (booking.status.name == 'confirmed') statusColor = Colors.green;
    if (booking.status.name == 'cancelled') statusColor = Colors.red;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(16)),
                  child: const Icon(Icons.flight_takeoff, color: Colors.black),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking.packageName.toUpperCase(),
                        style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14, letterSpacing: -0.5),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'ID: #${booking.bookingCode ?? booking.id.substring(booking.id.length - 8)}',
                        style: const TextStyle(color: Color(0xFF999999), fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(color: statusColor, borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    booking.status.name.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: Color(0xFFEEEEEE), indent: 20, endIndent: 20),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _infoColumn('DATE', DateFormat('dd MMM, yyyy').format(booking.date)),
                _infoColumn('TRAVELERS', '${booking.adults + booking.children} PERSONS'),
                _infoColumn('TOTAL', '₹${booking.totalAmount.toStringAsFixed(0)}', isBold: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoColumn(String label, String value, {bool isBold = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Color(0xFF999999), fontSize: 10, fontWeight: FontWeight.w900, letterSpacing: 1),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(fontWeight: isBold ? FontWeight.w900 : FontWeight.bold, fontSize: 14, fontFamily: 'Satoshi'),
        ),
      ],
    );
  }
}
