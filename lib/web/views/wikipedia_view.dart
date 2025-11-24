import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_game_app/web/components/sidebar.dart';

final List<Map<String, dynamic>> data = [
  {
    'name': 'Boy',
    'level': 1,
    'image': 'assets/images/home/boychild.jpg',
    'description':
        'Un explorador silencioso que prefiere los pasillos estrechos. '
        'Su instinto rara vez falla cuando hay peligro cerca.',
  },
  {
    'name': 'Nyx',
    'level': 2,
    'image': 'assets/images/home/enemy1.jpg',
    'description':
        'Conoce cada rincón del sanatorio. Domina el sigilo y deja señales '
        'ocultas para quienes saben mirar.',
  },
  {
    'name': 'Raven',
    'level': 3,
    'image': 'assets/images/home/enemy2.jpg',
    'description':
        'Líder nato con un pasado que nadie se atreve a mencionar. '
        'Su presencia impone respeto en la oscuridad.',
  },
  {
    'name': 'Mora',
    'level': 1,
    'image': 'assets/images/home/enemy3.jpg',
    'description':
        'Analítica y metódica. Recolecta pistas y fragmentos de memoria '
        'para recomponer la verdad.',
  },
  {
    'name': 'Kael',
    'level': 2,
    'image': 'assets/images/home/enemy4.jpg',
    'description':
        'Errante y esquivo. Dicen que puede escuchar las paredes cuando '
        'susurra el viento frío.',
  },
  {
    'name': 'Umbra',
    'level': 3,
    'image': 'assets/images/home/enemy5.jpg',
    'description':
        'La sombra detrás del mito. Se mueve con precisión quirúrgica, '
        'y nadie sabe qué persigue realmente.',
  },
];

class WikipediaView extends StatefulWidget {
  const WikipediaView({super.key});

  @override
  State<WikipediaView> createState() => _WikipediaViewState();
}

class _WikipediaViewState extends State<WikipediaView> {
  final ScrollController _scrollController = ScrollController();

