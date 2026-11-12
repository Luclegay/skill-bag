# Historique des versions

## 0.3 — 12 novembre 2026

Issue de l’évaluation de la v0.2 (tests avec et sans la skill, comparaison avec les publications récentes d’Anthropic, OpenAI et Google).

- **Contrôle de fin de tour** (Claude Code) : un hook déclaré dans l’en-tête de la skill renvoie l’agent au travail s’il annonce une réussite sans preuve.
- **`/goal`** : pour une tâche longue, la skill propose la commande prête à copier, construite à partir du contrat (nouveau `references/claude-code.md`).
- **Début de session** : relire le journal, les derniers commits, et lancer le contrôle de base avant toute nouvelle tâche.
- **`fini-quand.json`** : les critères d’une tâche ou d’un projet dans un fichier où l’agent ne change que le statut et la preuve.
- **Goût** : grille de critères notés et relecteur exigeant pour le design et le ton (nouveau `references/gout.md`).
- **Harnais en six briques**, comme sur la page : Contrat, Cartographie, Outils, Mémoire, Barrières, Traces. Essais numérotés dans `PROGRESS.md`.
- **`PROGRESS.md`** : rubriques « Décisions » et « Surprises » ; une session neuve doit pouvoir reprendre à partir de ce seul fichier.
- **Barrières** : bac à sable natif en premier choix ; règles de commandes contournables signalées ; hook avec `$CLAUDE_PROJECT_DIR` et contrôle du seul fichier modifié ; messages d’échec qui disent quoi corriger.
- **Déclenchement** : description réécrite avec les demandes courantes (bug, « ça ne marche toujours pas », note, synthèse, « prouve-le ») ; retrait du déclencheur « quand l’agent s’apprête à annoncer c’est corrigé », qui ne pouvait pas fonctionner.
- **Micro** : le harnais n’est proposé qu’une fois par projet.
- **Cohabitation** avec d’autres méthodes : pas de demandes d’accord en double.
- **Tests** livrés dans `bag/evals/`.

## 0.2 — 12 novembre 2026

Première version publiée.
