# Barrières et contrôles automatiques

À lire quand tu proposes des permissions ou un contrôle qui « écrit deux fois » une règle. Ce sont des **exemples à adapter** : les réglages évoluent vite, vérifie la documentation à jour de l’outil avant d’écrire un fichier, et montre-le toujours à l’utilisateur avant de l’enregistrer.

Principe : une consigne peut s’oublier, une permission absente ne se contourne pas. Celui qui propose une action (l’agent) n’est pas celui qui l’autorise (une règle, ou l’humain).

## Claude Code

### 1. Le bac à sable : la vraie porte fermée à clé

Le bac à sable natif enferme les commandes du terminal : écriture limitée au dossier du projet (et au dossier temporaire), réseau coupé sauf les domaines autorisés. C’est plus sûr qu’une liste de commandes interdites, qui se contourne sans le vouloir. L’utilisateur peut l’activer avec la commande `/sandbox`, ou dans `.claude/settings.json` :

```json
{
  "sandbox": {
    "enabled": true,
    "allowUnsandboxedCommands": false,
    "filesystem": {
      "denyRead": ["./.env", "~/.ssh"]
    },
    "network": {
      "allowedDomains": ["validator.w3.org"]
    }
  }
}
```

- Le bac à sable ne couvre que les commandes du terminal. Les outils de lecture et d’écriture de fichiers, et la recherche web, restent réglés par les permissions ci-dessous : il faut les deux.
- Les domaines autorisés commencent vides : ajoute ceux dont le projet a besoin (un validateur en ligne, une documentation).
- Sur macOS, il marche sans installation. Sur Linux, il faut deux petits outils : `/sandbox` dit lesquels manquent.

### 2. Les permissions : `.claude/settings.json` du projet

```json
{
  "permissions": {
    "allow": [
      "Edit(./**)"
    ],
    "deny": [
      "Read(./.env)",
      "Read(./.env.*)",
      "Edit(./sources/**)"
    ],
    "ask": [
      "Bash(git push *)",
      "Bash(curl *)",
      "Bash(ftp *)",
      "Bash(sftp *)",
      "Bash(lftp *)",
      "Bash(scp *)",
      "Bash(rsync *)",
      "Bash(rm *)"
    ]
  }
}
```

- `deny` : interdit. `ask` : demande l’accord à chaque fois. `allow` : autorisé sans demander.
- `Edit(./sources/**)` dans `deny` met un dossier en lecture seule : adapte le chemin, ou retire la ligne.
- `Read(./.env)` bloque l’outil de lecture et les commandes simples (`cat`, `head`, `sed`…), mais pas un script qui ouvrirait le fichier. Seul le bac à sable (`denyRead`) le ferme vraiment.
- **Une règle sur une commande se contourne** : interdire `rm -rf` laisse passer `rm -fr` ou `find … -delete`. Mets plutôt `rm` en demande d’accord, et compte sur le bac à sable et Git pour le reste.
- Garde dans `ask` toutes les commandes de mise en ligne propres au projet. Ne mets pas `git commit` dans `ask` : un commit local se défait.
- Si la mise en ligne passe par un logiciel à interface (FileZilla, Cyberduck), l’agent ne peut pas la lancer : dis-le, c’est déjà une barrière.

### 3. Lancer un contrôle après chaque modification (hook)

Dans `.claude/settings.json`, un hook `PostToolUse` lance une commande après chaque écriture de fichier. Si la commande sort avec le code 2, son message est renvoyé à l’agent, qui doit corriger.

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          { "type": "command", "command": "\"$CLAUDE_PROJECT_DIR\"/outils/verifier.sh", "timeout": 30 }
        ]
      }
    ]
  }
}
```

`$CLAUDE_PROJECT_DIR` est le dossier du projet : le hook marche même si l’agent a changé de dossier entre-temps.

Le hook reçoit sur son entrée la description de l’action, dont le chemin du fichier modifié. `outils/verifier.sh` peut ainsi ne contrôler que ce fichier :

```sh
#!/bin/sh
# Contrôle le fichier que l'agent vient de modifier (méthode BAG).
# Sort avec le code 2 si le contrôle échoue : le message est renvoyé à l'agent.
fichier=$(python3 -c 'import json,sys; print(json.load(sys.stdin).get("tool_input",{}).get("file_path",""))')
case "$fichier" in
  *.html) ;;          # on ne contrôle que les pages HTML
  *) exit 0 ;;        # les autres fichiers passent sans contrôle
esac
if ! python3 "$CLAUDE_PROJECT_DIR"/outils/controle_html.py "$fichier" >&2; then
  echo "Corrige les erreurs ci-dessus dans $fichier avant de continuer." >&2
  exit 2
fi
```

Écris le script avec l’utilisateur, explique chaque ligne, rends-le exécutable (`chmod +x outils/verifier.sh`), et teste-le une fois en provoquant volontairement une erreur. Le message d’échec doit dire **quoi corriger**, pas seulement « erreur ».

Précautions : réserve le hook aux contrôles de quelques secondes. Si le projet a déjà des défauts, ne contrôle que le fichier modifié (comme ci-dessus), ou corrige d’abord les défauts avec accord, sinon l’agent les verra revenir à chaque fois et sera tenté de sortir de son périmètre.

## Codex : `config.toml`

Le niveau de liberté se règle avec le mode d’approbation et le bac à sable, par exemple `approval_policy = "on-request"` et `sandbox_mode = "workspace-write"` (écriture limitée au dossier de travail). Vérifie les noms exacts dans la documentation de Codex.

## Cursor et autres agents

Cherche dans les réglages de l’agent les listes d’exécution automatique autorisée et interdite, et laisse les actions irréversibles en demande d’accord.

## Contrôles automatiques (« écrire deux fois »)

| Règle écrite dans AGENTS.md | Contrôle possible |
|---|---|
| Toute image a un texte alternatif, contrastes AA | audit d’accessibilité automatisé après chaque modification |
| HTML valide | validateur HTML lancé après chaque modification |
| Pas de clé d’API dans le code | script lancé avant chaque commit, qui refuse le commit s’il détecte une clé |
| Ne pas toucher au dossier X | permission `deny` sur l’écriture dans X |
| Chaque chiffre est sourcé | script qui retrouve chaque chiffre dans les sources |
| Les critères « fini quand » ne changent pas sans accord | `fini-quand.json` suivi par Git : un changement de critère apparaît dans le commit |

### Refuser un commit qui contient une clé

`.git/hooks/pre-commit` (à rendre exécutable avec `chmod +x .git/hooks/pre-commit`) :

```sh
#!/bin/sh
# Refuse le commit si un fichier ajouté ressemble à une clé d'API
if git diff --cached -U0 | grep -E '^\+.*(sk-[A-Za-z0-9_-]{20,}|AKIA[0-9A-Z]{16}|AIza[0-9A-Za-z_-]{35})'; then
  echo "Commit refusé : une clé d'API semble présente. Retire-la et range-la dans .env." >&2
  exit 1
fi
```

Ce filtre est simple et ne détecte pas tout ; un outil dédié (type gitleaks) fait mieux si l’utilisateur accepte de l’installer.
