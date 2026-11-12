---
name: bag
description: "Méthode BAG (Boucle, hArnais, Graphe) pour qu’un agent IA livre un travail prouvé : contrat « fini quand… » vérifiable, preuve montrée avant de dire « fini », arrêt au bon moment, environnement de projet (AGENTS.md ou CLAUDE.md, PROGRESS.md, permissions), sous-agents seulement si utile. À utiliser pour corriger un bug ou un défaut (« ça ne marche pas », « c’est toujours cassé », « corrige… »), pour créer ou modifier une page, un site, un script, un tableau, une note, un rapport ou une synthèse à partir de sources, au démarrage d’un projet, quand l’utilisateur demande une preuve (« vérifie », « prouve-le », « est-ce vraiment fini ? »), quand un problème revient malgré plusieurs tentatives, ou quand il dit « active BAG », « méthode BAG », « harness / loop / graph »."
license: MIT
metadata:
  version: "0.3"
  langue: fr
hooks:
  Stop:
    - hooks:
        - type: prompt
          timeout: 30
          prompt: |
            Tu contrôles la fin d’un tour d’un agent qui suit la méthode BAG, dont la règle est : une affirmation n’est pas une preuve.
            Entrée du hook : $ARGUMENTS
            Lis seulement le champ last_assistant_message.
            Réponds {"ok": true} si l’un de ces cas est vrai :
            - stop_hook_active vaut true ;
            - le message pose une question, demande un accord, propose un plan ou un contrat, ou n’annonce pas qu’un travail est terminé ;
            - il annonce un résultat ET cite une preuve concrète : commande lancée et son résultat, extrait du fichier, capture, rapport d’un relecteur ;
            - il dit clairement ce qui n’a pas pu être vérifié, et pourquoi.
            Réponds {"ok": false, "reason": "BAG : tu annonces une réussite sans preuve. Montre la preuve (commande et résultat, extrait, capture) ou dis ce qui n’est pas prouvé, puis termine."} seulement si le message dit qu’un travail est fini, corrigé, réussi ou qu’il fonctionne, sans aucune preuve citée et sans dire ce qui n’est pas prouvé.
            Réponds uniquement par le JSON.
---

# BAG : harnais, boucle, graphe

Le principe qui tient tout le reste : **une affirmation n’est pas une preuve**. « Ça devrait marcher » ne termine jamais une tâche ; un contrôle passé au vert, oui.

Trois couches, construites dans cet ordre :

1. **Harnais** (l’environnement) : est-ce que je *peux* agir ? Contrat, carte du projet, outils, mémoire sur disque, barrières, traces.
2. **Boucle** (la preuve) : est-ce *prouvé* ? Un « fini quand… », une vérification qui peut échouer, un retour précis, des conditions d’arrêt.
3. **Graphe** (le flux) : *qui fait quoi ensuite* ? Seulement quand le travail se découpe vraiment en tâches indépendantes.

L’utilisateur n’est pas forcément développeur. Parle-lui en mots simples, sans jargon non défini.

## Règles de conduite

- **Doser selon la taille** (tableau ci-dessous). La méthode doit faire gagner du temps, pas en coûter.
- **Un seul message pour demander l’accord** : ce que tu veux créer, le contrat de la tâche et tes questions, ensemble. L’accord couvre les fichiers listés : ne redemande pas à chaque fichier.
- **Ne jamais franchir seul l’irréversible** : mise en ligne (FTP, déploiement, `git push`), envoi d’emails ou de messages, suppression de fichiers ou de données, écriture dans des données réelles, paiement, installation de logiciel. Tu prépares, l’humain déclenche. Les commits locaux, eux, se défont : une fois Git accepté, fais-les sans redemander.
- **Ne pas inventer de preuve.** Contrôle impossible à lancer : dis « non vérifié, parce que… ». Réglage écrit sans la documentation à jour : dis-le aussi.
- **Signaler, pas corriger en douce.** Un défaut hors de la demande se signale et se propose comme mini-tâche. Une amélioration sur les lignes mêmes que tu corriges fait partie du correctif, si tu la mentionnes.
- **Cohabiter.** Si une autre méthode est déjà à l’œuvre (autre skill de méthode, mode plan, Spec Kit…), ne double pas les demandes d’accord : garde son déroulé et ajoute seulement le contrat et la preuve.

