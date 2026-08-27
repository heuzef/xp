---
title: 'Développement et mise en production CI/CD d''une application RH sur Azure'
summary: "Une application conteneurisée de questionnaires techniques développée en Python, déployée sur Azure avec une consomation à la demande"
featured: false
date: '2026-08-27T00:00:00+02:00'
draft: false
slug: app-rh-ctn-azure
tags: ["python", "streamlit", "postgresql", "sqlalchemy", "docker", "azure", "ci-cd", "devops", "cloud", "rh", "ia", "securite", "conteneurisation", "docker", "finops"]
cover: "images/app-rh-ctn-azure.png"
link: "https://azure.microsoft.com"
status: "completed" # Options: completed, in_progress, planning
mermaid: true # charts
---
## Contexte

Cette application interne a été développée pour les besoins des **ressources humaines** : elle permet de faire passer des questionnaires techniques aux candidats lors des recrutements, QCM à réponse unique ou multiple et questions à réponse libre, sur plusieurs technologies et niveaux de difficulté, adapté au niveau choisi.

L'application couvre tout le cycle de vie de l'évaluation des candidats :

* **Correction des réponses libres** par un jury, manuellement ou assistée par **IA** ;
* **Envoi automatique du récapitulatif PDF** à la direction ;
* **Administration complète** : gestion de la banque de questions (ajout, édition, activation/désactivation, import/export CSV), historique filtrable de toutes les sessions, statistiques globales avec rapport PDF exportable pour la direction.

## Stack technique

| Composant | Technologie
|---|---|---|
| Application | Python (SQLAlchemy, Streamlit) / Azure DevOps |
| Base de données | PostgreSQL |
| Conteneurisation | Docker / Docker Compose |
| Registre d'images | Azure Container Registry |
| Hébergement | Azure Container Apps |
| Automatisation | Azure Logic Apps |
| Secrets | Azure Key Vault / Azure Identity |

## Application allumée à la demande

L'application ne sert que ponctuellement, lors des sessions de recrutement. Plutôt que de payer une infrastructure allumée en permanence, la mise en production repose sur un principe simple : **l'application est éteinte par défaut, se démarre à la demande et s'éteint toute seule**.

```mermaid
flowchart TB
    subgraph P1["1 - Développement CI/CD"]
        direction LR
        DEV["Développement<br>(Azure DevOps)"] --> BUILD["Build Conteneur<br>(Docker)"] --> ACR["Dépôt d'images<br>(Azure Container Registry)"]
    end
    subgraph P2["2 - Mise en service"]
        direction LR
        USER["Utilisateur"] -->|trigger| LA["Workflow<br>Azure LogicApp"] -->|démarrage| APP["Application en ligne<br>Container App"]
    end
    subgraph P3["3 - Pendant la session"]
        direction LR
        ACCES["Accès réservé<br>par filtrage IP"]
        DB[("PostgreSQL<br>Questions, résultats, ...")]
        KV["Coffre-fort Key Vault<br>Gestions des secrets"]
        LOGS["Log Analytics<br>Suivi et diagnostic"]
    end
    FIN["4 - Extinction<br>Arrêt automatique après la durée prévue"]
    ACR -.->|Dernière version| APP
    APP -.-> P3
    P3 --> FIN
```

Concrètement, un  workflow **Logic App** joue le rôle d'automate de démarrage : déclenché par une requête HTTP qui précise une durée, il vérifie la durée demandée, refuse le démarrage si une session tourne déjà, allume la Container App, renvoie immédiatement l'URL et l'heure d'expiration à l'appelant, puis éteint l'application à l'échéance.

Côté sécurité, plusieurs choix structurants :

* **Zéro secret stocké** : l'application tire son image du registre et lit ses secrets (chaîne de connexion, clé API) via des **identités managées** et des références **Key Vault**, rien ne transite par le dépôt ni par les définitions ;
* **Accès restreint** : l'ingress public est filtré par une allowlist d'adresses IP, sans VNet ni passerelle facturée en permanence ;
* **Envoi d'emails verrouillé** : le tenant désactivant SMTP AUTH, l'envoi passe par Microsoft Graph avec une *Application Access Policy* qui restreint l'identité à une seule boîte expéditrice ;
* **Observabilité** : les journaux du conteneur sont centralisés dans Log Analytics.
* **Plafonnement** : la durée de la session est plafonnée à 24 h maximum. Un service inutilisé est préférablement arrêté pour éviter l'exposition aux attaquants.

## Intégration CI/CD

Le cycle de vie applicatif est entièrement industrialisé :

* Développement et versionnement sur **Azure DevOps** ;
* **Build et publication de l'image Docker** vers le registre, taguée par le sha du commit, ce qui garantit qu'un déploiement crée bien une nouvelle révision et permet de revenir en arrière sur n'importe quelle version ;
* **Infrastructure as Code** : les définitions de la Container App (ingress, allowlist, sondes, secrets) et du Logic App sont versionnées en JSON dans le dépôt, et déployées par des scripts idempotents. Aucune modification ne se fait depuis le portail Azure : le fichier versionné fait foi, et les permissions elles-mêmes empêchent les écarts ;

## Retour d'expérience

Ce projet illustre qu'une mise en production « sur-mesure » peut être plus pertinente qu'une architecture standard : pour une application à usage ponctuel, le duo Logic App + Container Apps offre un vrai modèle **FinOps** (aucune ressource consommée en dehors des sessions), tout en gardant un niveau de sécurité d'entreprise, identités managées, coffre-fort de secrets, filtrage réseau et traçabilité complète.
