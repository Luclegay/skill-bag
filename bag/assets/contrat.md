# Contrat de tâche

<!-- Modèle (méthode BAG). À écrire et faire valider AVANT d’agir.
     Règle : chaque ligne « fini quand » se vérifie par oui ou par non,
     et on indique la preuve qui la vérifiera. -->

```
objectif :     [ce qu’il faut obtenir, en une phrase]
entrées :      [ce dont on part : fichiers, sources, maquette, données]
livrable :     [ce qui sera remis, et où]
contraintes :  [ce qu’on ne touche pas, ce qu’on n’utilise pas]
fini quand :   [condition 1]   → preuve : [contrôle]
               [condition 2]   → preuve : [contrôle]
               [condition 3]   → preuve : [contrôle]
arrêt :        3 tentatives par problème ; même échec deux fois → appel à un humain
```

## Exemple : un formulaire de contact

```
objectif :     ajouter un formulaire de contact
entrées :      maquette exportée, textes validés
livrable :     contact.html + styles dans style.css + envoi.php
contraintes :  CSS sans framework, ne pas toucher à l’en-tête ni au pied de page
fini quand :   la page s’affiche sans erreur console à 375 et 1440 px → captures
               le validateur HTML ne signale aucune erreur            → sortie du validateur
               chaque champ a un label, tout marche au clavier        → audit d’accessibilité
               un envoi de test arrive dans la boîte mail             → l’humain confirme
```

## Exemple : une synthèse documentaire

```
objectif :     synthèse de 2 pages sur [sujet] pour un comité de direction
entrées :      dossier sources/ (12 documents)
livrable :     synthese.md
contraintes :  aucune source extérieure au dossier, pas de chiffre non sourcé
fini quand :   chaque chiffre renvoie à un document du dossier      → script de contrôle des citations
               le plan suit les 4 questions du brief                → liste cochée
               la note dit clairement ce que les sources ne couvrent pas → relecture de la partie « limites »
               un relecteur neuf ne trouve ni affirmation sans source, ni chiffre déformé → rapport du sous-agent relecteur
```
