import 'package:easymove/core/constants/app_colors.dart';
import 'package:easymove/core/constants/app_strings.dart';
import 'package:easymove/core/constants/app_styles.dart';
import 'package:easymove/core/widgets/app_bottom_navigation.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String _countryCode = ProfileStrings.countryCode;
  final _fields = <String, TextEditingController>{
    ProfileStrings.fullName: TextEditingController(),
    ProfileStrings.phoneNumber: TextEditingController(),
    ProfileStrings.email: TextEditingController(),
    ProfileStrings.dateOfBirth: TextEditingController(),
    ProfileStrings.gender: TextEditingController(),
    ProfileStrings.occupation: TextEditingController(),
    ProfileStrings.nationality: TextEditingController(),
    ProfileStrings.address: TextEditingController(),
    ProfileStrings.state: TextEditingController(),
    ProfileStrings.city: TextEditingController(),
    ProfileStrings.country: TextEditingController(),
    ProfileStrings.pinCode: TextEditingController(),
  };

  @override
  void dispose() {
    for (final controller in _fields.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProfileColors.background,
      appBar: AppBar(
        backgroundColor: ProfileColors.appBar,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 15),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          ProfileStrings.title,
          style: ProfileStyles.appBarTitle,
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(38, 17, 38, 14),
          child: Column(
            children: [
              _profileImage(),
              const SizedBox(height: 37),
              _field(ProfileStrings.fullName),
              _phoneField(),
              _field(ProfileStrings.email),
              Row(
                children: [
                  Expanded(child: _dateField()),
                  const SizedBox(width: 25),
                  Expanded(child: _dropdown()),
                ],
              ),
              _field(ProfileStrings.occupation),
              _field(ProfileStrings.nationality),
              _field(ProfileStrings.address),
              Row(
                children: [
                  Expanded(child: _field(ProfileStrings.state)),
                  const SizedBox(width: 25),
                  Expanded(child: _field(ProfileStrings.city)),
                ],
              ),
              Row(
                children: [
                  Expanded(child: _field(ProfileStrings.country)),
                  const SizedBox(width: 25),
                  Expanded(child: _field(ProfileStrings.pinCode)),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                height: 28,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(ProfileStrings.saveChanges),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ProfileColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                  ),
                  child: const Text(
                    ProfileStrings.saveChanges,
                    style: ProfileStyles.button,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNavigation(
        selectedIndex: 4,
        onItemSelected: (index) {
          if (index == 0 && Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  Widget _profileImage() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        const CircleAvatar(
          radius: 47,
          backgroundImage: NetworkImage(ProfileStrings.profileImage),
        ),
        Positioned(
          right: -2,
          bottom: -1,
          child: CircleAvatar(
            radius: 13,
            backgroundColor: ProfileColors.editBackground,
            child: Tooltip(
              message: ProfileStrings.edit,
              child: const Icon(
                Icons.edit,
                size: 14,
                color: ProfileColors.text,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _field(String label) {
    final controller = _fields[label]!;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: _labeledInput(
        label,
        TextFormField(
          controller: controller,
          style: ProfileStyles.input,
          decoration: _decoration(),
          validator: (value) =>
              value == null || value.trim().isEmpty ? label : null,
        ),
      ),
    );
  }

  Widget _phoneField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: _labeledInput(
        ProfileStrings.phoneNumber,
        Row(
          children: [
            SizedBox(
              width: 85,
              child: DropdownButtonFormField<String>(
                initialValue: _countryCode,
                items: const [
                  DropdownMenuItem(
                    value: '+91',
                    child: Text('+91', style: ProfileStyles.input),
                  ),
                  DropdownMenuItem(
                    value: '+233',
                    child: Text('+233', style: ProfileStyles.input),
                  ),
                  DropdownMenuItem(
                    value: '+90',
                    child: Text('+90', style: ProfileStyles.input),
                  ),
                  DropdownMenuItem(
                    value: '+44',
                    child: Text('+44', style: ProfileStyles.input),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _countryCode = value);
                  }
                },
                icon: const Icon(Icons.keyboard_arrow_down, size: 17),
                decoration: _decoration(),
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: TextFormField(
                controller: _fields[ProfileStrings.phoneNumber]!,
                style: ProfileStyles.input,
                decoration: _decoration(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dateField() {
    return _labeledInput(
      ProfileStrings.dateOfBirth,
      TextFormField(
        controller: _fields[ProfileStrings.dateOfBirth]!,
        readOnly: true,
        style: ProfileStyles.input,
        decoration: _decoration(suffixIcon: Icons.calendar_today_outlined),
        onTap: _selectDate,
        validator: (value) =>
            value == null || value.isEmpty ? ProfileStrings.dateOfBirth : null,
      ),
    );
  }

  Widget _dropdown() {
    return _labeledInput(
      ProfileStrings.gender,
      DropdownButtonFormField<String>(
        initialValue: null,
        items: const [
          DropdownMenuItem(
            value: ProfileStrings.female,
            child: Text(ProfileStrings.female, style: ProfileStyles.input),
          ),
          DropdownMenuItem(
            value: ProfileStrings.male,
            child: Text(ProfileStrings.male, style: ProfileStyles.input),
          ),
          DropdownMenuItem(
            value: ProfileStrings.other,
            child: Text(ProfileStrings.other, style: ProfileStyles.input),
          ),
        ],
        onChanged: (value) {
          if (value != null) {
            _fields[ProfileStrings.gender]!.text = value;
          }
        },
        icon: const Icon(Icons.keyboard_arrow_down, size: 15),
        decoration: _decoration(),
      ),
    );
  }

  Future<void> _selectDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2002, 1, 15),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (selectedDate == null) return;
    _fields[ProfileStrings.dateOfBirth]!.text =
        '${selectedDate.day.toString().padLeft(2, '0')} '
        '${_monthName(selectedDate.month)} ${selectedDate.year.toString().substring(2)}';
    setState(() {});
  }

  String _monthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  Widget _labeledInput(String label, Widget input) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, bottom: 3),
          child: Text(label, style: ProfileStyles.label),
        ),
        input,
      ],
    );
  }

  InputDecoration _decoration({IconData? suffixIcon, String? prefixText}) {
    return InputDecoration(
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      prefixText: prefixText,
      prefixStyle: ProfileStyles.input,
      suffixIcon: suffixIcon == null ? null : Icon(suffixIcon, size: 15),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: ProfileColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: ProfileColors.border),
      ),
    );
  }
}
