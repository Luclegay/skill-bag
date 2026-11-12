# Barrières et contrôles automatiques

À lire quand tu proposes des permissions ou un contrôle qui « écrit deux fois » une règle. Ce sont des **exemples à adapter** : les réglages évoluent vite, vérifie la documentation à jour de l’outil avant d’écrire un fichier, et montre-le toujours à l’utilisateur avant de l’enregistrer.

Principe : une consigne peut s’oublier, une permission absente ne se contourne pas. Celui qui propose une action (l’agent) n’est pas celui qui l’autorise (une règle, ou l’humain).

## Permissions

### Claude Code : `.claude/settings.json` du projet

```json
{
  "permissions": {
    "allow": [
      "Edit(./**)"
    ],
    "deny": [
      "Read(./.env)",
      "Read(./.env.*)",
      "Edit(./sources/**)",
      "Bash(rm -rf:*)"
    ],
    "ask": [
      "Bash(git push:*)",
      "Bash(curl:*)",
      "Bash(ftp:*)",
      "Bash(sftp:*)",
      "Bash(lftp:*)",
      "Bash(scp:*)",
      "Bash(rsync:*)"
    ]
  }
}
```

- `deny` : interdit. `ask` : demande l’accord à chaque fois. `allow` : autorisé sans demander (modifier les fichiers du projet, lancer les tests).
- `Edit(./sources/**)` dans `deny` met un dossier en lecture seule : adapte le chemin, ou retire la ligne si le projet n’a pas de sources à protéger.
- Garde dans `ask` toutes les commandes de mise en ligne propres au projet (FTP, déploiement, envoi). Ne mets pas `git commit` dans `ask` : un commit local se défait.
- Si tu n’as pas pu vérifier la syntaxe dans la documentation à jour, dis-le à l’utilisateur.

### Codex : `config.toml`

Le niveau de liberté se règle avec le mode d’approbation et le bac à sable, par exemple `approval_policy = "on-request"` et `sandbox_mode = "workspace-write"` (écriture limitée au dossier de travail). Vérifie les noms exacts dans la documentation de Codex.

### Cursor et autres agents

Cherche dans les réglages de l’agent les listes d’exécution automatique autorisée et interdite, et laisse les actions irréversibles en demande d’accord.

## Contrôles automatiques (« écrire deux fois »)

| Règle écrite dans AGENTS.md | Contrôle possible |
|---|---|
| Toute image a un texte alternatif, contrastes AA | audit d’accessibilité automatisé après chaque modification |
| HTML valide | validateur HTML lancé après chaque modification |
| Pas de clé d’API dans le code | script lancé avant chaque commit, qui refuse le commit s’il détecte une clé |
| Ne pas toucher au dossier X | permission `deny` sur l’écriture dans X |
| Chaque chiffre est sourcé | script qui retrouve chaque chiffre dans les sources |

### Exemple : lancer un contrôle après chaque modification (hook Claude Code)

Dans `.claude/settings.json`, un hook `PostToolUse` lance une commande après chaque écriture de fichier. Si la commande échoue avec le code de sortie 2, son message est renvoyé à l’agent, qui doit corriger.

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          { "type": "command", "command": "./outils/verifier.sh" }
        ]
      }
    ]
  }
}
```

`./outils/verifier.sh` est un script du projet qui lance les contrôles (validateur, tests…) et sort avec le code 2 en cas d’échec. Écris-le avec l’utilisateur, explique chaque ligne, et teste-le une fois en provoquant volontairement une erreur.

Précautions : un hook tourne après **chaque** modification, y compris d’un simple fichier texte. Réserve-le aux contrôles qui prennent quelques secondes. Si le projet a déjà des défauts, fais porter le contrôle sur les fichiers modifiés (ou corrige d’abord les défauts, avec accord), sinon l’agent les verra revenir à chaque fois et sera tenté de sortir de son périmètre.

### Exemple : refuser un commit qui contient une clé

`.git/hooks/pre-commit` (à rendre exécutable avec `chmod +x .git/hooks/pre-commit`) :

```sh
#!/bin/sh
# Refuse le commit si un fichier ajouté ressemble à une clé d'API
if git diff --cached -U0 | grep -E '^\+.*(sk-[A-Za-z0-9_-]{20,}|AKIA[0-9A-Z]{16}|AIza[0-9A-Za-z_-]{35})'; then
  echo "Commit refusé : une clé d'API semble présente dans les modifications."
  exit 1
fi
```

Ce filtre est simple et ne détecte pas tout ; un outil dédié (type gitleaks) fait mieux si l’utilisateur accepte de l’installer.
