import 'package:flutter/material.dart';

bool flag = false;

class DummyData {
  static Map suggestiveQuestion = {
    "All": [
      {
        "title": "Coding",
        "subTitle": "Understand and improve your code.",
        "question": "Explain this code line by line.",
        "icon": Icons.code,
        "color": Colors.orange,
      },
      {
        "title": "Rewrite",
        "subTitle": "Improve confidence and clarity.",
        "question": "Rewrite this to sound confident.",
        "icon": Icons.edit,
        "color": Colors.teal,
      },
      {
        "title": "Grammar Check",
        "subTitle": "Fix grammar and spelling errors.",
        "question": "Fix grammar and spelling mistakes.",
        "icon": Icons.spellcheck,
        "color": Colors.teal,
      },
      {
        "title": "Professional Tone",
        "subTitle": "Make writing formal and professional.",
        "question": "Make this more professional.",
        "icon": Icons.work,
        "color": Colors.teal,
      },
      {
        "title": "Summarize",
        "subTitle": "Shorten text without losing meaning.",
        "question": "Summarize this in simple words.",
        "icon": Icons.summarize,
        "color": Colors.teal,
      },
      {
        "title": "Step by Step",
        "subTitle": "Understand concepts clearly.",
        "question": "Explain this topic step by step.",
        "icon": Icons.school,
        "color": Colors.indigo,
      },
      {
        "title": "Writing",
        "subTitle": "Improve clarity, tone, and impact in your texts.",
        "question": "Rewrite this to sound confident.",
        "icon": Icons.edit,
        "color": Colors.purple,
      },
      {
        "title": "Study",
        "subTitle": "Learn faster with clear explanations.",
        "question": "Explain this topic step by step.",
        "icon": Icons.school,
        "color": Colors.indigo,
      },
      {
        "title": "Productivity",
        "subTitle": "Plan better and save time on tasks.",
        "question": "Turn this task list into a daily plan.",
        "icon": Icons.check_circle,
        "color": Colors.green,
      },
      {
        "title": "Story",
        "subTitle": "Create engaging and creative stories.",
        "question": "Write a short motivational story.",
        "icon": Icons.auto_stories,
        "color": Colors.deepOrange,
      },

      {
        "title": "Examples",
        "subTitle": "Learn with real examples.",
        "question": "Explain this with an example.",
        "icon": Icons.menu_book,
        "color": Colors.indigo,
      },
      {
        "title": "Exam Notes",
        "subTitle": "Prepare exam-oriented notes.",
        "question": "Give exam-oriented notes.",
        "icon": Icons.assignment,
        "color": Colors.indigo,
      },
      {
        "title": "MCQ Practice",
        "subTitle": "Practice questions for exams.",
        "question": "Create MCQ questions from this.",
        "icon": Icons.quiz,
        "color": Colors.indigo,
      },
      {
        "title": "Daily Plan",
        "subTitle": "Organize tasks efficiently.",
        "question": "Turn this task list into a daily plan.",
        "icon": Icons.check_circle,
        "color": Colors.green,
      },
      {
        "title": "Weekly Schedule",
        "subTitle": "Plan your week smartly.",
        "question": "Create a weekly schedule for this.",
        "icon": Icons.calendar_today,
        "color": Colors.green,
      },
      {
        "title": "Task Priority",
        "subTitle": "Focus on important tasks.",
        "question": "Prioritize these tasks.",
        "icon": Icons.low_priority,
        "color": Colors.green,
      },
      {
        "title": "Time Tips",
        "subTitle": "Improve time management.",
        "question": "Give time management tips.",
        "icon": Icons.timer,
        "color": Colors.green,
      },
      {
        "title": "Motivational Story",
        "subTitle": "Get inspired with short stories.",
        "question": "Write a short motivational story.",
        "icon": Icons.auto_stories,
        "color": Colors.deepOrange,
      },
      {
        "title": "Horror Story",
        "subTitle": "Create scary short stories.",
        "question": "Write a horror story in 5 lines.",
        "icon": Icons.nightlight,
        "color": Colors.deepOrange,
      },
      {
        "title": "Love Story",
        "subTitle": "Romantic story with a twist.",
        "question": "Write a love story with a twist.",
        "icon": Icons.favorite,
        "color": Colors.deepOrange,
      },
      {
        "title": "Kids Story",
        "subTitle": "Fun stories for kids.",
        "question": "Write a children's bedtime story.",
        "icon": Icons.child_friendly,
        "color": Colors.deepOrange,
      },
      {
        "title": "Code Explanation",
        "subTitle": "Understand code logic clearly.",
        "question": "Explain this code line by line.",
        "icon": Icons.code,
        "color": Colors.orange,
      },
      {
        "title": "Bug Fix",
        "subTitle": "Find and fix errors.",
        "question": "Find and fix bugs in this code.",
        "icon": Icons.bug_report,
        "color": Colors.orange,
      },
      {
        "title": "Optimize Code",
        "subTitle": "Improve performance.",
        "question": "Optimize this code for performance.",
        "icon": Icons.speed,
        "color": Colors.orange,
      },
      {
        "title": "Convert Logic",
        "subTitle": "Convert logic into another language.",
        "question": "Convert this logic into Dart.",
        "icon": Icons.transform,
        "color": Colors.orange,
      },
    ],

    "Writing": [
      {
        "title": "Rewrite",
        "subTitle": "Improve confidence and clarity.",
        "question": "Rewrite this to sound confident.",
        "icon": Icons.edit,
        "color": Colors.teal,
      },
      {
        "title": "Grammar Check",
        "subTitle": "Fix grammar and spelling errors.",
        "question": "Fix grammar and spelling mistakes.",
        "icon": Icons.spellcheck,
        "color": Colors.teal,
      },
      {
        "title": "Professional Tone",
        "subTitle": "Make writing formal and professional.",
        "question": "Make this more professional.",
        "icon": Icons.work,
        "color": Colors.teal,
      },
      {
        "title": "Summarize",
        "subTitle": "Shorten text without losing meaning.",
        "question": "Summarize this in simple words.",
        "icon": Icons.summarize,
        "color": Colors.teal,
      },
    ],

    "Study": [
      {
        "title": "Step by Step",
        "subTitle": "Understand concepts clearly.",
        "question": "Explain this topic step by step.",
        "icon": Icons.school,
        "color": Colors.indigo,
      },
      {
        "title": "Examples",
        "subTitle": "Learn with real examples.",
        "question": "Explain this with an example.",
        "icon": Icons.menu_book,
        "color": Colors.indigo,
      },
      {
        "title": "Exam Notes",
        "subTitle": "Prepare exam-oriented notes.",
        "question": "Give exam-oriented notes.",
        "icon": Icons.assignment,
        "color": Colors.indigo,
      },
      {
        "title": "MCQ Practice",
        "subTitle": "Practice questions for exams.",
        "question": "Create MCQ questions from this.",
        "icon": Icons.quiz,
        "color": Colors.indigo,
      },
    ],

    "Productivity": [
      {
        "title": "Daily Plan",
        "subTitle": "Organize tasks efficiently.",
        "question": "Turn this task list into a daily plan.",
        "icon": Icons.check_circle,
        "color": Colors.green,
      },
      {
        "title": "Weekly Schedule",
        "subTitle": "Plan your week smartly.",
        "question": "Create a weekly schedule for this.",
        "icon": Icons.calendar_today,
        "color": Colors.green,
      },
      {
        "title": "Task Priority",
        "subTitle": "Focus on important tasks.",
        "question": "Prioritize these tasks.",
        "icon": Icons.low_priority,
        "color": Colors.green,
      },
      {
        "title": "Time Tips",
        "subTitle": "Improve time management.",
        "question": "Give time management tips.",
        "icon": Icons.timer,
        "color": Colors.green,
      },
    ],

    "Story": [
      {
        "title": "Motivational Story",
        "subTitle": "Get inspired with short stories.",
        "question": "Write a short motivational story.",
        "icon": Icons.auto_stories,
        "color": Colors.deepOrange,
      },
      {
        "title": "Horror Story",
        "subTitle": "Create scary short stories.",
        "question": "Write a horror story in 5 lines.",
        "icon": Icons.nightlight,
        "color": Colors.deepOrange,
      },
      {
        "title": "Love Story",
        "subTitle": "Romantic story with a twist.",
        "question": "Write a love story with a twist.",
        "icon": Icons.favorite,
        "color": Colors.deepOrange,
      },
      {
        "title": "Kids Story",
        "subTitle": "Fun stories for kids.",
        "question": "Write a children's bedtime story.",
        "icon": Icons.child_friendly,
        "color": Colors.deepOrange,
      },
    ],

    "Codeing": [
      {
        "title": "Code Explanation",
        "subTitle": "Understand code logic clearly.",
        "question": "Explain this code line by line.",
        "icon": Icons.code,
        "color": Colors.orange,
      },
      {
        "title": "Bug Fix",
        "subTitle": "Find and fix errors.",
        "question": "Find and fix bugs in this code.",
        "icon": Icons.bug_report,
        "color": Colors.orange,
      },
      {
        "title": "Optimize Code",
        "subTitle": "Improve performance.",
        "question": "Optimize this code for performance.",
        "icon": Icons.speed,
        "color": Colors.orange,
      },
      {
        "title": "Convert Logic",
        "subTitle": "Convert logic into another language.",
        "question": "Convert this logic into Dart.",
        "icon": Icons.transform,
        "color": Colors.orange,
      },
    ],
  };

