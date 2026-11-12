# BAG dans Claude Code : `/goal` et le contrôle de fin de tour

À lire quand tu travailles dans Claude Code et qu’une tâche doit avancer longtemps ou sans surveillance. Les réglages évoluent vite : si tu n’as pas pu consulter la documentation à jour (https://code.claude.com/docs/en/goal), dis-le à l’utilisateur.

## `/goal` : la boucle BAG outillée

`/goal` fait continuer Claude jusqu’à ce qu’une condition soit remplie. Après chaque tour, un autre modèle, plus petit, lit la conversation et répond : pas encore, atteint, ou impossible. C’est la boucle BAG avec un vérificateur séparé et un arrêt qui ne dépend pas de ta mémoire.

C’est une commande de l’utilisateur : propose-la, prête à copier, il la tape lui-même.

### Traduire le contrat en `/goal`

Une bonne condition contient :

- **un état final mesurable** : un test qui passe, un validateur sans erreur, un nombre de fichiers ;
- **la preuve attendue** : « la sortie de `python3 outils/verifier.py` affiche 0 erreur » ;
- **les contraintes** : « sans modifier l’en-tête ni le pied de page » ;
- **une limite** : « ou arrête-toi après 20 tours ».

Exemple, à partir du contrat d’un formulaire de contact :

```
/goal contact.html passe le validateur HTML sans erreur, chaque champ a un label, l’audit d’accessibilité ne signale rien à 375 et 1440 px ; montre la sortie de chaque contrôle dans la conversation ; ne touche pas à l’en-tête ni au pied de page ; ou arrête-toi après 20 tours
```

Le vérificateur ne lance aucune commande et ne lit aucun fichier : il juge sur ce que tu as **montré** dans la conversation. Affiche donc la sortie des contrôles, pas un résumé.

Ce que `/goal` ne remplace pas : les lignes qui demandent un humain (« un envoi de test arrive dans la boîte mail ») restent hors de la condition, et se signalent à la fin comme « pas prouvé ».

Commandes utiles à donner à l’utilisateur : `/goal` seul pour voir l’état, `/goal clear` pour arrêter.

## Le contrôle de fin de tour de la skill

Le fichier `SKILL.md` déclare un *hook* `Stop` : une fois la skill chargée, et jusqu’à la fin de la session, un petit modèle relit la fin de chacun de tes tours. Si tu annonces qu’un travail est fini ou corrigé sans citer de preuve ni dire ce qui n’est pas prouvé, il te renvoie au travail avec un message qui commence par « BAG : ».

- Ce n’est pas une erreur : montre la preuve, ou dis ce qui n’a pas pu être vérifié, puis termine.
- Il ne bloque pas les questions, les demandes d’accord ni les plans.
- Il coûte un appel à un petit modèle par tour.
- Les autres agents (Codex, Cursor…) ignorent ce réglage : la règle reste écrite dans la skill.

Si l’utilisateur trouve ce contrôle gênant, il peut retirer le bloc `hooks:` de l’en-tête de `SKILL.md` (dans le terminal, `/hooks` permet aussi de le voir et de le désactiver).

## Pour un projet suivi sur plusieurs sessions

Un hook installé dans le projet reste en place d’une session à l’autre, alors que celui de la skill ne s’active qu’une fois la skill chargée. Pour un projet BAG, propose (avec accord, en l’expliquant à part) un contrôle après chaque modification, décrit dans [barrieres.md](barrieres.md).
