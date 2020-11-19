import 'dart:math';

const List positive = <String>[
  'Healing',
  'Bliss',
  'Compassion',
  'Hope',
  'Emapathy',
  'Therapy',
  'Listening',
  'Self Care',
  'Clarity',
  'Gratitude',
  'Smiles',
  'Journal',
  'Breathe',
  'Values',
  'Health',
  'Growth',
  'Understanding',
  'Peace',
  'Yoga',
  'Dancing',
  'Pets',
  'Reading',
  'Breathe',
  'Authenticity',
  'Creativity',
  'Self Boundaries',
  'Your Emotions',
  'Calmness',
  'Acceptance',
  'Confronting',
];

const List negative = <String>[
  'Regret',
  'Fear',
  'Insecurities',
  'Ignorance',
  'Confusion',
  'Anxiety',
  'Past',
  'Negligence',
  'Toxins',
  'Others\' Validation',
  'Fatigue',
  'Self Doubt',
  'Tension',
];

String getNegativeWord() {
  final _random = new Random();
  return negative[_random.nextInt(negative.length)];
}

String getPositiveWord() {
  final _random = new Random();
  return positive[_random.nextInt(positive.length)];
}