  static const int _pageSize = 4;
  int _currentMax = _pageSize;
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    // Precarga de assets que se usan como fondo y tarjetas
    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(const AssetImage('assets/images/home/boy.jpg'), context);
      precacheImage(const AssetImage('assets/images/home/boy.jpg'), context);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 100 &&
        !_isLoadingMore &&
        _currentMax < data.length) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    setState(() => _isLoadingMore = true);
    await Future.delayed(
      const Duration(milliseconds: 400),
    ); // simulación de carga
    setState(() {
      _currentMax = (_currentMax + _pageSize).clamp(0, data.length);
      _isLoadingMore = false;
    });
  }

  void _openCharacterModal(Map<String, dynamic> item) {
    const darkRed = Color.fromARGB(255, 44, 4, 4);
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (ctx) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final maxW = constraints.maxWidth;
              final cardW = maxW > 640 ? 640.0 : maxW;
              final dpr = MediaQuery.of(context).devicePixelRatio;

              return Center(
                child: Container(
                  width: cardW,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.82),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white24),
                    boxShadow: const [
                      // blur un poco menor reduce trabajo de GPU
                      BoxShadow(
                        blurRadius: 18,
                        spreadRadius: 0,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Imagen con nombre encima
                        Stack(
                          children: [
                            AspectRatio(
                              aspectRatio: 16 / 9,
                              child: LayoutBuilder(
                                builder: (context, c) {
                                  final targetWidth = (c.maxWidth * dpr)
                                      .clamp(400, 2000)
                                      .round();
                                  return Image.asset(
                                    item['image'],
                                    fit: BoxFit.cover,
                                    cacheWidth: targetWidth,
                                    filterQuality: FilterQuality.none,
                                  );
                                },
                              ),
                            ),
                            Positioned(
                              top: 8,
                              left: 8,
                              right: 8,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.55),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.white24),
                                ),
                                child: Text(
                                  item['name'],
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.cinzelDecorative(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Info bajo la imagen
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      item['name'],
                                      style: GoogleFonts.cinzelDecorative(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  _LevelBadge(level: item['level']),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                item['description'],
                                style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 14),
                              Align(
                                alignment: Alignment.centerRight,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: darkRed,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () => Navigator.of(ctx).pop(),
                                  child: const Text(
                                    'Cerrar',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final visibleItems = data.take(_currentMax).toList();

    return Scaffold(
      drawer: const Sidebar(),
      body: Stack(
        children: [
          // Fondo con imagen oscura
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/home/group.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black54, BlendMode.darken),
              ),
            ),
          ),
          // Contenido scrollable
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Menú hamburguesa manual
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 40, left: 16),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Builder(
                      builder: (context) => IconButton(
                        icon: const Icon(Icons.menu, color: Colors.white),
                        onPressed: () => Scaffold.of(context).openDrawer(),
                      ),
                    ),
                  ),
                ),
              ),

              // Título y descripción
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 900),
                    child: Column(
                      children: [
                        Text(
                          'Personajes',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.cinzelDecorative(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Vista previa de los personajes del mundo de Hostis Aeternus. '
                          'Explora sus niveles, historias y apariciones dentro del juego.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            color: Colors.grey[300],
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
              // Encima del grid de personajes
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {}, // TODO: abrir filtros
                        icon: const Icon(
                          Icons.filter_list,
                          color: Colors.white,
                        ),
                        label: Text(
                          "Filtrar",
                          style: GoogleFonts.roboto(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 80, 4, 8),
                        ),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton.icon(
                        onPressed: () {}, // TODO: mostrar favoritos
                        icon: const Icon(Icons.favorite, color: Colors.white),
                        label: Text(
                          "Favoritos",
                          style: GoogleFonts.roboto(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Grid de personajes
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverLayoutBuilder(
                  builder: (context, constraints) {
                    const crossAxisCount = 2;
                    const cardHeight = 250.0;
                    final gridDelegate =
                        SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio:
                              (constraints.crossAxisExtent / crossAxisCount) /
                              cardHeight,
                        );

                    return SliverGrid(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final item = visibleItems[index];
                        return _CharacterCard(
                          name: item['name'],
                          level: item['level'],
                          image: item['image'],
                          onTap: () => _openCharacterModal(item),
                        );
                      }, childCount: visibleItems.length),
                      gridDelegate: gridDelegate,
                    );
                  },
                ),
              ),

              // Loader
              if (_isLoadingMore)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
            ],
          ),
        ],
      ),
    );
  }
}

// Tarjeta de personaje (estilo videojuego)
class _CharacterCard extends StatelessWidget {
  const _CharacterCard({
    required this.name,
    required this.level,
    required this.image,
    required this.onTap,
  });

  final String name;
  final int level;
  final String image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final dpr = MediaQuery.of(context).devicePixelRatio;

    return InkWell(
      onTap: onTap,
      splashColor: Colors.white10,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.35),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white24),
          boxShadow: const [
            BoxShadow(
              blurRadius: 14,
              color: Colors.black54,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(14),
                ),
                child: LayoutBuilder(
                  builder: (context, c) {
                    final targetWidth = (c.maxWidth * dpr)
                        .clamp(200, 1600)
                        .round();
                    return Image.asset(
                      image,
                      fit: BoxFit.cover,
                      cacheWidth:
                          targetWidth, // evitar decodificar la imagen gigante
                      filterQuality: FilterQuality.none,
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      name,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  _LevelBadge(level: level, compact: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Badge de nivel (tres niveles)
class _LevelBadge extends StatelessWidget {
  const _LevelBadge({required this.level, this.compact = false});

  final int level;
  final bool compact;

  Color get _color {
    switch (level) {
      case 1:
        return const Color(0xFF4CAF50); // verde
      case 2:
        return const Color(0xFFFFC107); // ámbar
      case 3:
      default:
        return const Color(0xFFE53935); // rojo
    }
  }

  String get _text => 'Nv $level';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 8 : 10,
        vertical: compact ? 4 : 6,
      ),
      decoration: BoxDecoration(
        color: _color.withOpacity(0.9),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white24),
      ),
      child: Text(
        _text,
        style: TextStyle(
          color: Colors.white,
          fontSize: compact ? 12 : 13.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}
