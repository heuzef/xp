---
title: 'Développement d''une application RH et mise en production sur-mesure sur Azure'
summary: "Une application de questionnaires techniques en Python, déployée sur Azure avec une infrastructure allumée à la demande"
featured: true
date: '2026-08-26T00:00:00+02:00'
draft: false
slug: application-rh
tags: ["python", "streamlit", "postgresql", "sqlalchemy", "docker", "azure", "ci-cd", "devops", "cloud", "rh", "ia", "securite", "finops", "gestion-de-projet"]
cover: "images/application-rh.png"
link: "https://heuzef.com"
status: "completed" # Options: completed, in_progress, planning
mermaid: true # charts
---
## Contexte

Cette application interne a été développée pour les besoins des **ressources humaines** : elle permet de faire passer des questionnaires techniques aux candidats lors des recrutements — QCM à réponse unique ou multiple et questions à réponse libre, sur plusieurs technologies et niveaux de difficulté, avec un timer adapté au niveau choisi.

Au-delà du passage du quiz, l'application couvre tout le cycle de vie de l'évaluation :

* **Correction des réponses libres** par un jury, manuellement ou assistée par **IA** (API Claude d'Anthropic) ;
* **Envoi automatique du récapitulatif PDF** à la direction, via Microsoft Graph et une identité managée (aucun secret SMTP à stocker) ;
* **Administration complète** : gestion de la banque de questions (ajout, édition, activation/désactivation, import/export CSV), historique filtrable de toutes les sessions, statistiques globales avec rapport PDF exportable pour la direction.

## Stack technique

| Composant | Technologie |
|---|---|
| Application | Python / Streamlit |
| ORM | SQLAlchemy 2.x |
| Base de données | PostgreSQL 17 (Azure Flexible Server) |
| Correction IA | Claude (API Anthropic) |
| Export PDF | fpdf2 |
| Conteneurisation | Docker / Docker Compose |
| Registre d'images | Azure Container Registry |
| Hébergement | Azure Container Apps |
| Automatisation | Azure Logic Apps |

## Une mise en production sur-mesure : l'application allumée à la demande

L'application ne sert que ponctuellement, lors des sessions de recrutement. Plutôt que de payer une infrastructure allumée en permanence, la mise en production repose sur un principe simple : **l'application est éteinte par défaut, se démarre à la demande et s'éteint toute seule**.

```mermaid
flowchart TB
    subgraph P1["1 — Préparer la version"]
        direction LR
        DEV["Développement<br>Azure DevOps"] --> BUILD["Mise en boîte<br>conteneur Docker"] --> ACR["Dépôt d'images<br>Azure Container Registry"]
    end
    subgraph P2["2 — Démarrer à la demande"]
        direction LR
        USER["Utilisateur"] -->|demande| LA["Automate de démarrage<br>Logic App"] -->|démarre| APP["Application en ligne<br>Container App"]
    end
    subgraph P3["3 — Pendant la session"]
        direction LR
        ACCES["Accès réservé<br>filtrage par IP"]
        DB[("PostgreSQL<br>questions et résultats")]
        KV["Coffre-fort Key Vault<br>mots de passe et clés"]
        LOGS["Log Analytics<br>suivi et diagnostic"]
    end
    FIN["4 — Extinction automatique après la durée prévue<br>aucune ressource consommée jusqu'à la prochaine demande"]
    ACR -.->|dernière version| APP
    APP -.-> P3
    P3 --> FIN
```

Concrètement, un **Logic App** joue le rôle d'automate de démarrage : déclenché par une simple requête HTTP, il vérifie la durée demandée (plafonnée à 24 h), refuse le démarrage si une session tourne déjà, allume la Container App, renvoie immédiatement l'URL et l'heure d'expiration à l'appelant, puis éteint l'application à l'échéance (6 h par défaut). Son identité ne porte que les droits de démarrage et d'arrêt : il ne peut pas modifier la définition de l'application.

Côté sécurité, plusieurs choix structurants :

* **Zéro secret stocké** : l'application tire son image du registre et lit ses secrets (chaîne de connexion, clé API) via des **identités managées** et des références **Key Vault** — rien ne transite par le dépôt ni par les définitions ;
* **Accès restreint** : l'ingress public est filtré par une allowlist d'adresses IP, sans VNet ni passerelle facturée en permanence ;
* **Envoi d'emails verrouillé** : le tenant désactivant SMTP AUTH, l'envoi passe par Microsoft Graph avec une *Application Access Policy* qui restreint l'identité à une seule boîte expéditrice ;
* **Observabilité** : les journaux du conteneur sont centralisés dans Log Analytics.

## Intégration CI/CD

Le cycle de vie applicatif est entièrement industrialisé :

* Développement et versionnement sur **Azure DevOps** ;
* **Build et publication de l'image Docker** vers le registre, taguée par le sha du commit — ce qui garantit qu'un déploiement crée bien une nouvelle révision et permet de revenir en arrière sur n'importe quelle version ;
* **Infrastructure as Code** : les définitions de la Container App (ingress, allowlist, sondes, secrets) et du Logic App sont versionnées en JSON dans le dépôt, et déployées par des scripts idempotents. Aucune modification ne se fait depuis le portail Azure : le fichier versionné fait foi, et les permissions elles-mêmes empêchent les écarts ;
* **Tests automatisés** avec pytest sur les fonctions pures et les requêtes critiques (notamment le périmètre des cascades de suppression).

## Retour d'expérience

Ce projet illustre qu'une mise en production « sur-mesure » peut être plus pertinente qu'une architecture standard : pour une application à usage ponctuel, le duo Logic App + Container Apps offre un vrai modèle **FinOps** (aucune ressource consommée en dehors des sessions), tout en gardant un niveau de sécurité d'entreprise — identités managées, coffre-fort de secrets, filtrage réseau et traçabilité complète.
