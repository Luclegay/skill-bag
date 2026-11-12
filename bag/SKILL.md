---
name: bag
description: "Méthode BAG (Boucle, hArnais, Graphe) pour faire travailler un agent IA de façon fiable : poser l’environnement du projet (carte AGENTS.md ou CLAUDE.md, journal PROGRESS.md, permissions), écrire pour chaque tâche un contrat « fini quand… » vérifiable, prouver le résultat avant de dire « terminé », s’arrêter au bon moment, et ne découper en sous-agents que si c’est utile. À utiliser au démarrage d’un projet (site, application, script, données, rapport, support de formation), quand l’utilisateur dit « active BAG », « applique la méthode BAG », « harness / loop / graph », quand une tâche doit être livrée avec une preuve, quand l’agent s’apprête à annoncer « c’est corrigé », ou quand un problème revient malgré plusieurs tentatives."
license: MIT
metadata:
  version: "0.2"
  langue: fr
---

# BAG : harnais, boucle, graphe

Trois couches, construites dans cet ordre, chacune répondant à une question :

1. **Harnais** (l’environnement) : est-ce que je *peux* agir ? Outils, carte du projet, mémoire sur disque, permissions, traces.
2. **Boucle** (la preuve) : est-ce *prouvé* ? Un objectif « fini quand… », une vérification qui peut échouer, un retour précis, des conditions d’arrêt.
3. **Graphe** (le flux) : *qui fait quoi ensuite* ? Seulement quand le travail se découpe vraiment en tâches indépendantes.

Le principe qui tient tout le reste : **une affirmation n’est pas une preuve**. « Ça devrait marcher » ne termine jamais une tâche ; un contrôle passé au vert, oui.

L’utilisateur n’est pas forcément développeur. Parle-lui en mots simples, sans jargon non défini.

## Règles de conduite

- **Doser selon la taille** (voir ci-dessous). La méthode doit faire gagner du temps, pas en coûter.
- **Un seul message pour demander l’accord.** Regroupe dans un même message ce que tu veux créer, le contrat de la tâche et tes questions. L’accord donné couvre les fichiers listés : ne redemande pas à chaque fichier.
- **Ne jamais franchir seul l’irréversible** : mise en ligne (FTP, déploiement, `git push`), envoi d’emails ou de messages, suppression de fichiers ou de données, écriture dans des données réelles (production), paiement, installation de logiciel. Tu prépares, l’humain déclenche. Les commits locaux, eux, se défont : une fois Git accepté, tu peux en faire sans redemander.
- **Ne pas inventer de preuve.** Si tu n’as pas pu lancer un contrôle, dis-le : « non vérifié, parce que… ». Si tu écris un réglage de mémoire sans pouvoir consulter la documentation, dis-le aussi.
- **Signaler, pas corriger en douce.** Un défaut trouvé hors de la demande (image manquante, erreur ailleurs) se signale et se propose comme mini-tâche ; il ne se corrige pas sans accord. Une amélioration sur les lignes mêmes que tu corriges (par exemple l’accessibilité du bouton réparé) fait partie du correctif, à condition de la mentionner.

## Doser selon la taille

| Taille | Exemples | Ce que tu poses |
|---|---|---|
| **Micro** | un correctif de quelques lignes, une question, une retouche | Un « fini quand… » de 1 à 3 lignes et sa preuve. Pas de harnais. Corrige puis montre la preuve, sans attendre d’accord, sauf si tu dois créer un fichier ou toucher à l’irréversible. En fin de tâche, si le projet n’a pas de harnais, propose-le en une phrase. |
| **Tâche** | un livrable unique : une page, une note, un script | Contrat complet + preuve. Harnais minimal : `PROGRESS.md`, et Git si le projet en a déjà ou si l’utilisateur l’accepte. |
| **Projet** | plusieurs sessions, plusieurs livrables, ou « active BAG » | Harnais complet (section 1), puis un contrat par tâche. |

Dans le doute, prends la taille inférieure et propose de monter d’un cran. Quelle que soit la taille, il te faut un moyen de constater le résultat (point 6 ci-dessous).

## 1. Harnais : équiper le projet

Commence par regarder ce qui existe déjà (carte, journal, Git, réglages de permissions). Ne remplace rien sans accord : complète.

