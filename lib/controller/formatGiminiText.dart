import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

Widget formatGiminiText(text, fontSize, fontBold) {
  return MarkdownBody(
    data: text,
    selectable: true,
    styleSheet: MarkdownStyleSheet(
      // normal text
      p: TextStyle(
        fontSize: fontSize.toDouble(),
        height: 1.6,
        fontWeight: fontBold ? FontWeight.bold : null,
      ),

      // headings
      h1: TextStyle(
        color: Color(0xFF7B61FF),
        fontSize: 26,
        fontWeight: FontWeight.bold,
      ),
      h2: TextStyle(
        color: Color(0xFF5A8DFF),
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
      h3: TextStyle(
        color: Colors.cyanAccent,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),

      // emphasis
      strong: TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold),
      em: TextStyle(color: Colors.orangeAccent, fontStyle: FontStyle.italic),
      del: TextStyle(
        color: Colors.redAccent,
        decoration: TextDecoration.lineThrough,
      ),

      // lists
      listBullet: TextStyle(color: Colors.lightBlueAccent, fontSize: 15),

      // links
      a: TextStyle(
        color: Colors.greenAccent,
        decoration: TextDecoration.underline,
      ),

      // inline code
      code: TextStyle(
        color: Colors.greenAccent,
        backgroundColor: Colors.black54,
        fontFamily: 'monospace',
      ),

      // block code
      codeblockDecoration: BoxDecoration(
        color: Color(0xFF0B1220),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.greenAccent.withOpacity(.3)),
      ),

      // quote
      blockquote: TextStyle(
        color: Colors.grey.shade300,
        fontStyle: FontStyle.italic,
      ),
    ),
  );
}