  static final List<Color> backgroundColorsAi = [
    Colors.white,
    const Color(0xFF3B82F6),
    const Color(0xFF2563EB),
    const Color(0xFF22D3EE),
    const Color(0xFF14B8A6),
    const Color(0xFF8B5CF6),
    const Color(0xFF9333EA),
    const Color(0xFFF43F5E),
    const Color(0xFFEC4899),
    const Color(0xFFF59E0B),
    const Color(0xFF84CC16),
  ];
  static final List<Color> textColorsAi = [
    Colors.white,
    Colors.black,
    const Color(0xFF118AB2),
    const Color(0xFF073B4C),
    const Color(0xFF8D99AE),
    const Color(0xFFFF6B6B),
    const Color(0xFFFF9F1C),
    const Color(0xFFFFD166),
    const Color(0xFF06D6A0),
    const Color(0xFF1B9AAA),
    const Color(0xFF8338EC),
  ];
  static final List<List<Color>> gradientColorsUser = [
    [
      Color.fromARGB(160, 78, 70, 229),
      Color.fromARGB(197, 59, 131, 246),
      Color.fromARGB(205, 6, 181, 212),
    ],
    [const Color(0xFF0F2027), const Color(0xFF203A43)],
    [const Color(0xFF2C5364), const Color(0xFF0B8793)],
    [const Color(0xFF141E30), const Color(0xFF243B55)],
    [const Color(0xFF232526), const Color(0xFF414345)],
    [const Color(0xFF134E5E), const Color(0xFF71B280)],
    [const Color(0xFF1D2671), const Color(0xFF4B134F)],
    [const Color(0xFF283048), const Color(0xFF859398)],
    [const Color(0xFF3A1C71), const Color(0xFFD76D77)],
    [const Color(0xFF0F3443), const Color(0xFF34E89E)],
    [const Color(0xFF42275A), const Color(0xFF734B6D)],
    [const Color(0xFF1A2980), const Color(0xFF26D0CE)],
  ];