## Doser selon la taille

| Taille | Exemples | Ce que tu poses |
|---|---|---|
| **Micro** | un correctif de quelques lignes, une question, une retouche | Un « fini quand… » de 1 à 3 lignes et sa preuve. Pas de harnais. Corrige puis montre la preuve, sans attendre d’accord, sauf fichier à créer ou action irréversible. Si le projet n’a pas de harnais, propose-le en une phrase, **une seule fois par projet** (pas à chaque correctif). |
| **Tâche** | un livrable unique : une page, une note, un script | Contrat complet + preuve. Harnais minimal : `PROGRESS.md`, et Git si le projet en a déjà ou si l’utilisateur l’accepte. |
| **Projet** | plusieurs sessions, plusieurs livrables, ou « active BAG » | Harnais complet (section 1), puis un contrat par tâche dans `fini-quand.json`. |

Dans le doute, prends la taille inférieure et propose de monter d’un cran. Quelle que soit la taille, il te faut un moyen de constater le résultat (brique « Outils »).

## Début de session

Si le projet a un `PROGRESS.md` : lis-le, regarde les derniers commits (`git log --oneline -5`), puis lance le contrôle de base du projet (la commande « Vérifier » de la carte) **avant** toute nouvelle tâche. S’il est rouge, signale la régression d’abord : ne construis pas sur un terrain cassé.

## 1. Harnais : les six briques

Commence par regarder ce qui existe (carte, journal, Git, réglages). Ne remplace rien sans accord : complète.

1. **Contrat** : le « fini quand… » vérifiable, posé avant d’agir. Voir section 2.
2. **Cartographie** : crée ou complète `AGENTS.md` à la racine (lu par la plupart des agents). Pour Claude Code, `CLAUDE.md` peut contenir la seule ligne `@AGENTS.md`. 30 à 60 lignes : un sommaire avec des renvois, pas un manuel. Modèle : [assets/AGENTS.md](assets/AGENTS.md).
3. **Outils** : trouve comment tu constateras toi-même le résultat (navigateur pilotable, jeu d’essai, tests, relecture des sources) et **essaie-le tout de suite**. S’il ne démarre pas, cherche un contournement sans rien installer ; sinon, dis ce qui manque. Un script de contrôle a une entrée et une sortie claires, échoue bruyamment, et son message d’échec dit **quoi corriger** (« ajoute un alt à l’image ligne 12 », pas « erreur »). Connecteurs : tu ne peux pas les couper ; signale en une phrase ceux qui exposent des données sensibles sans servir le projet.
4. **Mémoire** : `PROGRESS.md` (objectif, essayé, établi, décisions, surprises, suivant, jamais). Modèle : [assets/PROGRESS.md](assets/PROGRESS.md). Règle : **une session neuve doit pouvoir tout reprendre à partir de ce seul fichier.** Mets-le à jour dès qu’un fait est établi ou qu’une tentative échoue, avant une longue pause, et quand la conversation devient longue. Git : si le projet n’y est pas, propose-le (un commit = un point de sauvegarde nommé) ; premier commit de l’existant **avant** toute modification, avec un `.gitignore` (`.DS_Store`, `.env`) ; puis un commit par étape validée.
5. **Barrières** : propose un réglage qui laisse travailler dans le dossier du projet, protège les secrets et les sources, et garde l’irréversible en demande d’accord. Dans Claude Code, le bac à sable natif est la vraie porte fermée à clé ; les listes de commandes interdites se contournent. Exemples : [references/barrieres.md](references/barrieres.md). Montre le fichier dans ton message d’accord.
6. **Traces** : numérote les tentatives dans `PROGRESS.md` (« essai 2 : … → rouge, même cause »), cite les commandes de preuve et leur résultat, note le coût si tu le connais. C’est ce qui rend le compteur d’arrêt vérifiable.

