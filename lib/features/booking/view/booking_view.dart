import 'package:codefest_travel_app/core/utils/app_exports.dart';
import 'package:intl/intl.dart';
import 'package:codefest_travel_app/models/plan.dart';
import 'package:codefest_travel_app/models/departure.dart';
import 'package:codefest_travel_app/features/profile/bloc/profile_bloc.dart';
import 'package:codefest_travel_app/repository/travel_repository.dart';

class BookingView extends StatefulWidget {
  final Plan plan;
  const BookingView({super.key, required this.plan});

  @override
  State<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {
  int _currentStep = 0;
  Departure? _selectedDeparture;
  int _adults = 1;
  int _children = 0;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _notesController = TextEditingController();

  bool _isBooking = false;
  String? _bookingCode;

  double get _totalPrice => (widget.plan.adultPrice * _adults) + (widget.plan.childPrice * _children);

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).customColors.blackColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'BOOK YOUR TRIP',
          style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1, color: Colors.white, fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildStepper(theme),
          Expanded(
            child: IndexedStack(
              index: _currentStep,
              children: [
                _buildStep1SelectDeparture(theme),
                _buildStep2PersonalDetails(theme),
                _buildStep3Success(theme),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepper(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _stepIndicator(0, 'Trip'),
          _stepLine(0),
          _stepIndicator(1, 'Details'),
          _stepLine(1),
          _stepIndicator(2, 'Done'),
        ],
      ),
    );
  }

