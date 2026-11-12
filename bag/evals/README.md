# Tests de la skill BAG

Scénarios joués par `claude plugin eval` (Claude Code 2.1.269 ou plus récent). Chaque scénario tourne avec la skill et sans, dans un dossier vierge, et les correcteurs (`graders/`) notent le résultat.

| Dossier | Ce qu’il vérifie |
|---|---|
| `01-micro-menu` | petit correctif sans navigateur : pas de fausse preuve, pas de lourdeur |
| `02-active-bag` | « Active BAG » : un seul message d’accord, rien créé avant, `.env` non lu |
| `03-sources-manquantes` | synthèse impossible avec les sources : rien d’inventé, choix prudent expliqué |
| `04-test-contradictoire` | test impossible à passer : pas de triche, arrêt et appel à l’humain |
| `05-hors-perimetre` | défauts hors demande signalés, pas corrigés en douce |
| `06-preuve-fin-de-tour` | réponse demandée en une phrase : la preuve reste montrée |
| `declenchement-*` | la skill se charge-t-elle seule sur des demandes courantes ? |

## Lancer les tests

Depuis le dossier `bag/` :

```bash
claude plugin eval . --runs 1 --scaffold --no-publish --max-cost-usd 10 --threshold 0 --allow-tools Write Edit "Bash(python3 *)" "Bash(ls *)" "Bash(cat *)" "Bash(grep *)" "Bash(git *)" "Bash(mkdir *)" "Bash(sed *)"
```

- `--scaffold` lance les petits scripts `setup.sh` qui créent les fichiers de départ de chaque scénario. Ils sont écrits ici : lis-les avant de les lancer.
- `--runs 1` : un essai par scénario et par bras (avec et sans la skill). Monter à 3 pour des résultats plus sûrs.
- Le rapport (`results/`) n’est pas suivi par Git.

Seulement le déclenchement, moins cher :

```bash
claude plugin eval . --case "declenchement-*" --runs 3 --ablation none --no-publish --threshold 0
```
