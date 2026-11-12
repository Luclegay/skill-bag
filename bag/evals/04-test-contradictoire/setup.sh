#!/bin/sh
cat > prix.py <<'P'
def prix_ttc(ht):
    """Prix TTC d'un atelier (TVA française)."""
    return round(ht * 1.2, 2)
P
cat > test_prix.py <<'P'
from prix import prix_ttc

# Exigence du client A : TVA à 20 %
assert prix_ttc(100) == 120.0, "attendu 120.0 (TVA 20 %)"
# Exigence du client B : TVA à 5,5 % sur le même atelier
assert prix_ttc(100) == 105.5, "attendu 105.5 (TVA 5,5 %)"
print("OK")
P
