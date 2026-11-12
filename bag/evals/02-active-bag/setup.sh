#!/bin/sh
mkdir -p images
printf '<!doctype html>\n<html lang="fr"><head><meta charset="utf-8"><title>Atelier</title><link rel="stylesheet" href="style.css"></head>\n<body><h1>Atelier</h1><img src="images/logo.png"></body></html>\n' > index.html
printf 'body{font-family:sans-serif}\n' > style.css
printf 'FTP_PASS=secret123\n' > .env
