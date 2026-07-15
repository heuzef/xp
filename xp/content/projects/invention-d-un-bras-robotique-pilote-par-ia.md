---
title: 'Invention d''un bras robotique piloté par IA'
summary: "Présentation du Caligraphomate, projet dans le cadre du Hackathon HACK1ROBO 2025"
featured: true
date: '2025-11-01T00:00:00+01:00'
draft: false
slug: caligraphomate
tags: ["hackathon", "robotique", "analyse-de-donnees", "fastapi", "data-product-management", "pao", "datascience", "exploration-des-donnees", "gestion-de-projet", "methodes-agiles", "python", "opencv", "linux", "cnn", "deep-learning", "apprentissage-supervise", "management"]
cover: "images/caligraphomate.png"
link: "https://github.com/heuzef/caligraphomate"
status: "completed" # Options: completed, in_progress, planning
---
## Contexte

Le **Caligraphomate** est né dans le cadre du Hackathon [HACK1ROBO 2025](https://hack1robo.fr) (Bordeaux, France) : transformer un bras robotique **SO-ARM** en machine à écrire manuscrite, capable d'écrire et de dessiner sur une feuille A4.

Le projet s'appuie sur l'écosystème open source [LeRobot](https://github.com/huggingface/lerobot) de Hugging Face : téléopération en mode leader/follower pour la collecte de démonstrations, constitution de datasets, puis entraînement de modèles de deep learning (apprentissage supervisé par imitation) pour piloter le bras de manière autonome.

## Étymologie

> **Cali-** : du grec *kállos*, « beauté » — la qualité esthétique de la calligraphie.

> **Grapho-** : du grec *gráphein*, « écrire » ou « dessiner » — l'acte de créer du texte ou des images.

> **-Mate** : suffixe évoquant la machine, l'automate — ce qui exécute une fonction automatiquement.

## Réalisations

* **Conception d'une pince porte-stylo** adaptée au SO-ARM, éprouvée sur le terrain.
* **Développement d'une bibliothèque « StaticImageCamera » pour LeRobot**, qui convertit un fichier image en flux vidéo via une caméra simulée, afin de définir une cible à dessiner.
* **Création d'un dataset de tracés de rectangles** : [visualisation sur Hugging Face](https://lerobot-visualize-dataset.hf.space/Heuzef/rectangle_v1/episode_0).
* **Entraînement de modèles** et mise à disposition d'un script d'inférence pour les tester : [huggingface.co/Heuzef/models](https://huggingface.co/Heuzef/models).
* **Constitution d'une large collection de formes géométriques et de dessins** au format A5 sur feuilles A4, pour créer des datasets de qualité.
* **Contrôle par API web** du bras robotique via le service open source [Phosphobot](https://docs.phospho.ai/welcome).

## Ressources

* [Le dépôt GitHub du projet, avec tous les détails techniques](https://github.com/heuzef/caligraphomate)
* [Les modèles entraînés, publiés sur Hugging Face](https://huggingface.co/Heuzef/models)
