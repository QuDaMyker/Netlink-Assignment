import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gem_speak/common/constant/app_assets.dart';
import 'package:gem_speak/common/constant/app_colors.dart';
import 'package:gem_speak/common/constant/app_constants.dart';
import 'package:gem_speak/common/widgets/common_button.dart';
import 'package:gem_speak/common/widgets/loading_widget.dart';
import 'package:gem_speak/core/auth/bloc/auth_bloc.dart';
import 'package:gem_speak/utils/validators.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.maskGreen.withValues(alpha: 0.95),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthUnauthenticated) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message ?? 'Login failed')),
            );
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  _buildMainBody(context),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (BuildContext context, AuthState state) {
                      if (state is AuthLoading) {
                        return Positioned.fill(child: _buildOverlayLoading());
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOverlayLoading() {
    return LoadingWidget();
  }

  Column _buildMainBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildAppWelcome(),
        const SizedBox(height: 24),
        _buildForm(),
        SizedBox(height: 48),
        CommonButton(
          onPressed: () {
            FocusManager.instance.primaryFocus?.unfocus();
            if (_formKey.currentState?.validate() ?? false) {
              context.read<AuthBloc>().add(
                LoggedIn(
                  email: _emailController.text.trim(),
                  password: _passwordController.text.trim(),
                ),
              );
            }
          },
          text: 'Login',
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildTextFormField(
              labelText: 'Email',
              controller: _emailController,
              validator: Validators.emailValidator(),
            ),
            const SizedBox(height: 12),
            _buildTextFormField(
              labelText: 'Password',
              controller: _passwordController,
              validator: Validators.passwordValidator(),
              obscureText: _obscurePassword,
              isRequiredShowEye: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required String labelText,
    bool obscureText = false,
    bool isRequiredShowEye = false,
    TextInputType keyboardType = TextInputType.text,
    required TextEditingController controller,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: labelText,
        hintStyle: TextStyle(color: AppColors.textColor, fontSize: 16),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        filled: true,
        fillColor: AppColors.snow,
        suffixIcon:
            isRequiredShowEye
                ? IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                    color: AppColors.textColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                )
                : null,
      ),
      obscureText: obscureText,
    );
  }

  Column _buildAppWelcome() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 80,
          backgroundColor: AppColors.snow,
          child: Lottie.asset(
            AppAssets.owlBird,
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
        const Text(
          AppConstants.appName,
          style: TextStyle(fontSize: 48, color: AppColors.snow),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        const Text(
          'Login Page',
          style: TextStyle(fontSize: 28, color: AppColors.snow),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        const Text(
          'Welcome to the English Gem Speak App',
          style: TextStyle(fontSize: 16, color: AppColors.polar),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
