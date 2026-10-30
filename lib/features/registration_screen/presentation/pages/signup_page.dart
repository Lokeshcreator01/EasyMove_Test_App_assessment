import 'package:easymove/core/constants/api_Constsnts.dart';
import 'package:easymove/core/constants/app_colors.dart';
import 'package:easymove/core/constants/app_strings.dart';
import 'package:easymove/core/constants/app_styles.dart';
import 'package:easymove/features/registration_screen/presentation/pages/account_verified.dart';
import 'package:easymove/features/login_screen/presentation/cubit/user_cubit.dart';
import 'package:easymove/features/login_screen/presentation/cubit/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _occupationController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  bool _isUser = true;
  bool _acceptedTerms = false;
  bool _obscurePassword = true;
  String _countryCode = '+91';
  String _gender = 'Male';
  String? _dateOfBirth;
  String? _serviceOfInterest;
  String? _referralSource;

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _occupationController.dispose();
    _dateOfBirthController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration({String? hintText, Widget? suffixIcon}) {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(22),
        borderSide: const BorderSide(color: Color(0xFF9E9E9E)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(500),
        borderSide: const BorderSide(color: Color(0xFF9E9E9E)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(22),
        borderSide: BorderSide(color: App_Colors.PrimaryColor),
      ),
      suffixIcon: suffixIcon,
      hintText: hintText,
      hintStyle: AppStyles.input.copyWith(color: Colors.grey),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 14, bottom: 4),
      child: Text(text, style: AppStyles.label),
    );
  }

  Widget _selectField({
    required String label,
    required String? value,
    required List<String> options,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _label(label),
        DropdownButtonFormField<String>(
          initialValue: value,
          items: options
              .map(
                (option) => DropdownMenuItem(
                  value: option,
                  child: Text(option, style: AppStyles.input),
                ),
              )
              .toList(),
          onChanged: onChanged,
          icon: const Icon(Icons.keyboard_arrow_down, size: 20),
          decoration: _inputDecoration(),
        ),
      ],
    );
  }

  Future<void> _selectDateOfBirth() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2001, 10, 30),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (selectedDate == null) {
      return;
    }

    setState(() {
      _dateOfBirth =
          '${selectedDate.year.toString().padLeft(4, '0')}-'
          '${selectedDate.month.toString().padLeft(2, '0')}-'
          '${selectedDate.day.toString().padLeft(2, '0')}';
      _dateOfBirthController.text = _dateOfBirth!;
    });
  }

  Widget _roleOption(String title, bool selected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: selected,
            onChanged: (_) => onTap(),
            activeColor: App_Colors.PrimaryColor,
            checkColor: Colors.white,
            side: const BorderSide(color: Color(0xFF777777), width: 1.5),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          ),
          Text(title, style: AppStyles.role),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserSuccessState) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const AccountVerifiedPage()),
          );
        } else if (state is UserErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 19),
            onPressed: () => Navigator.maybePop(context),
          ),
          title: Text(App_text().Signup_text, style: AppStyles.appBarTitle),
          titleSpacing: 0,
          backgroundColor: App_Colors.AppBarColor,
          foregroundColor: const Color(0xFF1E1E1E),
          elevation: 0,
        ),
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(44, 18, 44, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _roleOption(
                        AuthStrings.user,
                        _isUser,
                        () => setState(() => _isUser = true),
                      ),
                      _roleOption(
                        AuthStrings.serviceProvider,
                        !_isUser,
                        () => setState(() => _isUser = false),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _label(AuthStrings.fullName),
                  TextFormField(
                    controller: _fullNameController,
                    style: AppStyles.input,
                    decoration: _inputDecoration(),
                  ),
                  const SizedBox(height: 11),
                  Row(
                    children: [
                      SizedBox(
                        width: 85,
                        child: DropdownButtonFormField<String>(
                          initialValue: _countryCode,
                          items: ['+91', '+233', '+90', '+44']
                              .map(
                                (code) => DropdownMenuItem(
                                  value: code,
                                  child: Text(
                                    code,
                                    style: AppStyles.dateOfBirth,
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) => setState(
                            () => _countryCode = value ?? _countryCode,
                          ),
                          icon: const Icon(Icons.keyboard_arrow_down, size: 17),
                          decoration: _inputDecoration(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _label(AuthStrings.phoneNumber),
                            TextFormField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              style: AppStyles.input,
                              decoration: _inputDecoration(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 11),
                  _label(AuthStrings.email),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: AppStyles.input,
                    decoration: _inputDecoration(),
                  ),
                  const SizedBox(height: 11),
                  _label(AuthStrings.password),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    style: AppStyles.input,
                    decoration: _inputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          size: 16,
                        ),
                        onPressed: () => setState(
                          () => _obscurePassword = !_obscurePassword,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 11),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _label(AuthStrings.dateOfBirth),
                            TextFormField(
                              readOnly: true,
                              controller: _dateOfBirthController,
                              style: AppStyles.input,
                              decoration: _inputDecoration(
                                suffixIcon: const Icon(
                                  Icons.calendar_today_outlined,
                                  size: 18,
                                ),
                              ),
                              onTap: _selectDateOfBirth,
                              validator: (value) => _dateOfBirth == null
                                  ? AuthStrings.selectDate
                                  : null,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 28),
                      Expanded(
                        child: _selectField(
                          label: AuthStrings.gender,
                          value: _gender,
                          options: [
                            AuthStrings.female,
                            AuthStrings.male,
                            AuthStrings.other,
                          ],
                          onChanged: (value) =>
                              setState(() => _gender = value ?? _gender),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 11),
                  _label(AuthStrings.occupation),
                  TextFormField(
                    controller: _occupationController,
                    style: AppStyles.input,
                    decoration: _inputDecoration(),
                  ),
                  const SizedBox(height: 11),
                  _selectField(
                    label: AuthStrings.serviceOfInterest,
                    value: _serviceOfInterest,
                    options: [
                      AuthStrings.realEstate,
                      AuthStrings.carRental,
                      AuthStrings.shortStays,
                    ],
                    onChanged: (value) =>
                        setState(() => _serviceOfInterest = value),
                  ),
                  const SizedBox(height: 11),
                  _selectField(
                    label: AuthStrings.howDidYouHear,
                    value: _referralSource,
                    options: [
                      AuthStrings.socialService,
                      AuthStrings.friendOrFamily,
                      AuthStrings.searchEngine,
                    ],
                    onChanged: (value) =>
                        setState(() => _referralSource = value),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    height: 31,
                    child: ElevatedButton(
                      onPressed: () {
                        if (!(_formKey.currentState?.validate() ?? false)) {
                          return;
                        }
                        if (!_acceptedTerms) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(AuthStrings.acceptTerms),
                            ),
                          );
                          return;
                        }
                        context.read<UserCubit>().getUser(
                          ApiConstsnts.auth_login,
                          body: {
                            'fullname': _fullNameController.text.trim(),
                            'email': _emailController.text.trim(),
                            'country_code': _countryCode,
                            'phone_no': _phoneController.text.trim(),
                            'dob': _dateOfBirth,
                            'gender': _gender,
                            'role': _isUser ? 'user' : 'service_provider',
                            'occupation': _occupationController.text.trim(),
                            'service_interest': [_serviceOfInterest],
                            'how_heard_about_us': _referralSource ?? '',
                            'agree_terms': _acceptedTerms,
                            'password': _passwordController.text,
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: App_Colors.PrimaryColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11),
                        ),
                      ),
                      child: BlocBuilder<UserCubit, UserState>(
                        builder: (context, state) {
                          return state is UserLoadingState
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  AuthStrings.submit,
                                  style: AppStyles.submit,
                                );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 17),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: _acceptedTerms,
                        onChanged: (value) =>
                            setState(() => _acceptedTerms = value ?? false),
                        activeColor: const Color(0xFF43B96A),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                      ),
                      const Text(AuthStrings.terms, style: AppStyles.terms),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          AuthStrings.termsAndConditions,
                          style: AppStyles.link.copyWith(
                            color: App_Colors.PrimaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        style: AppStyles.account,
                        children: [
                          const TextSpan(text: AuthStrings.haveAnAccount),
                          TextSpan(
                            text: AuthStrings.signInLink,
                            style: AppStyles.link.copyWith(
                              color: App_Colors.PrimaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
