# Skill BAG : harnais, boucle, graphe

Une skill qui fait travailler ton agent IA (Claude Code, Codex, Cursor…) en trois couches : il pose son environnement, prouve chaque résultat avant de dire « fini », et ne découpe le travail que si c’est utile.

Explication complète de la méthode : [Harnais, boucle, graphe : le mode d’emploi des agents IA](https://bag.ru3.com/).

Version 0.3. Nouveautés : voir [CHANGELOG.md](CHANGELOG.md).

## Ce qu’elle fait

- Au démarrage d’un projet : crée ou complète la carte du projet (`AGENTS.md`, et `CLAUDE.md` pour Claude Code) et le journal de bord (`PROGRESS.md`), propose des permissions et un bac à sable qui gardent l’irréversible entre tes mains.
- En début de session : relit le journal et vérifie que rien n’a cassé avant de commencer.
- Pour chaque tâche : écrit un contrat « fini quand… » vérifiable, choisit la preuve de chaque ligne, la voit échouer d’abord, puis corrige jusqu’au vert. Pour le design ou le ton d’un texte, elle propose une grille de critères notés par un relecteur exigeant.
- S’arrête au bon moment : même échec deux fois, ou trois tentatives, et elle te demande de l’aide au lieu de tourner en rond.
- Quand un problème revient : cherche la couche en cause et range la leçon au bon endroit.

## Le contrôle de fin de tour (Claude Code seulement)

La skill s’applique sa propre règle « écrire deux fois » : dans Claude Code, une fois chargée, un petit modèle relit la fin de chaque réponse de l’agent. S’il annonce « c’est corrigé » ou « ça marche » sans montrer de preuve ni dire ce qui n’est pas prouvé, il est renvoyé au travail.

- Coût : un appel à un petit modèle par réponse, pour le reste de la session.
- Il ne bloque pas les questions, les demandes d’accord ni les plans.
- Pour le retirer : supprime le bloc `hooks:` en tête de `bag/SKILL.md`.
- Les autres agents ignorent ce réglage ; la règle reste écrite dans la skill.

Pour une tâche longue, la skill te propose aussi une commande `/goal` prête à copier : Claude Code continue alors jusqu’à ce que le contrat soit rempli, vérifié par un autre modèle.

## Ce qu’elle ne fait pas

Elle ne met rien en ligne, n’envoie rien, ne supprime rien sans ton accord, n’envoie aucune donnée ailleurs et n’installe aucun logiciel sans te le proposer. Elle ne remplace pas tes propres vérifications sur ce qui est irréversible.

## Installer

Le dossier `bag/` suit le format ouvert [Agent Skills](https://agentskills.io) (un dossier avec un fichier `SKILL.md`). Le champ `hooks` de son en-tête est propre à Claude Code.

**Le plus simple** : copie cette phrase dans ton agent, ouvert dans ton projet.

> Installe la skill BAG depuis https://github.com/Luclegay/skill-bag dans ce projet. Avant de l’activer, explique-moi ce qu’elle va ajouter ou modifier.

**À la main**, copie le dossier `bag/` :

- Claude Code : dans `.claude/skills/` du projet (ou `~/.claude/skills/` pour tous tes projets).
- Autres agents compatibles Agent Skills : dans le dossier de skills indiqué par leur documentation.

Ensuite, dis simplement : « Active BAG pour ce projet. » Ou tape `/bag` devant ta demande : la skill se charge seule sur la plupart des demandes, mais pas toujours sur un petit correctif.

### Plan Claude Team (ou Enterprise) : installer pour toute l’équipe

Un propriétaire (*owner*) du compte peut installer la skill une seule fois pour tous les membres, sans que chacun la copie.

1. Télécharge [bag.zip](https://github.com/Luclegay/skill-bag/releases/latest/download/bag.zip) : la skill sans les tests, avec `SKILL.md` à la racine du zip.
2. Dans Organization settings > Plugins & skills, onglet « Policy », vérifie que « Cloud code execution and file creation » et « Skills » sont activés.
3. Clique sur « Add », puis « Upload a skill », et envoie le zip. La skill est aussitôt fournie à tous les membres, dans Customize > Skills sur claude.ai, et dans Claude Code pour ceux qui s’y connectent avec leur compte Claude.

À savoir :

- Seuls les propriétaires du compte peuvent ajouter ou retirer une skill d’organisation. Procédure officielle : [Provision and manage skills for your organization](https://support.claude.com/en/articles/13119606-managing-skills-as-an-admin).
- Le contrôle de fin de tour et `/goal` sont prévus pour Claude Code. Dans le chat sur claude.ai, seule la méthode écrite s’applique.
- Dans Claude Code, une copie personnelle `bag` (dans `~/.claude/skills/`) passe devant la version de l’équipe.
- Pour mettre à jour, envoie le nouveau zip de la dernière version.

## Enlever

Supprime le dossier `bag/`. Les fichiers qu’elle a créés dans ton projet (`AGENTS.md`, `PROGRESS.md`, `fini-quand.json`, réglages) restent : ils sont à toi, garde-les ou supprime-les.

## Contenu

```
bag/
├── SKILL.md              la méthode, chargée quand la skill s’active
├── references/
│   ├── preuves.md        des preuves par type de projet
│   ├── gout.md           prouver ce qui relève du goût (design, ton)
│   ├── barrieres.md      bac à sable, permissions, contrôles automatiques
│   ├── claude-code.md    /goal et le contrôle de fin de tour
│   └── graphe.md         découper le travail entre plusieurs tâches
├── assets/
│   ├── AGENTS.md         modèle de carte de projet
│   ├── PROGRESS.md       modèle de journal de bord
│   ├── contrat.md        modèle de contrat « fini quand… »
│   └── fini-quand.json   modèle de liste de critères à cocher
└── evals/                les tests de la skill (voir evals/README.md)
```

## Tester

La skill est livrée avec ses tests : six mises en situation (fausse preuve, demande d’accord, sources insuffisantes, test contradictoire, défauts hors demande, réponse courte) et cinq tests de déclenchement. Ils se lancent avec `claude plugin eval`, qui compare l’agent avec et sans la skill. Mode d’emploi : [bag/evals/README.md](bag/evals/README.md).

## Licence

MIT : tu peux utiliser, modifier et partager librement. Voir [LICENSE](LICENSE).