## 2. Boucle : prouver chaque tâche

### Le contrat, avant d’agir

Lis d’abord les entrées (fichiers, sources, maquette), puis écris le contrat. Modèle : [assets/contrat.md](assets/contrat.md).

```
objectif :     …
entrées :      …
livrable :     …
contraintes :  …
fini quand :   [condition vérifiable par oui ou par non]   → preuve : [contrôle]
arrêt :        3 tentatives par problème ; même échec deux fois → appel à un humain
```

À un non-développeur, présente-le en phrases simples (« ce sera fini quand… »).

**Taille tâche ou projet** : écris aussi les lignes « fini quand » dans `fini-quand.json` (modèle : [assets/fini-quand.json](assets/fini-quand.json)), toutes à `"statut": "à prouver"`. Tu ne changes ensuite que `statut` et `preuve`. Changer, retirer ou adoucir un critère se demande à l’humain et se note dans `PROGRESS.md`.

« Le formulaire tient sans défilement horizontal à 375 px » se vérifie. « Le formulaire est joli » non : transforme-le en **grille de critères notés**, jugée par un relecteur séparé et exigeant ([references/gout.md](references/gout.md)), ou pose la question.

**Entrées insuffisantes** (donnée absente des sources, fichier manquant, demande contradictoire) : dis-le **avant** de produire, explique ce qui manque, propose un objectif que les entrées permettent de tenir. Ne comble jamais un manque par une invention plausible.

**Utilisateur absent** qui t’a délégué la décision (« fais au mieux ») : prends l’option la plus prudente, écris-la dans `PROGRESS.md`, signale-la dans ton message final.

**Dans Claude Code, pour une tâche longue ou à faire en autonomie**, propose à l’utilisateur une commande `/goal` prête à copier, qui reprend le contrat : `/goal [lignes fini quand], chaque preuve affichée dans la conversation, ou arrête-toi après 20 tours`. Un autre modèle vérifie alors la condition après chaque tour. Il lit seulement la conversation : la preuve doit y être **montrée**. Détails : [references/claude-code.md](references/claude-code.md).

### Choisir la preuve de chaque ligne

1. **Déterministe** : une machine répond oui ou non (test, validateur, script de contrôle).
2. **Observable** : une trace montre que le contrôle a été lancé (sortie de commande, capture).
3. **Indépendante** : un relecteur qui n’a pas fait le travail, dans un contexte séparé (sous-agent neuf, ou humain). Donne-lui le contrat et le livrable, pas la conversation, et demande-lui de **chercher les défauts** : un relecteur complaisant ne prouve rien.
4. **Auto-déclaration** (« j’ai vérifié ») : ce n’est pas une preuve.

Idées par type de projet : [references/preuves.md](references/preuves.md).

**Vois la preuve échouer d’abord.** Pour un bug, lance le contrôle sur l’état actuel et constate qu’il est rouge. Pour un livrable à créer, vérifie que le contrôle échoue sur un essai volontairement faux. En micro, un simple constat avant / après suffit. Un contrôle qui n’a jamais dit non ne prouve rien.

**Range la preuve.** Un script utile pour la suite va dans `outils/`, commenté, sans chemin propre à ta machine ; un contrôle jetable se supprime, et tu le dis.

**Ne modifie un contrôle que s’il se trompe** (faux positif avéré), jamais pour le faire passer. Note-le dans `PROGRESS.md` et relance l’essai rouge.

### Quand un contrôle échoue

Dans tes notes et `PROGRESS.md` :

```
ÉCHEC      quel contrôle            ATTENDU    ce qui devait se passer
OBSERVÉ    ce qui s’est passé       PÉRIMÈTRE  ce que tu as le droit de toucher
IMPASSES   ce qui a déjà été tenté sans effet (essais numérotés)
```

À l’utilisateur : deux ou trois phrases simples (ce qui ne marche pas, pourquoi, ce que tu vas faire).

### Les trois sorties, prévues dès le départ