1. **Carte du projet.** Crée ou complète `AGENTS.md` à la racine (lu par la plupart des agents). Pour Claude Code, `CLAUDE.md` peut contenir une seule ligne `@AGENTS.md` qui l’importe. Viser 30 à 60 lignes : un sommaire avec des renvois, pas un manuel. Modèle : [assets/AGENTS.md](assets/AGENTS.md).
2. **Journal de bord.** Crée `PROGRESS.md` avec les rubriques objectif / essayé / établi / suivant / jamais. Modèle : [assets/PROGRESS.md](assets/PROGRESS.md). Relis-le en début de session, mets-le à jour dès qu’un fait est établi ou qu’une tentative échoue, et en fin de session.
3. **Points de sauvegarde.** Si le projet n’est pas sous Git, propose de l’initialiser et explique ce qu’est un commit (un point de sauvegarde nommé). Fais un premier commit de l’état existant **avant** toute modification, avec un `.gitignore` (au minimum `.DS_Store`, `.env`). Ensuite, un commit par étape validée. Pour des documents hors code, l’historique des versions de l’outil peut suffire.
4. **Permissions.** Propose un réglage qui laisse lire et écrire dans le dossier du projet, protège ce qui doit l’être (sources en lecture seule, fichiers de secrets) et demande l’accord pour l’irréversible. Exemples : [references/barrieres.md](references/barrieres.md). Montre le fichier dans ton message d’accord.
5. **Connecteurs.** Tu ne peux pas les couper toi-même : ils relèvent des réglages de l’utilisateur. Signale seulement ceux qui exposent des données sensibles sans servir le projet (messagerie, agenda, stockage), en une phrase, et laisse-le décider.
6. **Les yeux pour vérifier.** Trouve comment tu constateras toi-même le résultat (navigateur pilotable, jeu d’essai, tests, relecture des sources) et **essaie-le tout de suite**. Si l’outil existe mais ne démarre pas, cherche un contournement sans rien installer ; sinon, dis ce qui manque et propose une solution, sans l’installer d’office.

## 2. Boucle : prouver chaque tâche

### Avant d’agir : le contrat

Lis d’abord les entrées (fichiers, sources, maquette), puis écris le contrat. Modèle : [assets/contrat.md](assets/contrat.md).

```
objectif :     …
entrées :      …
livrable :     …
contraintes :  …
fini quand :   [condition vérifiable par oui ou par non]   → preuve : [contrôle]
               [condition]                                 → preuve : [contrôle]
arrêt :        3 tentatives par problème ; même échec deux fois → appel à un humain
```

À un utilisateur non développeur, présente le contrat en phrases simples (« ce sera fini quand… ») ; garde le format ci-dessus dans `PROGRESS.md` ou dans tes notes.

« Le formulaire est joli » ne se vérifie pas. « Le formulaire tient sans défilement horizontal à 375 px » se vérifie. Si une ligne ne peut pas devenir vérifiable, pose la question plutôt que de deviner.

**Si les entrées ne permettent pas d’atteindre l’objectif** (donnée absente des sources, fichier manquant, demande contradictoire), dis-le **avant** de produire, explique ce qui manque, et propose un objectif reformulé que les entrées permettent de tenir. Ne comble jamais un manque par une invention plausible.

**Si l’utilisateur n’est pas là pour valider** mais t’a délégué la décision (« fais au mieux »), prends l’option la plus prudente, écris-la dans `PROGRESS.md`, et signale-la dans ton message final.

### Choisir la preuve de chaque ligne

Vise le niveau le plus solide possible :

1. **Déterministe** : une machine répond oui ou non (test, validateur, compilation, script de contrôle).
2. **Observable** : une trace montre que le contrôle a vraiment été lancé (sortie de commande, capture d’écran).
3. **Indépendante** : un relecteur qui n’a pas fait le travail, dans un contexte séparé (sous-agent neuf, ou humain).
4. **Auto-déclaration** (« j’ai vérifié », « ça a l’air bon ») : ce n’est pas une preuve. Ne termine jamais une tâche là-dessus.

Idées de preuves par type de projet : [references/preuves.md](references/preuves.md).

**Vois la preuve échouer d’abord.** Pour un bug, lance le contrôle sur l’état actuel et constate qu’il est rouge. Pour un livrable à créer, écris d’abord le contrôle et vérifie qu’il échoue sur un essai volontairement faux. Un contrôle qui n’a jamais dit non ne prouve rien.

**Range la preuve.** Un script de contrôle utile pour la suite va dans un dossier `outils/` du projet, commenté, et sans chemin qui dépend de ta machine ou d’un cache temporaire (sinon il cassera) ; un contrôle jetable se supprime, et tu dis qu’il l’a été.

**Ne modifie un contrôle que s’il se trompe** (faux positif avéré), jamais pour le faire passer. Note la modification dans `PROGRESS.md` et relance l’essai rouge pour vérifier qu’il sait encore dire non.

### Pendant : produire, vérifier, retour, corriger

Quand un contrôle échoue, structure ton retour ainsi (dans tes notes et dans `PROGRESS.md`) :

```
ÉCHEC      quel contrôle
ATTENDU    ce qui devait se passer
OBSERVÉ    ce qui s’est passé (fichier, ligne, écran)
PÉRIMÈTRE  ce que tu as le droit de toucher
IMPASSES   ce qui a déjà été tenté sans effet
```

À l’utilisateur, dis la même chose en deux ou trois phrases simples : ce qui ne marche pas, pourquoi, ce que tu vas faire.

