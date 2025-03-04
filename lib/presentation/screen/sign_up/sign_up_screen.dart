import 'package:flutter/material.dart';
import 'package:flutter_chat_app/presentation/provider/auth_provider.dart';
import 'package:flutter_chat_app/presentation/screen/sign_up/sign_up_page.dart';
import 'package:flutter_chat_app/presentation/widget/expanded_progress_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  static const _pageCount = 4;
  final _pageController = PageController();
  final _currentPageProvider = StateProvider<int>((ref) => 0);
  final _isValidProvider = StateProvider<bool>((ref) => false);
  final _textControllers =
      List.generate(_pageCount, (_) => TextEditingController());
  final _errorTextProviders =
      List.generate(_pageCount, (_) => StateProvider<String?>((ref) => null));
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    ref.listenManual(_currentPageProvider, (previous, next) {
      ref.read(_isValidProvider.notifier).state =
          _isTextFilled(next, _textControllers[next]);
    });
    _pages = [
      SignUpPage(
        controller: _textControllers[0],
        title: '이메일 주소 입력',
        subTitle: '회원님에게 연락할 수 있는 이메일 주소를 입력해 주세요.',
        hintText: '이메일',
        errorProvider: _errorTextProviders[0],
      ),
      SignUpPage(
        controller: _textControllers[1],
        title: '비밀번호 만들기',
        subTitle:
            '다른 사람이 추측할 수 없는 6자 이상의 문자 및 숫자, 특수문자 중 2가지 이상을 포함하는 비밀번호를 만드세요.',
        hintText: '비밀번호',
        errorProvider: _errorTextProviders[1],
        obscureText: true,
      ),
      SignUpPage(
        controller: _textControllers[2],
        title: '생년월일 입력',
        subTitle: '회원님의 실제 생년월일을 입력해 주세요.',
        hintText: 'YYYY-MM-DD',
        inputType: TextInputType.datetime,
        errorProvider: _errorTextProviders[2],
      ),
      SignUpPage(
        controller: _textControllers[3],
        title: '이름 입력',
        hintText: '이름',
        subTitle: '회원님의 이름을 입력해 주세요.',
        errorProvider: _errorTextProviders[3],
      ),
    ];
    for (var (index, controller) in _textControllers.indexed) {
      controller.addListener(() {
        ref.read(_errorTextProviders[index].notifier).state = null;
        ref.read(_isValidProvider.notifier).state =
            _isTextFilled(index, controller);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isValid = ref.watch(_isValidProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: _toPreviousPage,
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  ref.read(_currentPageProvider.notifier).state = index;
                },
                children: _pages,
              ),
            ),
            ExpandedProgressButton(
              onPressed: isValid ? _onNextButtonClicked : null,
              text: '다음',
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onNextButtonClicked() async {
    final currentPage = ref.read(_currentPageProvider);
    final isValid = await _validateInput(currentPage);

    if (isValid) {
      if (currentPage < _pageCount - 1) {
        _toNextPage(currentPage);
      } else {
        _completeSignUp();
      }
    }
  }

  Future<bool> _validateInput(int page) async {
    AuthNotifier notifier = ref.read(authProvider.notifier);
    String input = _textControllers[page].text;

    if (input.isEmpty) {
      _setError(page, '필수 항목입니다.');
      return false;
    }
    if (page == 0) {
      bool isAvailable = await notifier.isEmailAvailable(input);
      if (!isAvailable) {
        _setError(page, '이미 사용중이거나 사용할 수 없는 이메일입니다.');
        return false;
      }
    }
    if (page == 1) {
      bool isAvailable = notifier.isPasswordAvailable(input);
      if (!isAvailable) {
        _setError(page, '사용할 수 없는 비밀번호입니다.');
        return false;
      }
    }
    if (page == 2) {
      bool isAvailable = notifier.isDoBAvailable(input);
      if (!isAvailable) {
        _setError(page, '유효하지 않은 생년월일입니다.');
        return false;
      }
    }

    return true;
  }

  void _toNextPage(int page) {
    ref.read(_currentPageProvider.notifier).state = page + 1;
    _pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _toPreviousPage() {
    final currentPage = ref.read(_currentPageProvider);

    if (currentPage > 0) {
      ref.read(_currentPageProvider.notifier).state = currentPage - 1;
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.pop();
    }
  }

  void _setError(int page, String text) {
    ref.read(_errorTextProviders[page].notifier).state = text;
  }

  bool _isTextFilled(int index, TextEditingController controller) {
    return switch (index) {
      1 => controller.text.length > 5,
      2 => controller.text.length == 10,
      int() => controller.text.isNotEmpty,
    };
  }

  void _completeSignUp() {}
}