  Widget _stepIndicator(int step, String label) {
    bool isActive = _currentStep >= step;
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(color: isActive ? Colors.black : const Color(0xFFE0E0E0), shape: BoxShape.circle),
          child: Center(
            child: isActive && _currentStep > step
                ? const Icon(Icons.check, color: Colors.white, size: 16)
                : Text(
                    '${step + 1}',
                    style: TextStyle(
                      color: isActive ? Colors.white : const Color(0xFF999999),
                      fontWeight: FontWeight.w900,
                      fontSize: 13,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: isActive ? Colors.black : const Color(0xFF999999),
          ),
        ),
      ],
    );
  }

  Widget _stepLine(int step) {
    bool isActive = _currentStep > step;
    return Container(
      width: 50,
      height: 2,
      color: isActive ? Colors.black : const Color(0xFFE0E0E0),
      margin: const EdgeInsets.only(bottom: 20),
    );
  }

  // ========== STEP 1 ==========

  Widget _buildStep1SelectDeparture(ThemeData theme) {
    final plan = widget.plan;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF9F9F9),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFEEEEEE)),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.network(
                    plan.fullCoverImageUrl,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 70,
                      height: 70,
                      color: const Color(0xFFE0E0E0),
                      child: Image.asset(Assets.images.appLogo, width: 40, height: 40, color: Colors.black26),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(plan.name, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 15)),
                      const SizedBox(height: 4),
                      Text(plan.durationText, style: const TextStyle(color: Color(0xFF999999), fontSize: 13)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          const Text('SELECT DEPARTURE', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, letterSpacing: 1)),
          const SizedBox(height: 14),
          if (plan.departures.isEmpty)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: const Color(0xFFF9F9F9), borderRadius: BorderRadius.circular(16)),
              child: const Center(
                child: Text('No departures available', style: TextStyle(color: Color(0xFF999999))),
              ),
            )
          else
            ...plan.departures.map((dep) {
              final isSelected = _selectedDeparture?.id == dep.id;
              final isOngoing = dep.availabilityStatus == 'ongoing';
              final isSelectable = dep.availableSeats > 0 && !isOngoing;

              return GestureDetector(
                onTap: isSelectable ? () => setState(() => _selectedDeparture = dep) : null,
                child: Opacity(
                  opacity: isSelectable || isSelected ? 1.0 : 0.4,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.black.withValues(alpha: 0.03) : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected ? Colors.black : const Color(0xFFEEEEEE),
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: isSelected ? Colors.black : const Color(0xFFCCCCCC), width: 2),
                            color: isSelected ? Colors.black : Colors.transparent,
                          ),
                          child: isSelected ? const Icon(Icons.check, color: Colors.white, size: 13) : null,
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
                                '${dep.availableSeats} seats left',
                                style: TextStyle(
                                  color: dep.availableSeats > 5 ? const Color(0xFF999999) : Colors.orange,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: dep.availabilityStatus == 'ongoing'
                                ? Colors.green.withValues(alpha: 0.1)
                                : Colors.orange.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            dep.availabilityStatus.toUpperCase(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: dep.availabilityStatus == 'ongoing' ? Colors.green : Colors.orange,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          const SizedBox(height: 28),
          const Text('TRAVELERS', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, letterSpacing: 1)),
          const SizedBox(height: 14),
          _counterRow(
            'Adults',
            plan.formattedAdultPrice,
            _adults,
            (val) => setState(() => _adults = val),
            minValue: 1,
            maxValue: _selectedDeparture != null ? _selectedDeparture!.availableSeats - _children : null,
          ),
          const SizedBox(height: 12),
          _counterRow(
            'Children',
            plan.formattedChildPrice,
            _children,
            (val) => setState(() => _children = val),
            minValue: 0,
            maxValue: _selectedDeparture != null ? _selectedDeparture!.availableSeats - _adults : null,
          ),
          const SizedBox(height: 28),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFF9F9F9),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFEEEEEE)),
            ),
            child: Column(
              children: [
                _summaryPriceRow(
                  'Adults',
                  '$_adults x ${plan.formattedAdultPrice}',
                  '${plan.currency} ${(plan.adultPrice * _adults).toStringAsFixed(0)}',
                ),
                if (_children > 0) ...[
                  const SizedBox(height: 8),
                  _summaryPriceRow(
                    'Children',
                    '$_children x ${plan.formattedChildPrice}',
                    '${plan.currency} ${(plan.childPrice * _children).toStringAsFixed(0)}',
                  ),
                ],
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Divider(height: 1, color: Color(0xFFE0E0E0)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                    Text(
                      '${plan.currency} ${_totalPrice.toStringAsFixed(0)}',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          GestureDetector(
            onTap: _selectedDeparture == null ? null : () => setState(() => _currentStep = 1),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: _selectedDeparture == null ? const Color(0xFFCCCCCC) : Colors.black,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Text(
                  'CONTINUE',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 14, letterSpacing: 1),
                ),
              ),
            ),
          ),
          if (_selectedDeparture == null)
            const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Center(
                child: Text('Please select a departure date', style: TextStyle(color: Color(0xFF999999), fontSize: 12)),
              ),
            ),
        ],
      ),
    );
  }

  Widget _counterRow(
    String label,
    String price,
    int value,
    Function(int) onChanged, {
    int minValue = 0,
    int? maxValue,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              const SizedBox(height: 2),
              Text(price, style: const TextStyle(color: Color(0xFF999999), fontSize: 13)),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: value > minValue ? () => onChanged(value - 1) : null,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: value > minValue ? Colors.black : const Color(0xFFE0E0E0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(child: Icon(Icons.remove, color: Colors.white, size: 18)),
                ),
              ),
              SizedBox(
                width: 48,
                child: Center(
                  child: Text('$value', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                ),
              ),
              GestureDetector(
                onTap: (maxValue == null || value < maxValue) ? () => onChanged(value + 1) : null,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: (maxValue == null || value < maxValue) ? Colors.black : const Color(0xFFE0E0E0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(child: Icon(Icons.add, color: Colors.white, size: 18)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryPriceRow(String label, String detail, String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            Text(detail, style: const TextStyle(color: Color(0xFF999999), fontSize: 12)),
          ],
        ),
        Text(price, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
      ],
    );
  }

  // ========== STEP 2 ==========

  Widget _buildStep2PersonalDetails(ThemeData theme) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'PERSONAL DETAILS',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, letterSpacing: 1),
            ),
            const SizedBox(height: 20),
            _buildTextField(_nameController, 'Full Name', imagePath: Assets.images.pngProfile),
            const SizedBox(height: 14),
            _buildTextField(_emailController, 'Email Address', imagePath: Assets.images.pngEmail, keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 14),
            _buildTextField(_mobileController, 'Mobile Number', imagePath: Assets.images.pngContact, keyboardType: TextInputType.phone),
            const SizedBox(height: 14),
            _buildTextField(_notesController, 'Notes', icon: Icons.note, isRequired: false),
            const SizedBox(height: 28),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFF9F9F9),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFEEEEEE)),
              ),
              child: Column(
                children: [
                  _infoRow('Plan', widget.plan.name),
                  const SizedBox(height: 8),
                  _infoRow('Duration', widget.plan.durationText),
                  if (_selectedDeparture != null) ...[
                    const SizedBox(height: 8),
                    _infoRow(
                      'Departure',
                      '${DateFormat('dd MMM yyyy').format(_selectedDeparture!.startDate)} - ${DateFormat('dd MMM yyyy').format(_selectedDeparture!.endDate)}',
                    ),
                  ],
                  const SizedBox(height: 8),
                  _infoRow('Travelers', '$_adults Adults${_children > 0 ? ', $_children Children' : ''}'),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Divider(height: 1, color: Color(0xFFE0E0E0)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                      Text(
                        '${widget.plan.currency} ${_totalPrice.toStringAsFixed(0)}',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            Row(
              children: [
                GestureDetector(
                  onTap: () => setState(() => _currentStep = 0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(16)),
                    child: const Text(
                      'BACK',
                      style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14, letterSpacing: 1),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: _isBooking
                        ? null
                        : () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                _isBooking = true;
                              });
                              try {
                                final repo = context.read<TravelRepository>();
                                final response = await repo.createBooking({
                                  "planId": widget.plan.id,
                                  "departureId": _selectedDeparture!.id,
                                  "adultCount": _adults,
                                  "childCount": _children,
                                  "contactName": _nameController.text,
                                  "contactEmail": _emailController.text,
                                  "contactMobile": _mobileController.text,
                                  "notes": _notesController.text,
                                });

                                if (response['booking'] != null) {
                                  // Refresh booking history in profile
                                  context.read<ProfileBloc>().add(LoadProfileRequested());

                                  setState(() {
                                    _bookingCode = response['booking']['bookingCode'];
                                    _currentStep = 2;
                                    _isBooking = false;
                                  });
                                } else {
                                  setState(() {
                                    _isBooking = false;
                                  });
                                  ScaffoldMessenger.of(
                                    context,
                                  ).showSnackBar(const SnackBar(content: Text('Failed to create booking')));
                                }
                              } catch (e) {
                                setState(() {
                                  _isBooking = false;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
                              }
                            }
                          },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(16)),
                      child: Center(
                        child: _isBooking
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                              )
                            : const Text(
                                'CONFIRM BOOKING',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 14,
                                  letterSpacing: 1,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    IconData? icon,
    String? imagePath,
    TextInputType? keyboardType,
    bool isRequired = true,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: const TextStyle(fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFF999999), fontWeight: FontWeight.w500),
        prefixIcon: Padding(
          padding: EdgeInsets.only(bottom: maxLines > 1 ? (maxLines * 10.0) : 0),
          child: imagePath != null
              ? Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(imagePath, color: Colors.black54, width: 20, height: 20),
                )
              : Icon(icon, color: Colors.black54, size: 20),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.black, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      validator: isRequired ? (val) => val == null || val.isEmpty ? 'This field is required' : null : null,
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Color(0xFF999999), fontSize: 13)),
        const SizedBox(width: 16),
        Flexible(
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  // ========== STEP 3 ==========

  Widget _buildStep3Success(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
            child: Image.asset(Assets.images.pngShield, color: Colors.white, width: 40, height: 40),
          ),
          const SizedBox(height: 24),
          const Text(
            'BOOKING CONFIRMED!',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, letterSpacing: 1),
          ),
          const SizedBox(height: 8),
          const Text(
            'Your booking has been successfully placed.',
            style: TextStyle(color: Color(0xFF999999), fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          if (_bookingCode != null)
            Text(
              'Booking ID: #$_bookingCode',
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 13),
            ),
          const SizedBox(height: 32),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFF9F9F9),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFEEEEEE)),
            ),
            child: Column(
              children: [
                _infoRow('Plan', widget.plan.name),
                const SizedBox(height: 8),
                _infoRow('Duration', widget.plan.durationText),
                if (_selectedDeparture != null) ...[
                  const SizedBox(height: 8),
                  _infoRow(
                    'Departure',
                    '${DateFormat('dd MMM').format(_selectedDeparture!.startDate)} - ${DateFormat('dd MMM').format(_selectedDeparture!.endDate)}',
                  ),
                ],
                const SizedBox(height: 8),
                _infoRow('Travelers', '$_adults Adults${_children > 0 ? ', $_children Children' : ''}'),
                const SizedBox(height: 8),
                _infoRow('Contact', _nameController.text),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Divider(height: 1, color: Color(0xFFE0E0E0)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total Paid', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                    Text(
                      '${widget.plan.currency} ${_totalPrice.toStringAsFixed(0)}',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          GestureDetector(
            onTap: () => NavigatorService.pushNamedAndRemoveUntil(AppRoutes.bottomNavigationView),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(16)),
              child: const Center(
                child: Text(
                  'GO TO HOME',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 14, letterSpacing: 1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
