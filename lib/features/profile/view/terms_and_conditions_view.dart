import 'package:flutter/material.dart';

class TermsAndConditionsView extends StatelessWidget {
  const TermsAndConditionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'TERMS & CONDITIONS',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('1. AGREEMENT TO TERMS'),
            _sectionContent(
              'These Terms and Conditions constitute a legally binding agreement made between you, whether personally or on behalf of an entity and us, concerning your access to and use of the application.',
            ),
            const SizedBox(height: 24),
            _sectionTitle('2. USER REPRESENTATIONS'),
            _sectionContent(
              'By using the App, you represent and warrant that: (1) all registration information you submit will be true, accurate, current, and complete; (2) you will maintain the accuracy of such information and promptly update such registration information as necessary.',
            ),
            const SizedBox(height: 24),
            _sectionTitle('3. PROHIBITED ACTIVITIES'),
            _sectionContent(
              'You may not access or use the App for any purpose other than that for which we make the App available. The App may not be used in connection with any commercial endeavors except those that are specifically endorsed or approved by us.',
            ),
            const SizedBox(height: 24),
            _sectionTitle('4. BOOKING POLICIES'),
            _sectionContent(
              'All bookings made through the App are subject to availability and confirmation. Cancellation policies vary by provider and will be clearly communicated during the booking process.',
            ),
            const SizedBox(height: 40),
            Center(
              child: Text(
                'Last Updated: February 2026',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Satoshi',
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900, letterSpacing: 1, color: Colors.black),
      ),
    );
  }

  Widget _sectionContent(String content) {
    return Text(
      content,
      style: const TextStyle(
        fontSize: 14,
        color: Color(0xFF666666),
        height: 1.6,
        fontFamily: 'Satoshi',
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
