import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

// Raccourci pour écrire une durée sans utiliser ".ms"
Duration _d(int millisecondes) => Duration(milliseconds: millisecondes);

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ISI_KEF",
      theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
      home: const EnGeneral(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class EnGeneral extends StatelessWidget {
  const EnGeneral({Key? key}) : super(key: key);

  // Règle : .animate() est appliqué uniquement sur un Container
  // (jamais sur un Text, un Icon, un Row, un Flexible ou un Expanded).

  // Style commun des textes (change la taille ici pour tout ajuster)
  static const TextStyle _styleTexte = TextStyle(
    color: Colors.black,
    fontSize: 18,
    height: 1.4,
  );

  // Les 4 axes du texte d'origine, un par ligne
  static const List<String> _objectifs = [
    "La maîtrise des technologies informatiques modernes",
    "L'innovation et la recherche scientifique",
    "L'entrepreneuriat et les compétences professionnelles",
    "L'adaptation aux évolutions rapides du domaine numérique",
  ];

  // ---------------------------------------------------------------------------
  // En-tête : logo qui flotte + nom de l'institut
  // ---------------------------------------------------------------------------
  Widget _entete() {
    return Container(
      margin: const EdgeInsets.only(top: 12, bottom: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Container extérieur : entrée (fondu + zoom)
          Container(
                // Container intérieur : flottement en boucle
                child:
                    Container(
                          width: 96,
                          height: 96,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue[100],
                            border: Border.all(
                              color: Colors.blue.shade300,
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.shade200,
                                blurRadius: 24,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.school,
                            size: 48,
                            color: Colors.blue.shade900,
                          ),
                        )
                        .animate(
                          onPlay: (controller) =>
                              controller.repeat(reverse: true),
                        )
                        .moveY(
                          begin: 0,
                          end: -8,
                          duration: _d(1600),
                          curve: Curves.easeInOut,
                        ),
              )
              .animate()
              .fadeIn(duration: _d(600))
              .scale(
                begin: const Offset(0.6, 0.6),
                end: const Offset(1, 1),
                curve: Curves.easeOutBack,
              ),
          const SizedBox(height: 12),
          Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "ISI Kef",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        color: Colors.blue.shade900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Institut Supérieur d’Informatique du Kef",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueGrey.shade700,
                      ),
                    ),
                  ],
                ),
              )
              .animate(delay: _d(300))
              .fadeIn(duration: _d(600))
              .slideY(begin: 0.3, end: 0, curve: Curves.easeOutCubic),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Carte arrondie : titre avec icône + contenu.
  // Apparition en cascade (fondu + montée + zoom) puis un reflet lumineux.
  // ---------------------------------------------------------------------------
  Widget _carte({
    required int index,
    required IconData icone,
    required String titre,
    required Widget child,
  }) {
    final int debut = 700 + index * 400; // moment d'apparition de la carte

    return Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.blue[100],
            border: Border.all(color: Colors.blue.shade300),
            borderRadius: BorderRadius.circular(40.0),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.shade200,
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icône du titre : apparition avec rebond
                  Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Icon(
                          icone,
                          size: 22,
                          color: Colors.blue.shade900,
                        ),
                      )
                      .animate(delay: _d(debut + 500))
                      .scale(
                        begin: Offset.zero,
                        end: const Offset(1, 1),
                        duration: _d(500),
                        curve: Curves.easeOutBack,
                      ),
                  const SizedBox(width: 10),
                  Container(
                    child: Text(
                      titre,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                      ),
                    ),
                  ).animate(delay: _d(debut + 300)).fadeIn(duration: _d(500)),
                ],
              ),
              const SizedBox(height: 14),
              child,
            ],
          ),
        )
        .animate(delay: _d(debut))
        .fadeIn(duration: _d(700))
        .slideY(begin: 0.2, end: 0, curve: Curves.easeOutCubic)
        .scale(
          begin: const Offset(0.95, 0.95),
          end: const Offset(1, 1),
          curve: Curves.easeOutCubic,
        )
        .then(delay: _d(300))
        .shimmer(duration: _d(1500), color: Colors.white70);
  }

  // ---------------------------------------------------------------------------
  // Ligne d'objectif : entrée par la gauche, l'une après l'autre
  // ---------------------------------------------------------------------------
  Widget _ligneObjectif({required String texte, required int index}) {
    return Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.check_circle, size: 22, color: Colors.blue.shade700),
              const SizedBox(width: 10),
              Expanded(child: Text(texte, style: _styleTexte)),
            ],
          ),
        )
        .animate(delay: _d(1500 + index * 200))
        .fadeIn(duration: _d(500))
        .slideX(begin: -0.2, end: 0, curve: Curves.easeOutCubic);
  }

  // ---------------------------------------------------------------------------
  // Ligne de contact : tuile claire qui entre par la droite,
  // icône qui pulse doucement.
  // ---------------------------------------------------------------------------
  Widget _ligneContact({
    required IconData icone,
    required Color couleur,
    required String texte,
    required int index,
  }) {
    return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white54,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Container(child: Icon(icone, color: couleur))
                  .animate(
                    delay: _d(2300 + index * 250),
                    onPlay: (controller) => controller.repeat(reverse: true),
                  )
                  .scale(
                    begin: const Offset(1, 1),
                    end: const Offset(1.25, 1.25),
                    duration: _d(900),
                    curve: Curves.easeInOut,
                  ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  texte,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ],
          ),
        )
        .animate(delay: _d(1800 + index * 250))
        .fadeIn(duration: _d(500))
        .slideX(begin: 0.3, end: 0, curve: Curves.easeOutCubic);
  }

  // ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        foregroundColor: const Color.fromARGB(255, 6, 0, 0),
        scrolledUnderElevation:
            0, // garde la même couleur quand on fait défiler
        centerTitle: true,
        title: Container(child: const Text('ISI_KEF'))
            .animate()
            .fadeIn(duration: _d(600))
            .slideX(begin: -0.3, end: 0, curve: Curves.easeOutCubic),
        actions: <Widget>[
          IconButton(
            // La flèche oscille en boucle pour inviter à cliquer
            icon: Container(child: const Icon(Icons.navigate_next))
                .animate(
                  onPlay: (controller) => controller.repeat(reverse: true),
                )
                .moveX(
                  begin: 0,
                  end: 6,
                  duration: _d(700),
                  curve: Curves.easeInOut,
                ),
            tooltip: 'plus_informations',
            onPressed: () {
              // TODO : ouvrir la page « plus d'informations »
            },
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade50, Colors.white],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Align(
              alignment: Alignment.topCenter,
              // Largeur limitée pour rester lisible sur tablette / web
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _entete(),
                    _carte(
                      index: 0,
                      icone: Icons.account_balance,
                      titre: "Présentation",
                      child: const Text(
                        "L’Institut Supérieur d’Informatique du Kef (ISI Kef) est un établissement universitaire public relevant de l’Université de Jendouba situé à Higher Institute of Computer Science of Kef, au Kef. Il est spécialisé dans les technologies de l'information, le développement logiciel, les systèmes d'information et les réseaux.",
                        textAlign: TextAlign.center,
                        style: _styleTexte,
                      ),
                    ),
                    _carte(
                      index: 1,
                      icone: Icons.flag,
                      titre: "Nos objectifs",
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (int i = 0; i < _objectifs.length; i++)
                            _ligneObjectif(texte: _objectifs[i], index: i),
                        ],
                      ),
                    ),
                    _carte(
                      index: 2,
                      icone: Icons.contact_mail,
                      titre: "Contact",
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _ligneContact(
                            icone: Icons.location_on,
                            couleur: const Color.fromARGB(255, 240, 27, 4),
                            texte: '5 Rue Saleh Ayech - 7100 Kef',
                            index: 0,
                          ),
                          _ligneContact(
                            icone: Icons.phone,
                            couleur: Colors.green,
                            texte: '+216 78 201 056',
                            index: 1,
                          ),
                          _ligneContact(
                            icone: Icons.email,
                            couleur: Colors.red,
                            texte: 'contact@isikef.u-jendouba.tn',
                            index: 2,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