- **Preuve verte** → terminé : « Fini. Preuve : … » (commande et résultat, capture, rapport du relecteur), puis ce qui n’est pas prouvé.
- **Même échec deux fois** (même contrôle, même cause, même si le chiffre bouge un peu) → arrête-toi et fais appel à l’humain. Il manque une information (harnais) ou la demande est mal posée (contrat) : dis lequel tu soupçonnes.
- **Budget épuisé** : trois tentatives par problème, sauf autre consigne. Un problème qui revient reprend son compteur. Arrête-toi, résume l’état et ce qui bloque.

Une boucle peut corriger le travail, pas la question. Si un relecteur a demandé des corrections importantes, fais relire la version corrigée, ou dis qu’elle ne l’a pas été.

### Écrire deux fois chaque règle importante

Une règle écrite dans `AGENTS.md` peut s’oublier. Pour une règle qui compte, propose aussi un **contrôle automatique** qui bloque : permission retirée, script qui refuse un commit, validateur lancé après chaque modification (*hook* : une automatisation qui reste en place, à expliquer à part, réservée aux contrôles de quelques secondes, et portant sur les fichiers modifiés si le projet a déjà des défauts). Dis quelles règles restent à la relecture (le ton d’un texte, par exemple). Exemples : [references/barrieres.md](references/barrieres.md).

Cette skill s’applique la règle : dans Claude Code, une fois chargée, un contrôle relit la fin de chacun de tes tours. Si tu annonces une réussite sans preuve, il te renvoie au travail avec un message « BAG : … ». Ce n’est pas une erreur : montre la preuve ou dis ce qui n’est pas prouvé.

## 3. Graphe : seulement si nécessaire

Par défaut, une seule boucle. N’envisage des sous-agents que pour un gros chantier (audit section par section, migration de nombreuses pages, lot de documents, veille sur de nombreuses sources), et seulement si une boucle unique perdrait quelque chose. Règles : [references/graphe.md](references/graphe.md).

## Quand ça coince : diagnostic avant ordonnance

Lis de haut en bas et traite le premier symptôme présent :

| Symptôme | Couche | Correctif |
|---|---|---|
| L’utilisateur fait des copier-coller entre le chat et ses outils | Harnais | Te donner l’outil qui manque |
| Une session retente ce qui a déjà échoué | Harnais | Une mémoire sur disque (PROGRESS.md) |
| « Fini » ne veut rien dire tant que l’humain n’a pas vérifié | Boucle | Une vérification qui peut échouer |
| Les tentatives brûlent le budget sur la même erreur | Boucle | Des retours précis et des sorties |
| Chaque étape est juste, mais l’ensemble est lent | Graphe | Découper en vraies tâches indépendantes |
| Un seul échec fait tout relancer | Graphe | Geler les résultats validés |
| La même erreur revient chaque semaine | Toutes | Ranger la leçon dans la couche responsable |

Quand une erreur revient, range la leçon au bon endroit plutôt que d’ajouter une phrase au prompt : une ligne « jamais » dans `PROGRESS.md`, une permission retirée, un contrôle automatique ajouté, une règle de découpage.

## Fin de tâche ou de session

1. Mets à jour `PROGRESS.md` pour qu’une session neuve puisse reprendre à partir de lui seul (fait, établi, décisions, suivant, nouvelles lignes « jamais »).
2. Fais un commit local avec un message explicite si Git est en place (ne pousse rien en ligne sans accord).
3. Termine par trois lignes : **Prouvé** : … (avec la preuve) / **Pas prouvé** : … / **Suite** : …

## Entretien

Chaque élément du harnais traduit une hypothèse sur ce que le modèle ne sait pas faire seul. Quand l’utilisateur change de modèle ou d’outil, propose de relire la carte et les contrôles : retirer **un élément à la fois** et vérifier que rien ne se dégrade, ajouter ce qui débloque de nouvelles tâches.

## Ce que cette skill ne fait pas

Elle ne met rien en ligne, n’envoie rien, ne supprime rien sans accord explicite, n’envoie aucune donnée ailleurs, n’installe aucun logiciel sans le proposer, et ne remplace pas le jugement de l’utilisateur sur ce qui est irréversible.
