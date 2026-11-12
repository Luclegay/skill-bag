# Preuves par type de projet

À lire quand tu choisis comment prouver une ligne « fini quand… ». Vise toujours le niveau le plus solide disponible : déterministe > observable > indépendant. L’auto-déclaration n’est jamais une preuve.

| Projet | Déterministe (une machine dit oui ou non) | Observable (trace montrée) | Indépendant (autre regard) |
|---|---|---|---|
| Site ou page web | validateur HTML, audit d’accessibilité automatisé (type axe), test qui clique sur les boutons (type Playwright) | captures à 375 px et à 1440 px, console du navigateur sans erreur | sous-agent relecteur sans historique |
| Application ou logiciel | tests automatiques, compilation, analyse statique (lint), test qui reproduit le bug avant correction | sortie complète des tests | revue par un sous-agent neuf |
| Script ou automatisation | exécution sur un jeu d’essai au résultat connu, comparaison avec la sortie attendue | journal d’exécution | relecture du script par un agent neuf |
| Tableur ou base de données | totaux de contrôle, nombre de lignes avant et après, aucune case obligatoire vide, pas de doublon | extrait avant / après | contrôle par sondage par l’humain |
| Rapport, synthèse, support de formation | script qui retrouve chaque chiffre et chaque citation dans les sources | liste des passages sources cités | relecteur neuf chargé de trouver les affirmations sans source |
| Assistant ou chatbot construit par l’utilisateur | jeu de questions types avec réponses attendues, rejoué après chaque modification | transcriptions des réponses | relecture humaine d’un échantillon |

## Règles

- **Rouge avant vert.** Lance le contrôle avant de corriger et constate qu’il échoue. Sinon il ne prouve rien.
- **Montrer, pas affirmer.** Dans le message final, cite la commande lancée et son résultat, ou joins la capture.
- **Un relecteur indépendant part d’un contexte vierge.** Il peut utiliser le même modèle, mais ne doit pas avoir vu le travail se faire. Donne-lui le contrat et le livrable, pas la conversation.
- **Un chiffre sourcé peut être déformé.** Retrouver un nombre dans la source ne suffit pas : « testé » n’est pas « adopté », « grandes entreprises » n’est pas « PME », « l’IA » n’est pas « l’IA générative ». Demande au relecteur indépendant de vérifier la fidélité du sens, pas seulement la présence du chiffre.
- **Juge aussi la source.** Date, périmètre, méthode, et ce qu’elle dit d’elle-même (une source qui se déclare fictive, provisoire ou partielle doit être signalée).
- **Un contrôle maison a des trous.** Dis ce qu’il ne vérifie pas (par exemple les titres, les images, les tableaux).
- **Ce qui ne peut pas être prouvé par la machine est dit comme tel** : « à confirmer par toi : l’email de test est-il bien arrivé ? »
