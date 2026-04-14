import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';

class DoctorChatScreen extends StatefulWidget {
  const DoctorChatScreen({super.key});

  @override
  State<DoctorChatScreen> createState() => _DoctorChatScreenState();
}

class _DoctorChatScreenState extends State<DoctorChatScreen> {
  final _inputCtrl = TextEditingController();
  final _scrollCtrl = ScrollController();

  final List<_Msg> _msgs = [
    _Msg(
      text: 'Good morning Doctor, I still have the chest pain we discussed.',
      isMe: false,
      time: '9:10 AM',
    ),
    _Msg(
      text: 'Good morning Ahmed. How severe is it on a scale of 1-10?',
      isMe: true,
      time: '9:12 AM',
    ),
    _Msg(
      text: "It's around a 4 now. Better than yesterday.",
      isMe: false,
      time: '9:13 AM',
    ),
    _Msg(
      text:
          'Good. Continue the medication. Come in on Saturday for the follow-up.',
      isMe: true,
      time: '9:15 AM',
    ),
  ];

  @override
  void dispose() {
    _inputCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _send() {
    final msg = _inputCtrl.text.trim();
    if (msg.isEmpty) return;
    setState(() {
      _msgs.add(_Msg(text: msg, isMe: true, time: 'Now'));
      _inputCtrl.clear();
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
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 52, 16, 12),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => context.go('/doctor/home'),
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
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: const Center(
                    child: Text('👨', style: TextStyle(fontSize: 22)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ahmed Kamal',
                        style: AppTextStyles.bodyBold.copyWith(fontSize: 15),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 7,
                            height: 7,
                            decoration: const BoxDecoration(
                              color: AppColors.green,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Online',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.green,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: AppColors.bg,
              child: ListView.builder(
                controller: _scrollCtrl,
                padding: const EdgeInsets.all(14),
                itemCount: _msgs.length,
                itemBuilder: (_, i) => _buildMsg(_msgs[i]),
              ),
            ),
          ),
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
                        hintText: 'Write a message…',
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

  Widget _buildMsg(_Msg msg) {
    return Align(
      alignment: msg.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: msg.isMe
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            margin: const EdgeInsets.only(bottom: 4),
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
            decoration: BoxDecoration(
              color: msg.isMe ? AppColors.primary : Colors.white,
              border: msg.isMe ? null : Border.all(color: AppColors.border),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(14),
                topRight: const Radius.circular(14),
                bottomLeft: Radius.circular(msg.isMe ? 14 : 4),
                bottomRight: Radius.circular(msg.isMe ? 4 : 14),
              ),
            ),
            child: Text(
              msg.text,
              style: AppTextStyles.body.copyWith(
                color: msg.isMe ? Colors.white : AppColors.text,
                height: 1.5,
              ),
            ),
          ),
          Text(
            msg.time,
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
  final bool isMe;
  final String time;
  const _Msg({required this.text, required this.isMe, required this.time});
}
