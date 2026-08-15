import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mr. Sound',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SoundBoardScreen(),
      },
    );
  }
}

class SoundBoardScreen extends StatefulWidget {
  const SoundBoardScreen({super.key});

  @override
  State<SoundBoardScreen> createState() => _SoundBoardScreenState();
}

class _SoundBoardScreenState extends State<SoundBoardScreen> {
  final List<SoundItem> sounds = [
    SoundItem(title: 'Rain', icon: Icons.water_drop),
    SoundItem(title: 'Waves', icon: Icons.waves),
    SoundItem(title: 'Forest', icon: Icons.park),
    SoundItem(title: 'Fire', icon: Icons.local_fire_department),
    SoundItem(title: 'Wind', icon: Icons.air),
    SoundItem(title: 'Night', icon: Icons.nights_stay),
    SoundItem(title: 'Birds', icon: Icons.flutter_dash),
    SoundItem(title: 'Coffee Shop', icon: Icons.coffee),
    SoundItem(title: 'Train', icon: Icons.train),
    SoundItem(title: 'Thunder', icon: Icons.thunderstorm),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mr. Sound'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Determine column count based on width
            int crossAxisCount = 2;
            if (constraints.maxWidth > 1200) {
              crossAxisCount = 6;
            } else if (constraints.maxWidth > 800) {
              crossAxisCount = 4;
            } else if (constraints.maxWidth > 500) {
              crossAxisCount = 3;
            }

            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.0,
              ),
              itemCount: sounds.length,
              itemBuilder: (context, index) {
                return SoundTile(item: sounds[index]);
              },
            );
          },
        ),
      ),
    );
  }
}

class SoundItem {
  final String title;
  final IconData icon;
  bool isPlaying;

  SoundItem({
    required this.title,
    required this.icon,
    this.isPlaying = false,
  });
}

class SoundTile extends StatefulWidget {
  final SoundItem item;

  const SoundTile({super.key, required this.item});

  @override
  State<SoundTile> createState() => _SoundTileState();
}

class _SoundTileState extends State<SoundTile> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Material(
      color: widget.item.isPlaying ? colorScheme.primaryContainer : colorScheme.surfaceVariant,
      borderRadius: BorderRadius.circular(24),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          setState(() {
            widget.item.isPlaying = !widget.item.isPlaying;
            // In a real app, this would trigger audio playback
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              widget.item.icon,
              size: 48,
              color: widget.item.isPlaying ? colorScheme.onPrimaryContainer : colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              widget.item.title,
              style: theme.textTheme.titleMedium?.copyWith(
                color: widget.item.isPlaying ? colorScheme.onPrimaryContainer : colorScheme.onSurfaceVariant,
                fontWeight: widget.item.isPlaying ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
