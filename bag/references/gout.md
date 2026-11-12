# Prouver ce qui relève du goût

À lire quand une ligne du contrat porte sur la qualité perçue (design, ton, clarté d’un texte) et ne se vérifie pas par oui ou par non.

« Est-ce beau ? » n’a pas de réponse stable. « Est-ce que ça respecte nos principes ? » en a une. On transforme donc le goût en **grille de critères notés**, jugée par un **relecteur séparé**, réglé pour être exigeant.

## 1. Écrire la grille avec l’utilisateur

Trois à cinq critères, chacun noté de 1 à 5, avec un seuil. Partir de ce que l’utilisateur dit vouloir, de sa charte ou de ses exemples préférés. Ce qui peut être mesuré par une machine sort de la grille et devient une preuve déterministe (contraste AA, taille minimale du texte).

Exemple pour une page web :

| Critère | Ce qu’on regarde | Seuil |
|---|---|---|
| Hiérarchie | à 375 px, l’œil va d’abord au titre, puis à l’action principale | 4 |
| Cohérence | mêmes rayons, mêmes espacements, mêmes couleurs que la charte | 4 |
| Lisibilité | longueur de ligne, interlignage, aucun bloc compact | 4 |
| Caractère | ne ressemble pas à un modèle générique ; reconnaissable sans le logo | 3 |

Exemple pour un texte :

| Critère | Ce qu’on regarde | Seuil |
|---|---|---|
| Clarté | un non-spécialiste comprend chaque paragraphe sans relire | 4 |
| Ton | conforme à la consigne (tutoiement, direct, sans jargon) | 4 |
| Densité | aucune phrase qu’on peut retirer sans perte | 3 |

Attention : les mots de la grille orientent le travail. « Digne d’un musée » pousse tout vers le même style. Préférer des critères observables.

## 2. Caler le relecteur

Le juge est un modèle : il a tendance à être indulgent avec un travail produit par un modèle. Pour le rendre fiable :

- un **contexte neuf** (sous-agent qui n’a pas vu le travail se faire), avec la grille, le livrable, et les captures à 375 et 1440 px pour un écran ;
- une consigne explicite : **chercher ce qui ne va pas**, noter chaque critère avec une phrase de justification, et citer l’endroit précis ;
- si possible, **un ou deux exemples notés** par l’utilisateur (« cette page, je lui donne 2 en hiérarchie, parce que… ») : ils alignent le jugement du relecteur sur le sien.

Consigne type pour le relecteur :

```
Tu relis un livrable que tu n’as pas produit. Ton rôle est de trouver ses défauts.
Grille : [critères, ce qu’on regarde, seuil]
Exemples notés par l’utilisateur : [facultatif]
Pour chaque critère : une note de 1 à 5, une phrase de justification, l’endroit précis.
Termine par : critères sous le seuil, et la correction la plus utile pour chacun.
```

## 3. Boucler

Un critère sous le seuil est un échec comme un autre : retour précis, correction, nouvelle relecture. Mêmes sorties que la boucle (trois tentatives, même échec deux fois → appel à un humain). Une note peut baisser alors que l’ensemble s’améliore : montre l’évolution à l’utilisateur plutôt que de garder seulement la dernière version.

Ce que la grille ne remplace pas : l’avis de l’utilisateur. Le message final dit « jugé par un relecteur avec la grille : … ; à confirmer par toi ».
