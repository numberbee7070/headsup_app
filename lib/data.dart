import 'dart:math';

// shimmer quotes
List<String> quotes = [
  "Learn to say no if you don't want. ",
  "People's opinion about you doesn't matter much because they haven't seen your struggle.",
  "You don't have to become something that only society wants you to be. ",
  "Nothing is permanent, everything changes with time.",
  "Imagine, where do you see yourself in 5 years from now?",
  "Life is all about give and take. What you give you recieve back whether it's love or not.",
  "Life won't seem easy to you because it isn't, so learn to deal with it . You are not alone in this journey. Everyone is dealing with their own problems in their own way.",
  "What would you do if there was no pressure or judgement from society?",
  "Live more in the real world than in the virtual world.",
  "It isn't about people it's about your feelings towards them.",
  "If you are changing you are growing.",
  "Create memories, so that when you look back you feel happy about your life.",
  "The best buddy you have ever found is you.",
  "Oh my god that's the preetiest thing I have ever seen, your smile",
  "You are unique in your own way.",
  "You can be your own happy place",
  "I live with a wonderful person and that person is me.",
  "I love myself for having such a lovely heart."
];

String randomQuote() {
  final _random = new Random();
  return quotes[_random.nextInt(quotes.length)];
}