  static final List<Map<dynamic, dynamic>> languagesList = [
    {"name": "English", "code": "en"},
    {"name": "Bengali", "code": "bn"},
    {"name": "Hindi", "code": "hi"},
    {"name": "Urdu", "code": "ur"},
    {"name": "Arabic", "code": "ar"},
    {"name": "French", "code": "fr"},
    {"name": "German", "code": "de"},
    {"name": "Spanish", "code": "es"},
    {"name": "Portuguese", "code": "pt"},
    {"name": "Russian", "code": "ru"},
    {"name": "Chinese", "code": "zh"},
    {"name": "Japanese", "code": "ja"},
    {"name": "Korean", "code": "ko"},
    {"name": "Italian", "code": "it"},
    {"name": "Tamil", "code": "ta"},
    {"name": "Telugu", "code": "te"},
    {"name": "Malayalam", "code": "ml"},
    {"name": "Kannada", "code": "kn"},
    {"name": "Marathi", "code": "mr"},
  ];

  static final List settingsProfileOptions = [
    {"title": "Change Name", "icon": Icons.edit},
    {"title": "Change Email", "icon": Icons.email},
    {"title": "Change Password", "icon": Icons.email},
    {"title": "Change Profile Photo", "icon": Icons.camera_alt},
  ];

  static final List settingsItems = [
    // ACCOUNT

    // CHAT & ASSISTANT
    [
      {"title": "Chat Settings", "icon": Icons.chat},
      {"title": "Assistant Settings", "icon": Icons.smart_toy},
      {"title": "Dark Mode", "icon": Icons.dark_mode},
    ],

    // PRIVACY & SECURITY
    [
      {"title": "Chat History", "icon": Icons.chat_bubble_outline},
      {"title": "Voice History", "icon": Icons.mic_none},
      {"title": "Scanner History", "icon": Icons.qr_code_scanner_outlined},
    ],
    // APP
    [
      {"title": "Feedback", "icon": Icons.feedback},
      {"title": "About App", "icon": Icons.info},
    ],
  ];

  // Feed Back
  static const List<Map<String, dynamic>> features = [
    {"title": "AI Chatbot", "icon": Icons.smart_toy_outlined},
    {"title": "AI Scanner", "icon": Icons.document_scanner_outlined},
    {"title": "AI Voice Assistant", "icon": Icons.record_voice_over_outlined},
    {"title": "AI Translator", "icon": Icons.translate_outlined},
  ];

  static const List<Map> feedbackData = [
    {"emoji": "😡", "text": "Very Bad"},
    {"emoji": "😕", "text": "Bad"},
    {"emoji": "🙂", "text": "Good"},
    {"emoji": "😄", "text": "Very Good"},
    {"emoji": "🤩", "text": "Excellent"},
  ];
}
