import 'package:flutter/material.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'PRIVACY POLICY',
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
            _sectionTitle('1. INTRODUCTION'),
            _sectionContent(
              'Welcome to our Travel App. We are committed to protecting your personal information and your right to privacy. If you have any questions or concerns about this privacy notice, or our practices with regards to your personal information, please contact us.',
            ),
            const SizedBox(height: 24),
            _sectionTitle('2. INFORMATION WE COLLECT'),
            _sectionContent(
              'We collect personal information that you voluntarily provide to us when you register on the App, express an interest in obtaining information about us or our products and Services, when you participate in activities on the App or otherwise when you contact us.',
            ),
            const SizedBox(height: 24),
            _sectionTitle('3. HOW WE USE YOUR INFORMATION'),
            _sectionContent(
              'We use personal information collected via our App for a variety of business purposes described below. We process your personal information for these purposes in reliance on our legitimate business interests, in order to enter into or perform a contract with you, with your consent, and/or for compliance with our legal obligations.',
            ),
            const SizedBox(height: 24),
            _sectionTitle('4. SHARING YOUR INFORMATION'),
            _sectionContent(
              'We only share information with your consent, to comply with laws, to provide you with services, to protect your rights, or to fulfill business obligations.',
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