### Les trois sorties, prévues dès le départ

- **Preuve verte** → terminé. Annonce : « Fini. Preuve : … » (commande lancée et résultat, capture, rapport du relecteur), puis ce qui n’est pas prouvé.
- **Même échec deux fois** (le même contrôle échoue pour la même cause, même si le chiffre bouge un peu) → arrête-toi et fais appel à l’humain. Il manque une information (harnais) ou la demande est mal posée (contrat). Dis lequel des deux tu soupçonnes.
- **Budget épuisé** : trois tentatives par problème, sauf autre consigne. Un problème qui revient après avoir été corrigé reprend son compteur là où il en était. Arrête-toi, résume l’état et ce qui bloque.

Une boucle peut corriger le travail, pas la question.

Si un relecteur indépendant a demandé des corrections importantes, fais relire la version corrigée ; sinon, signale qu’elle n’a pas été relue.

### Écrire deux fois chaque règle importante

Une règle écrite dans `AGENTS.md` peut s’oublier. Quand une règle compte (accessibilité, pas de clé d’API dans le code, ne pas toucher à tel dossier), propose aussi un **contrôle automatique** qui bloque si elle est violée : permission retirée, script qui refuse un commit, validateur lancé après chaque modification. Toutes les règles ne s’automatisent pas (le ton d’un texte, par exemple) : dis lesquelles restent à la relecture.

Un contrôle lancé automatiquement après chaque modification (un *hook*) est une automatisation qui reste en place : explique-le à part, réserve-le aux contrôles rapides (quelques secondes), et fais-le porter sur les fichiers modifiés si le projet a déjà des défauts, sinon il les signalera à chaque fois. Exemples : [references/barrieres.md](references/barrieres.md).

## 3. Graphe : seulement si nécessaire

Par défaut, une seule boucle suffit. N’envisage un découpage en plusieurs tâches (sous-agents) que pour un gros chantier : audit section par section, migration de nombreuses pages, lot de documents, veille sur de nombreuses sources. Avant de découper, essaie de tout garder dans une boucle ; si rien ne se perd, garde-la.

Si tu découpes, applique : [references/graphe.md](references/graphe.md) (test de démarrage anticipé, un contexte propre par tâche, du code pour ce qui ne doit jamais varier, résultats validés gelés, contrôle proportionné au prix de l’annulation).

## Quand ça coince : diagnostic avant ordonnance

Quand un problème résiste ou revient, ne réécris pas tout. Lis cette grille de haut en bas et traite le premier symptôme présent :

| Symptôme | Couche | Correctif |
|---|---|---|
| L’utilisateur fait des copier-coller entre le chat et ses outils | Harnais | Te donner l’outil qui manque |
| Une session retente ce qui a déjà échoué | Harnais | Une mémoire sur disque (PROGRESS.md) |
| « Fini » ne veut rien dire tant que l’humain n’a pas vérifié | Boucle | Une vérification qui peut échouer |
| Les tentatives brûlent le budget sur la même erreur | Boucle | Des retours précis et des sorties |
| Chaque étape est juste, mais l’ensemble est lent | Graphe | Découper en vraies tâches indépendantes |
| Un seul échec fait tout relancer | Graphe | Geler les résultats validés |
| La même erreur revient chaque semaine | Toutes | Ranger la leçon dans la couche responsable |

Un problème de harnais masque les problèmes de boucle, qui masquent ceux du graphe : d’où l’ordre.

## Chaque échec améliore le système

Quand une erreur revient, ne te contente pas de corriger le résultat. Propose de ranger la leçon au bon endroit :

- une ligne « jamais » dans `PROGRESS.md` (approche ratée à ne pas refaire) ;
- une permission retirée (fichier ou action interdits) ;
- un contrôle automatique ajouté (un « corrigé » sans preuve) ;
- une règle de découpage (deux tâches qui se sont chevauchées).

Évite de répondre à une erreur par une phrase de plus dans le prompt : un souhait écrit s’oublie, une structure reste.

## Fin de tâche ou de session

1. Mets à jour `PROGRESS.md` (fait, établi, suivant, nouvelles lignes « jamais »).
2. Fais un commit local avec un message explicite si Git est en place (ne pousse rien en ligne sans accord).
3. Termine ton message par trois lignes : **Prouvé** : … / **Pas prouvé** : … / **Suite** : …

## Entretien

Chaque élément du harnais traduit une hypothèse sur ce que le modèle ne sait pas faire seul. Quand l’utilisateur change de modèle ou d’outil, propose de relire la carte et les contrôles : retirer ce qui ne sert plus, ajouter ce qui débloque de nouvelles tâches.

## Ce que cette skill ne fait pas

Elle ne met rien en ligne, n’envoie rien, ne supprime rien sans accord explicite, n’envoie aucune donnée ailleurs, n’installe aucun logiciel sans le proposer, et ne remplace pas le jugement de l’utilisateur sur ce qui est irréversible.
