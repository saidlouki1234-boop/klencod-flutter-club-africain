
import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const LudoTunisiaApp());

class LudoTunisiaApp extends StatelessWidget {
  const LudoTunisiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ludo Tunisia',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE30613),
        ),
        useMaterial3: true,
      ),
      home: const LudoHome(),
    );
  }
}

class Club {
  final String name;
  final String emoji;
  final Color color;

  const Club(this.name, this.emoji, this.color);
}

const clubs = [
  Club('النادي الإفريقي', '🦅', Color(0xFFE30613)),
  Club('الترجي الرياضي', '🔴', Color(0xFFB71C1C)),
  Club('النجم الساحلي', '⭐', Color(0xFFFFC107)),
  Club('النادي الصفاقسي', '⚫', Color(0xFF263238)),
];

class LudoHome extends StatefulWidget {
  const LudoHome({super.key});

  @override
  State<LudoHome> createState() => _LudoHomeState();
}

class _LudoHomeState extends State<LudoHome> {
  int selectedClub = 0;
  int dice = 1;
  int position = 0;
  int turn = 0;
  final random = Random();

  void rollDice() {
    setState(() {
      dice = random.nextInt(6) + 1;
      position = (position + dice) % 40;
      turn++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final club = clubs[selectedClub];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE30613),
        foregroundColor: Colors.white,
        title: const Text(
          'Ludo Tunisia 🇹🇳',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'اختار ناديك والعب! ⚽',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'الأندية التونسية',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(clubs.length, (i) {
                final item = clubs[i];
                return ChoiceChip(
                  selected: selectedClub == i,
                  selectedColor: item.color.withOpacity(0.2),
                  label: Text('${item.emoji} ${item.name}'),
                  onSelected: (_) {
                    setState(() => selectedClub = i);
                  },
                );
              }),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Text(
                    '${club.emoji} ${club.name}',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: club.color,
                    ),
                  ),
                  const SizedBox(height: 16),
                  AspectRatio(
                    aspectRatio: 1,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 36,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 6,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4,
                      ),
                      itemBuilder: (context, index) {
                        final isPiece = index == position % 36;
                        final isStart = index == 0;

                        return Container(
                          decoration: BoxDecoration(
                            color: isPiece
                                ? club.color
                                : isStart
                                    ? const Color(0xFFFFCDD2)
                                    : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(
                              color: Colors.black12,
                            ),
                          ),
                          child: Center(
                            child: isPiece
                                ? const Text(
                                    '⚽',
                                    style: TextStyle(fontSize: 23),
                                  )
                                : isStart
                                    ? const Text('🏁')
                                    : null,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    '🎲 نتيجة النرد: $dice',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('عدد الأدوار: $turn'),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: rollDice,
                      icon: const Icon(Icons.casino),
                      label: const Text(
                        'ارمِ النرد',
                        style: TextStyle(fontSize: 18),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: club.color,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.all(15),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        dice = 1;
                        position = 0;
                        turn = 0;
                      });
                    },
                    child: const Text('إعادة اللعب'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'نسخة تجريبية — قواعد الفوز واللعب بين عدة لاعبين '
              'تحتاج إلى استكمال.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
