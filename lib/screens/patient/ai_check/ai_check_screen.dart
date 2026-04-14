import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';

class AiCheckScreen extends StatefulWidget {
  const AiCheckScreen({super.key});

  @override
  State<AiCheckScreen> createState() => _AiCheckScreenState();
}

class _AiCheckScreenState extends State<AiCheckScreen> {
  final _inputCtrl = TextEditingController();
  final _scrollCtrl = ScrollController();
  final List<_Msg> _msgs = [
    _Msg(
      text:
          "Hello! I'm MediAI 🤖\n\nDescribe your symptoms and I'll help identify possible conditions.",
      isBot: true,
    ),
  ];

  static const _chips = [
    'Headache & fever',
    'Chest pain',
    'Shortness of breath',
    'Stomach ache',
  ];

  @override
  void dispose() {
    _inputCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _send([String? text]) {
    final msg = text ?? _inputCtrl.text.trim();
    if (msg.isEmpty) return;
    setState(() {
      _msgs.add(_Msg(text: msg, isBot: false));
      _inputCtrl.clear();
    });
    // Simulate bot reply
    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;
      setState(() {
        _msgs.add(
          const _Msg(
            text:
                "Based on your symptoms, here are some possible conditions:\n\n• Common Cold — 68%\n• Flu (Influenza) — 54%\n• Sinusitis — 41%\n\nI recommend consulting a doctor for a proper diagnosis.",
            isBot: true,
          ),
        );
      });
      Future.delayed(const Duration(milliseconds: 100), () {
        _scrollCtrl.animateTo(
          _scrollCtrl.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollCtrl.animateTo(
        _scrollCtrl.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 15, 2, 2),
      body: Column(
        children: [
          // Header
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 52, 16, 12),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => context.go('/patient/home'),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.s2,
                      border: Border.all(color: AppColors.border),
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      size: 16,
                      color: AppColors.text,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.blue3,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Center(
                    child: Text('🤖', style: TextStyle(fontSize: 22)),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'MediAI',
                      style: AppTextStyles.bodyBold.copyWith(fontSize: 15),
                    ),
                    Text('AI Symptom Checker', style: AppTextStyles.caption),
                  ],
                ),
              ],
            ),
          ),
          // Messages
          Expanded(
            child: Container(
              color: AppColors.bg,
              child: ListView.builder(
                controller: _scrollCtrl,
                padding: const EdgeInsets.all(14),
                itemCount: _msgs.length,
                itemBuilder: (_, i) => _buildMsg(_msgs[i], i),
              ),
            ),
          ),
          // Quick chips
          if (_msgs.length <= 2)
            Container(
              color: AppColors.bg,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              child: Wrap(
                spacing: 6,
                runSpacing: 6,
                children: _chips
                    .map(
                      (c) => GestureDetector(
                        onTap: () => _send(c),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 11,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.blue3,
                            border: Border.all(color: AppColors.blue4),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            c,
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          // Input
          Container(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 24),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 13,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.s2,
                      border: Border.all(color: AppColors.border, width: 1.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: _inputCtrl,
                      style: AppTextStyles.body,
                      decoration: InputDecoration.collapsed(
                        hintText: 'Describe your symptoms…',
                        hintStyle: AppTextStyles.body.copyWith(
                          color: AppColors.text3,
                        ),
                      ),
                      onSubmitted: (_) => _send(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _send,
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: const Icon(
                      Icons.send_rounded,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMsg(_Msg msg, int i) {
    return Align(
      alignment: msg.isBot ? Alignment.centerLeft : Alignment.centerRight,
      child: Column(
        crossAxisAlignment: msg.isBot
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.85,
            ),
            margin: const EdgeInsets.only(bottom: 4),
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
            decoration: BoxDecoration(
              color: msg.isBot ? Colors.white : AppColors.primary,
              border: msg.isBot ? Border.all(color: AppColors.border) : null,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(14),
                topRight: const Radius.circular(14),
                bottomLeft: Radius.circular(msg.isBot ? 4 : 14),
                bottomRight: Radius.circular(msg.isBot ? 14 : 4),
              ),
            ),
            child: Text(
              msg.text,
              style: AppTextStyles.body.copyWith(
                color: msg.isBot ? AppColors.text : Colors.white,
                height: 1.5,
              ),
            ),
          ),
          Text(
            'Now',
            style: AppTextStyles.caption.copyWith(
              color: AppColors.text3,
              fontSize: 10,
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _Msg {
  final String text;
  final bool isBot;
  const _Msg({required this.text, required this.isBot});
}
