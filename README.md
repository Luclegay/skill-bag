# Skill BAG : harnais, boucle, graphe

Une skill qui fait travailler ton agent IA (Claude Code, Codex, Cursor…) en trois couches : il pose son environnement, prouve chaque résultat avant de dire « fini », et ne découpe le travail que si c’est utile.

Explication complète de la méthode : [lien vers la page, à compléter].

## Ce qu’elle fait

- Au démarrage d’un projet : crée ou complète la carte du projet (`AGENTS.md`, et `CLAUDE.md` pour Claude Code) et le journal de bord (`PROGRESS.md`), propose des permissions qui gardent l’irréversible entre tes mains.
- Pour chaque tâche : écrit un contrat « fini quand… » vérifiable, choisit la preuve de chaque ligne, la voit échouer d’abord, puis corrige jusqu’au vert.
- S’arrête au bon moment : même résultat deux fois, ou trois tentatives, et elle te demande de l’aide au lieu de tourner en rond.
- Quand un problème revient : cherche la couche en cause et range la leçon au bon endroit.

## Ce qu’elle ne fait pas

Elle ne met rien en ligne, n’envoie rien, ne supprime rien sans ton accord, n’envoie aucune donnée ailleurs et n’installe aucun logiciel sans te le proposer. Elle ne remplace pas tes propres vérifications sur ce qui est irréversible.

## Installer

Le dossier `bag/` suit le format ouvert [Agent Skills](https://agentskills.io) (un dossier avec un fichier `SKILL.md`).

**Le plus simple** : copie cette phrase dans ton agent, ouvert dans ton projet.

> Installe la skill BAG depuis https://github.com/Luclegay/skill-bag dans ce projet. Avant de l’activer, explique-moi ce qu’elle va ajouter ou modifier.

**À la main**, copie le dossier `bag/` :

- Claude Code : dans `.claude/skills/` du projet (ou `~/.claude/skills/` pour tous tes projets).
- Autres agents compatibles Agent Skills : dans le dossier de skills indiqué par leur documentation.

Ensuite, dis simplement : « Active BAG pour ce projet. »

## Enlever

Supprime le dossier `bag/`. Les fichiers qu’elle a créés dans ton projet (`AGENTS.md`, `PROGRESS.md`, réglages) restent : ils sont à toi, garde-les ou supprime-les.

## Contenu

```
bag/
├── SKILL.md              la méthode, chargée quand la skill s’active
├── references/
│   ├── preuves.md        des preuves par type de projet
│   ├── barrieres.md      permissions et contrôles automatiques
│   └── graphe.md         découper le travail entre plusieurs tâches
└── assets/
    ├── AGENTS.md         modèle de carte de projet
    ├── PROGRESS.md       modèle de journal de bord
    └── contrat.md        modèle de contrat « fini quand… »
```

## Licence

MIT : tu peux utiliser, modifier et partager librement. Voir [LICENSE](LICENSE).
