import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

void main() async {
  String botToken = "6780974073:AAGcg8bjIdWLDtyOi4Vx3IqBjcws68hqDwA";
  final String? username = (await Telegram(botToken).getMe()).username;
  TeleDart bot = TeleDart(botToken, Event(username!));

  bot.start();

  bot.onMessage().listen((message) => MagicBot.sendMessage(bot, message));
  bot.onCommand().listen((message) => MagicBot.sendMessage(bot, message));
}

class MagicBot {
  static Future<void> sendMessage(TeleDart bot, TeleDartMessage message) async {
    await _count(bot, message);
    await _incrementFirsLine(bot, message);
    await _incrementAllLines(bot, message);
    await _changColors(bot, message);
    await _incrementFirsLineRed(bot, message);
    await _incrementAllLinesRed(bot, message);
    await _decrement(bot, message);
    
    await _changeHeart(bot, message);
    await _changeHeart(bot, message);
    await _changeHeart(bot, message);
  }

  static const List<String> _heartsList = ['💚', '💛', '💙', '💜', '🖤', '💖', '❤️'];

  static const List<String> _incrementLinesList = [
    '\n🤍🤍🤍🤍🤍🤍🤍🤍🤍',
    '\n🤍🤍❤️❤️🤍❤️❤️🤍🤍',
    '\n🤍❤️❤️❤️❤️❤️❤️❤️🤍',
    '\n🤍❤️❤️❤️❤️❤️❤️❤️🤍',
    '\n🤍❤️❤️❤️❤️❤️❤️❤️🤍',
    '\n🤍🤍❤️❤️❤️❤️❤️🤍🤍',
    '\n🤍🤍🤍❤️❤️❤️🤍🤍🤍',
    '\n🤍🤍🤍🤍❤️🤍🤍🤍🤍',
    '\n🤍🤍🤍🤍🤍🤍🤍🤍🤍',
  ];

  static Future<void> _count(TeleDart bot, TeleDartMessage message) async {
    await bot.sendMessage(message.chat.id, '3️⃣');
    await Future.delayed(Duration(seconds: 1));

    await bot.editMessageText('2️⃣', chatId: message.chat.id, messageId: message.messageId+1);
    await Future.delayed(Duration(seconds: 1));

    await bot.editMessageText('1️⃣', chatId: message.chat.id, messageId: message.messageId+1);
    await Future.delayed(Duration(seconds: 1));
  }

  static Future<void> _incrementFirsLine(TeleDart bot, TeleDartMessage message) async {
    for(int i=1; i<=9; i++){
      await bot.editMessageText(
        "Magic usermode\n\n${'🤍' * i}",
        chatId: message.chat.id,
        messageId: message.messageId+1
      );
    }
  }

  static Future<void> _incrementAllLines(TeleDart bot, TeleDartMessage message) async {
    for(int i=1; i<=8; i++){
      String line = '';

      for(int j=0; j<=i; j++) {
        line += _incrementLinesList[j];
      }

      await bot.editMessageText(
        'Magic usermode\n$line',
        chatId: message.chat.id,
        messageId: message.messageId+1
      );
    }
  }

  static Future<void> _incrementFirsLineRed(TeleDart bot, TeleDartMessage message) async {
    for(int i=1; i<=9; i++){
      String text = '❤️' * i;

      for(int j=0; j<9-i; j++){
        text += '🤍';
      }

      for(int j=1; j<_incrementLinesList.length; j++){
        text += _incrementLinesList[j];
      }

      await bot.editMessageText(
        'Magic usermode\n$text',
        chatId: message.chat.id,
        messageId: message.messageId+1
      );
    }
  }

  static Future<void> _incrementAllLinesRed(TeleDart bot, TeleDartMessage message) async {
    for(int i=1; i<9; i++){
      String text = '';

      for(int j=0; j<_incrementLinesList.length; j++){
        if(j <= i){
          text += '\n❤️❤️❤️❤️❤️❤️❤️❤️❤️';
        } else {
          text += _incrementLinesList[j];
        }
      }

      await bot.editMessageText(
        'Magic usermode\n$text',
        chatId: message.chat.id,
        messageId: message.messageId+1
      );
    }
  }

  static Future<void> _changColors(TeleDart bot, TeleDartMessage message) async {
    for(String i in _heartsList) {
      await bot.editMessageText(
        'Magic usermode\n${_hearts(i)}',
        chatId: message.chat.id,
        messageId: message.messageId+1
      );
    }
  }

  static Future<void> _decrement(TeleDart bot, TeleDartMessage message) async {
    for(int i=8; i>=1; i--){
      String text = '';

      for(int j=1; j<=i; j++){
        text += '❤️' * i;
        if(j!=i) text += '\n';
      }

      await bot.editMessageText(
        'Magic usermode\n$text',
        chatId: message.chat.id,
        messageId: message.messageId+1
      );
    }
  }

  static Future<void> _changeHeart(TeleDart bot, TeleDartMessage message) async {
    for(String i in _heartsList){
      await bot.editMessageText(
        i,
        chatId: message.chat.id,
        messageId: message.messageId+1
      );
    }
  }

  static String _hearts(String h){
    return
      '\n🤍🤍🤍🤍🤍🤍🤍🤍🤍'
      '\n🤍🤍$h$h🤍$h$h🤍🤍'
      '${'\n🤍${h * 7}🤍' * 3}'
      '\n🤍🤍${h * 5}🤍🤍'
      '\n🤍🤍🤍$h$h$h🤍🤍🤍'
      '\n🤍🤍🤍🤍$h🤍🤍🤍🤍'
      '\n🤍🤍🤍🤍🤍🤍🤍🤍🤍';
  }
}
