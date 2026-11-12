# Projet : [nom du projet]

<!-- Modèle de carte de projet (méthode BAG). Viser 30 à 60 lignes.
     C’est un sommaire qui renvoie vers d’autres fichiers, pas un manuel.
     Pour Claude Code : créer un CLAUDE.md qui contient seulement la ligne @AGENTS.md -->

## En une phrase
[Ce que fait le projet, pour qui.]

## Cadre technique (constaté le JJ/MM/AAAA, à confirmer)
[Outils, langage, logiciel ou hébergement visé. Ce qui est exclu, et pourquoi.]

## Commandes
- Lancer : [commande ou procédure]
- Vérifier : [commande des contrôles : tests, validateur, script de contrôle]

## Où trouver quoi
- Décisions et avancement → PROGRESS.md
- [Charte, structure des données, sources, brief…] → [chemin]

## Règles qui ne se discutent pas
<!-- Chaque règle importante est écrite deux fois : ici (le pourquoi)
     et, quand c’est possible, dans un contrôle automatique.
     Les règles qui ne s’automatisent pas (ton, style) restent à la relecture. -->
- [Règle] — contrôlée par : [contrôle, ou « relecture »]
- Les actions irréversibles (mise en ligne, envoi, suppression, paiement, données réelles) sont déclenchées par un humain.

## Méthode de travail (BAG)
- Chaque tâche démarre par un contrat « fini quand… » vérifiable par oui ou par non.
- Rien n’est « fini » sans preuve : contrôle lancé et résultat montré.
- Même échec deux fois, ou trois tentatives sans succès sur un problème → arrêt et appel à un humain.
- Un commit local par étape validée ; rien n’est poussé en ligne sans accord.
- PROGRESS.md est relu en début de session et mis à jour en fin de session.
