import 'dart:io';
import 'dart:typed_data';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smartstore/core/configs/theme/app_colors.dart';
import '../../common/widgets/appbar/app_bar.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final Gemini gemini = Gemini.instance;
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textController = TextEditingController();

  List<ChatMessage> _messages = [];
  bool _isSending = false; // حالة إرسال الرسالة

  ChatUser currentUser = ChatUser(id: "0", firstName: "المستخدم");
  ChatUser geminiUser = ChatUser(
    id: "1",
    firstName: "المساعد الذكي",
    profileImage: "assets/images/ai_logo.png",
  );

  @override
  void initState() {
    super.initState();
    _sendWelcomeMessage();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _textController.dispose();
    super.dispose();
  }

  void _sendWelcomeMessage() {
    ChatMessage welcomeMessage = ChatMessage(
      user: geminiUser,
      createdAt: DateTime.now(),
      text: "مرحباً! كيف يمكنني مساعدتك اليوم؟",
    );
    setState(() {
      _messages = [welcomeMessage, ..._messages];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: const CurvedAppBar(
          title: Text('المساعد الذكي'),
          fontSize: 25,
        ),
        body: _buildUI(),
      ),
    );
  }

  Widget _buildUI() {
    return Stack(
      children: [
        DashChat(
          inputOptions: InputOptions(
            sendButtonBuilder: (onSend) {
              return IconButton(
                onPressed: _isSending ? null : onSend,
                icon: Icon(
                  Icons.send,
                  color: _isSending ? Colors.grey : Theme.of(context).primaryColor,
                ),
              );
            },
            trailing: [
              IconButton(
                onPressed: _isSending ? null : _sendMediaMessage,
                icon: Icon(
                  Icons.image,
                  color: _isSending ? Colors.grey : Theme.of(context).primaryColor,
                ),
              ),
            ],
            focusNode: _focusNode,
            textController: _textController,
            inputDecoration: InputDecoration(
              hintText: 'اكتب رسالتك هنا...',
              hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
            ),
            inputTextDirection: TextDirection.rtl,
          ),
          currentUser: currentUser,
          onSend: _sendMessage,
          messages: _messages,
        ),
        if (_isSending)
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 60.0),
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation(AppColors.grey),
              ),
            ),
          ),
      ],
    );
  }

  // تصفية الاستجابة من الروابط أو النصوص غير المرغوب فيها
  String filterResponse(String response) {
    // تصفية الروابط
    RegExp regExp = RegExp(r"(https?://[^\s]+)");
    response = response.replaceAll(regExp, "[رابط محذوف]");
    // إزالة المسافات الزائدة بين الكلمات
    return response.trim().replaceAll(RegExp(r'\s{2,}'), ' ');
  }

  // إرسال الرسالة
  void _sendMessage(ChatMessage chatMessage) async {
    if (_isSending) return; // تجنب إرسال الرسالة إذا كانت هناك رسالة قيد الإرسال

    setState(() {
      _isSending = true;
      _messages = [chatMessage, ..._messages];
    });

    try {
      final result = await gemini.text(chatMessage.text);

      setState(() {
        _isSending = false;
        if (result?.output != null) {
          final geminiResponseMessage = ChatMessage(
            user: geminiUser,
            createdAt: DateTime.now(),
            text: filterResponse(result!.output!),
            medias: chatMessage.medias,
          );
          _messages = [geminiResponseMessage, ..._messages];
        } else {
          final errorMessage = ChatMessage(
            user: geminiUser,
            createdAt: DateTime.now(),
            text: "حدث خطأ أثناء الحصول على الرد.",
          );
          _messages = [errorMessage, ..._messages];
        }
      });
    } catch (e) {
      setState(() {
        _isSending = false;
        final errorMessage = ChatMessage(
          user: geminiUser,
          createdAt: DateTime.now(),
          text: "حدث خطأ غير متوقع: $e",
        );
        _messages = [errorMessage, ..._messages.where((m) => m.user != geminiUser).toList()];
      });
      print("Send Message Error: $e");
    }
  }

  // إرسال الرسائل مع الوسائط
  void _sendMediaMessage() async {
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      ChatMessage chatMessage = ChatMessage(
        user: currentUser,
        createdAt: DateTime.now(),
        text: "اوصف هذا المنتج..",
        medias: [
          ChatMedia(
            url: file.path,
            fileName: file.name,
            type: MediaType.image,
          ),
        ],
      );
      _sendMessage(chatMessage);
    }
  }
}
