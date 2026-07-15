---
title: 'Invention d''un bras robotique piloté par IA'
summary: "Présentation du Caligraphomate, projet dans le cadre du Hackathon HACK1ROBO 2025"
featured: false
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

## Réalisations

* **Conception d'une pince porte-stylo** adaptée au SO-ARM, éprouvée sur le terrain.
* **Développement d'une bibliothèque « StaticImageCamera » pour LeRobot**, qui convertit un fichier image en flux vidéo via une caméra simulée, afin de définir une cible à dessiner.
* **Création d'un dataset de tracés de rectangles** : [visualisation sur Hugging Face](https://lerobot-visualize-dataset.hf.space/Heuzef/rectangle_v1/episode_0).
* **Entraînement de modèles** et mise à disposition d'un script d'inférence pour les tester : [huggingface.co/Heuzef/models](https://huggingface.co/Heuzef/models).
* **Constitution d'une large collection de formes géométriques et de dessins** au format A5 sur feuilles A4, pour créer des datasets de qualité.
* **Contrôle par API web** du bras robotique via le service open source [Phosphobot](https://phospho.ai).

## Retour d'expérience

Voici mon retour d'expérience du Hackathon Hack1Robo 2025 :

* 💎 Une richesse d'expérience rare
* 🦾 Un objectif très ambitieux, offrant un défi passionnant
* 🤣 Une ambiance incroyable
* ⚡ Une équipe survoltée

Je tiens à remercier tout ceux qui m'ont accompagnés dans cette folle aventure :

* David Libert, pour sa détermination et sa fidélité à toute épreuve, ayant piloté le projet avec moi du début à la fin depuis l'autre bout du pays.
* Pauline Dupin, pour son courage, sa persévérance et sa résilience à toute épreuve qui ont permis de débloquer le projet à de (trop) nombreuses reprises.
* Charles Pellegrini, qui fut un atout majeur sur la partie réseau et programmation, tout en étant force de proposition tout au long de l'évolution du projet.
* Cyril Guerin, qui nous a offert les fondations et les piliers de notre projet, en contribuant de façon significative à un projet open-source d'envergure !
* Esteban Cosserat, qui nous à apporté un regard externe, avec son expertise en robotique. Son autonomie et sa polyvalence a fait de lui un moteur pour soutenir l’ensemble de l'équipe.
* Méo Desbois-Renaudin, qui s'attribue tout le mérite de l'entraînement du modèle d'IA grâce à une nuit blanche, mais il fût également le gardien infaillible de la bonne humeur de notre équipe. 

C'était tout simplement un régal de travailler avec vous tous ❤️‍🔥

Remerciement supplémentaire, je n'oublie pas :
* Audrey ARIBAUD, qui nous à lâchée avant le Hackthon, car elle attend un heureux événement 🤰 Bonheur infini pour toi dans les années à venir !
* Olivier MARTY, pour son implication et ses précieux conseils.
* Yannis Bendi-Ouis d'avoir répondu à tous mes caprices pour le projet ! Merci mec ce n'était pas simple pour toi 🙏 
* Et bien sûr, merci aussi à toute l'équipe de Hack1Robo !

## Ressources

* [Le dépôt GitHub du projet, avec tous les détails techniques](https://github.com/heuzef/caligraphomate)
