import 'package:flutter/material.dart';
import 'package:flutter_chat_app/presentation/screen/sign_up/sign_up_page.dart';
import 'package:flutter_chat_app/presentation/widget/expanded_progress_button.dart';
import 'package:flutter_chat_app/presentation/widget/general_text_field.dart';
import 'package:flutter_chat_app/presentation/widget/obscure_text_field.dart';
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
  final _textControllers =
      List.generate(_pageCount, (_) => TextEditingController());
  final _errorTextProviders =
      List.generate(_pageCount, (_) => StateProvider<String?>((ref) => null));
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      SignUpPage(
        title: '이메일 주소 입력',
        subTitle: '회원님에게 연락할 수 있는 이메일 주소를 입력해 주세요.',
        body: GeneralTextField(controller: _textControllers[0]),
      ),
      SignUpPage(
        title: '비밀번호 만들기',
        subTitle:
            '다른 사람이 추측할 수 없는 6자 이상의 문자 및 숫자, 특수문자 중 2가지 이상을 포함하는 비밀번호를 만드세요.',
        body: ObscureTextField(controller: _textControllers[1]),
      ),
      SignUpPage(
        title: '나이 입력',
        subTitle: '회원님의 실제 나이를 입력해 주세요.',
        body: GeneralTextField(
          controller: _textControllers[2],
          inputType: TextInputType.number,
        ),
      ),
      SignUpPage(
        title: '이름 입력',
        subTitle: '회원님의 이름을 입력해 주세요.',
        body: GeneralTextField(controller: _textControllers[3]),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
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
            ExpandedProgressButton(onPressed: _onNextButtonClicked, text: '다음'),
          ],
        ),
      ),
    );
  }

  Future<void> _onNextButtonClicked() async {
    final currentPage = ref.read(_currentPageProvider);

    await Future.delayed(Duration(milliseconds: 500));
    _toNextPage();
  }

  void _toNextPage() {
    final currentPage = ref.read(_currentPageProvider);

    if (currentPage < _pageCount - 1) {
      ref.read(_currentPageProvider.notifier).state = currentPage + 1;
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
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
}
