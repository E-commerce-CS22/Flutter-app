import 'dart:io';
import 'dart:typed_data';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';
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

  List<ChatMessage> messages = [];

  ChatUser currentUser = ChatUser(id: "0", firstName: "المستخدم");
  ChatUser geminiUser = ChatUser(
    id: "1",
    firstName: "",
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
      messages = [welcomeMessage, ...messages];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: const CurvedAppBar(
          title: Text('المساعد الذكي'),
          height: 135,
          fontSize: 25,
        ),
        body: _buildUI(),
      ),
    );
  }

  Widget _buildUI() {
    return DashChat(
      inputOptions: InputOptions(
        trailing: [
          IconButton(
            onPressed: _sendMediaMessage,
            icon: const Icon(
              Icons.image,
            ),
          ),
        ],
        focusNode: _focusNode,
        textController: _textController,
        inputDecoration: InputDecoration(
          hintText: 'اكتب رسالتك هنا...',
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: Colors.transparent),
          ),
        ),
        inputTextDirection: TextDirection.rtl,
      ),
      currentUser: currentUser,
      onSend: _sendMessage,
      messages: messages,
    );
  }

  // تصفية الاستجابة من الروابط أو النصوص غير المرغوب فيها
  String filterResponse(String response) {
    // استخدام تعبير عادي للتأكد من وجود روابط أو عناوين URL في الاستجابة
    RegExp regExp = RegExp(r"(https?://[^\s]+)");
    response = response.replaceAll(regExp, "[رابط محذوف]"); // استبدال الرابط بنص بديل

    // إضافة أي تصفية أخرى حسب الحاجة (مثل إزالة المسافات أو الأسطر الفارغة)
    return response.trim();
  }

  void _sendMessage(ChatMessage chatMessage) {
    setState(() {
      messages = [chatMessage, ...messages];
    });
    try {
      String question = chatMessage.text;
      List<Uint8List>? images;
      if (chatMessage.medias?.isNotEmpty ?? false) {
        images = [
          File(chatMessage.medias!.first.url).readAsBytesSync(),
        ];
      }
      gemini.streamGenerateContent(
        question,
        images: images,
      ).listen((event) {
        ChatMessage? lastMessage = messages.firstOrNull;
        if (lastMessage != null && lastMessage.user == geminiUser) {
          lastMessage = messages.removeAt(0);
          String response = "";
          for (var part in event.content?.parts ?? []) {
            if (part.text != null) {
              response += part.text + " "; // إضافة مسافة بين الأجزاء
            }
          }
          response = filterResponse(response); // تصفية الاستجابة
          lastMessage.text += response;
          setState(() {
            messages = [lastMessage!, ...messages];
          });
        } else {
          String response = "";
          for (var part in event.content?.parts ?? []) {
            if (part.text != null) {
              response += part.text + " "; // إضافة مسافة بين الأجزاء
            }
          }
          response = filterResponse(response); // تصفية الاستجابة
          ChatMessage message = ChatMessage(
            user: geminiUser,
            createdAt: DateTime.now(),
            text: response,
          );
          setState(() {
            messages = [message, ...messages];
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void _sendMediaMessage() async {
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (file != null) {
      ChatMessage chatMessage = ChatMessage(
        user: currentUser,
        createdAt: DateTime.now(),
        text: "اوصف هذا المنتج..",
        medias: [
          ChatMedia(
            url: file.path,
            fileName: "",
            type: MediaType.image,
          ),
        ],
      );
      _sendMessage(chatMessage);
    }
  }
}
