# 🎮 Pixel Odyssey

**Pixel Odyssey** est un jeu de plateforme 2D en cours de développement avec Godot 4.3, Pixel Odyssey est un jeu de plateforme 2D développé avec Godot 4.3, dans le cadre d'un projet de bac. Plongez dans un univers pixelisé coloré et dynamique, où vous incarnez un personnage devant traverser des niveaux remplis de pièges, collecter des gemmes et utiliser des checkpoints pour sauvegarder votre progression..

---

## 🗂 Structure du Projet

Le projet est structuré de manière logique et intuitive :

```plaintext
Pixel Odyssey/
├── assets/               # Ressources brutes
│   ├── audio/            # Fichiers audio (.wav, .mp3, .ogg)
│   │   ├── music/        # Musiques de fond
│   │   └── sfx/          # Effets sonores
│   ├── fonts/            # Polices de caractères (.ttf, .otf)
│   └── textures/         # Images et sprites
│       ├── backgrounds/  # Arrière-plans
│       ├── enemies/      # Sprites d'ennemis
│       ├── items/        # Sprites d'objets
│       ├── player/       # Sprites du joueur
│       ├── tilesets/     # Tuiles de terrain
│       ├── traps/        # Sprites de pièges
│       └── ui/           # Éléments d'interface
│
└── src/                  # Code source
    ├── scenes/           # Scènes Godot (.tscn)
    │   ├── enemies/      # Scènes d'ennemis
    │   ├── items/        # Scènes d'objets
    │   │   ├── checkpoints/
    │   │   ├── fruits/
    │   │   ├── gems/
    │   │   ├── platforms/
    │   │   └── portals/
    │   ├── levels/       # Niveaux de jeu
    │   ├── player/       # Personnage joueur
    │   ├── traps/        # Pièges et obstacles
    │   └── ui/           # Interface utilisateur
    │       ├── character_select/
    │       ├── level_select/
    │       ├── main_menu/
    │       ├── options/
    │       └── pause_menu/
    ├── scripts/          # Scripts GDScript (.gd)
    │   ├── enemies/
    │   ├── game_management/
    │   ├── items/
    │   │   ├── checkpoints/
    │   │   ├── fruits/
    │   │   ├── gems/
    │   │   ├── platforms/
    │   │   └── portals/
    │   ├── player/
    │   ├── traps/
    │   └── ui/
    └── resources/        # Ressources générées ou modifiées
        ├── animations/   # Données d'animation
        ├── audio/        # Fichiers audio traités
        ├── fonts/        # Configurations de polices
        └── textures/     # Textures générées/modifiées
```
---
### 🎮 Fonctionnalités actuelles
🕹️ Mouvement du joueur

    Déplacement latéral : Le joueur peut se déplacer à gauche et à droite.

    Saut : Le joueur peut sauter pour éviter les pièges et atteindre des plateformes.

    Double saut : Le joueur peut effectuer un deuxième saut en l'air.

    Dash : Une capacité de dash permet au joueur de traverser rapidement des zones dangereuses.

🗺️ Niveaux

    Checkpoints : Des drapeaux servent de checkpoints pour sauvegarder la position du joueur en cas de mort.

    Pièges : Des zones de mort et des pics blessent ou tuent le joueur.

    Portails : Les portails permettent de passer au niveau suivant une fois les objectifs accomplis.

💎 Collectibles

    Gemmes : Des gemmes sont dispersées dans les niveaux pour être collectées. Elles augmentent le score du joueur.

👾 Ennemis

    Slime : Un ennemi de base qui se déplace et attaque le joueur.

🎲 Gestion du jeu

    GameManager : Gère la logique du jeu, comme la sauvegarde des checkpoints, la gestion des vies, et la mise à jour de l'interface utilisateur.

    UI : Affiche le nombre de gemmes collectées et d'autres informations importantes.

⚠️ Messages d'alerte

    Ajouter un message : "Vous n'avez pas assez de gems pour activer le portail".
---
#### 🚧 Fonctionnalités à implémenter
🧭 Indications visuelles

   - Ajouter des flèches pour guider le joueur dans les niveaux.

🎨 Variété des décors :

   - Créer des fonds de carte différents pour chaque niveau.
   - Ajouter une variante mode difficile avec des fonds et des mécaniques spécifiques.

🎯 Modes de difficulté

  Mode Facile :

  - Checkpoints activés.

  - Gemmes conservées après la mort.

  Mode Difficile :

  - Gemmes réinitialisées à chaque mort.

  - Pas de checkpoints.

  - Ennemis plus rapides et plus nombreux.

  - Personnage plus rapide.

  - Gemmes deviennent rouges.

  - Pièges tuent en un coup.

🧑‍🎤 Choix du personnage

    Proposer des personnages avec des compétences uniques :

        Ninja Frog : Double saut.

        Virtual Guy : Dash (2 dashes par défaut, à ajuster par niveau).

    Afficher une barre de compétence en bas de l'écran.

💾 Système de sauvegarde

    Développer un système pour permettre au joueur de reprendre sa progression.


🛠️ Nouveaux pièges

    Boule à piques : Générée en boucle, tombe régulièrement.

    Scie : Similaire à la boule à piques, mais en mouvement circulaire.

    Tête de piques et tête de rocher : Montent et descendent avec un délai de 5 secondes.

    Feu : Ajouter un délai de 5 secondes entre les activations.

    Ventilateur : Permet de monter, avec des piques au-dessus en mode difficile.

🏗️ Plateformes spéciales

    Plateformes mouvantes : Se déplacent horizontalement ou verticalement.

    Plateformes temporaires : Disparaissent après un certain temps.

📚 Tutoriel

    Créer un écran d'explication pour guider les nouveaux joueurs.
---
### 📥 Installation

  Clonez ce dépôt :

    git clone https://github.com/EnzoCglc/Pixel-Odyssey.git

  Ouvrez le projet dans Godot 4.3.