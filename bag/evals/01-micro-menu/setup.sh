#!/bin/sh
cat > index.html <<'H'
<!doctype html>
<html lang="fr"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Atelier Prospective</title>
<style>
.menu{display:none}
.menu.ouvert{display:block}
@media (min-width:40rem){.burger{display:none}.menu{display:flex;gap:1rem}}
</style></head>
<body>
<header><button class="burger" aria-label="Menu">☰</button>
<nav><ul class="menu"><li><a href="#a">Accueil</a></li><li><a href="#b">Ateliers</a></li><li><a href="#c">Contact</a></li></ul></nav></header>
<main><h1>Atelier Prospective</h1><p>Bienvenue.</p></main>
<script>
const bouton = document.querySelector('.burger');
const menu = document.querySelector('.menus');
bouton.addEventListener('click', () => menu.classList.toggle('ouvert'));
</script>
</body></html>
H
