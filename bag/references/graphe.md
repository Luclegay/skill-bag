# Graphe : découper le travail entre plusieurs tâches

À lire seulement quand le travail est assez gros pour être réparti (plusieurs sous-agents ou plusieurs étapes indépendantes). Dans le doute, garde une seule boucle : plus il y a de pièces, plus il y a de choses qui cassent.

Un graphe a trois éléments : des **nœuds** (tâches délimitées, avec une entrée et une sortie), des **arêtes** (vraies dépendances : la sortie de l’un nourrit l’entrée de l’autre) et un **état** (ce qui passe d’une tâche à l’autre, écrit dans un fichier). Chaque nœud fait tourner sa propre boucle, avec son contrat et sa preuve.

## Cinq règles

1. **Test de démarrage anticipé.** Pour chaque flèche A → B, demande : « que se passerait-il si B démarrait avant la fin de A ? » Si rien : la flèche est une habitude, supprime-la et lance les deux en parallèle. Si B manquerait de ce qu’il lui faut : vraie dépendance, garde-la.
2. **Découpe selon les causes d’échec.** Deux étapes qui peuvent échouer pour des raisons différentes font deux nœuds ; si elles échouent toujours ensemble, un seul.
3. **Un contexte propre par tâche.** Des sous-agents qui partagent le même contexte ne sont qu’un agent à plusieurs rôles : le premier avis contamine les autres. Donne à chacun son contrat et ses entrées, pas la conversation.
4. **Du code pour ce qui ne doit jamais varier.** Trier, compter, dédupliquer, assembler, renommer, convertir : un script, pas le modèle. Garde le modèle pour ce qui demande du jugement (rédiger, résumer, choisir).
5. **Gèle ce qui est validé.** Une sortie qui a passé son contrôle ne se modifie plus. En cas d’échec, relance uniquement le nœud concerné, avec le retour obtenu.

## Portes de contrôle selon le prix de l’annulation

| Annulation | Exemples | Règle |
|---|---|---|
| En un clic | documentation, tests, une fonction isolée, un brouillon | livré si les contrôles sont verts |
| Avec nettoyage | fonctions partagées, authentification, structure des données | contrôles verts + trace + second avis indépendant |
| Impossible | migrations, suppressions, emails, paiements, mise en ligne | **un humain signe** |

Le dernier palier ne dépend d’aucun degré de confiance : c’est toujours l’humain qui valide.

## Format de plan à présenter avant de lancer

```
TÂCHES EN PARALLÈLE
  1. [tâche] — contrat : … — preuve : …
  2. [tâche] — contrat : … — preuve : …
ASSEMBLAGE (script)
  [comment les résultats sont réunis]
PORTE DE CONTRÔLE
  [niveau selon le prix de l’annulation]
DÉPENDANCES GARDÉES (test de démarrage anticipé)
  [A → B : pourquoi]
```
