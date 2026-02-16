import 'package:flutter/material.dart';

class FAQView extends StatelessWidget {
  const FAQView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        title: const Text(
          'FAQs',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 16, letterSpacing: 1),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: const Color(0xFFEEEEEE), height: 1),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          _buildFAQItem(
            'How do I book a trip?',
            'You can book a trip by selecting a travel package from the home screen, choosing your preferred date, adding personal details, and confirming the booking.',
          ),
          const SizedBox(height: 16),
          _buildFAQItem(
            'Can I cancel my booking?',
            'Yes, you can cancel your booking through the Booking History section. Please note that cancellation policies depend on the specific package and timing.',
          ),
          const SizedBox(height: 16),
          _buildFAQItem(
            'What payment methods are accepted?',
            'We currently support major credit/debit cards, UPI, and net banking for all travel bookings.',
          ),
          const SizedBox(height: 16),
          _buildFAQItem(
            'How do I update my profile?',
            'Go to the Profile tab, click on the edit icon in the top right corner of the header, update your details, and click "Save & Continue".',
          ),
          const SizedBox(height: 16),
          _buildFAQItem(
            'Is the app secure?',
            'Yes, we use industry-standard encryption and secure API communication to protect your personal and payment data.',
          ),
        ],
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 14, fontFamily: 'Satoshi', color: Colors.black),
        ),
        shape: const RoundedRectangleBorder(side: BorderSide.none),
        iconColor: Colors.black,
        collapsedIconColor: const Color(0xFF999999),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        expandedAlignment: Alignment.centerLeft,
        children: [
          Text(
            answer,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF666666),
              height: 1.5,
              fontFamily: 'Satoshi',
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
