---
title: 'Migration d''une plateforme décisionnelle vers SAP BusinessObjects 2025'
summary: "Installation, dimensionnement, sécurisation et personnalisation d'une nouvelle plateforme SAP BusinessObjects BI 2025, réalisées en mission de conseil pour remplacer une plateforme 4.3 en production."
featured: false
date: '2026-10-02T00:00:00+02:00'
draft: false
slug: migration-sap-bo-2025
tags: ["sap-businessobjects", "business-intelligence", "migration", "architecture", "securite", "database", "integration-de-donnees", "ldap", "windows-server", "tomcat"]
cover: "images/migration-sap-bo-2025.svg"
link: ""
status: "completed" # Options: completed, in_progress, planning
---

## Contexte

Un établissement d'enseignement supérieur a confié à la société de conseil en data pour laquelle j'interviens la migration de son infrastructure décisionnelle : il s'agissait de basculer de **SAP BusinessObjects 4.3** vers **SAP BusinessObjects BI 2025**. La plateforme alimente des rapports Web Intelligence à partir de nombreuses bases de données externes et sert un large public d'utilisateurs authentifiés via l'annuaire de l'établissement.

La mission couvrait l'installation d'une nouvelle plateforme, son paramétrage, l'optimisation de l'outil mis en production avec l'appui de l'éditeur, puis la migration des contenus depuis l'ancien serveur. Le livrable principal est une procédure d'installation et d'exploitation détaillée, pensée pour être rejouée par les équipes internes.

## Ma mission

* Installer et configurer la plateforme SAP BusinessObjects BI 2025 sur une machine virtuelle Windows dédiée.
* Dimensionner les services serveurs, en lien avec l'éditeur.
* Migrer les connexions aux sources de données et les contenus (droits, utilisateurs, univers, documents, planifications).
* Renforcer la sécurité de la plateforme et intégrer l'authentification à l'annuaire.
* Personnaliser les pages de connexion et le thème graphique aux couleurs de l'établissement.
* Rédiger la documentation d'installation, d'exploitation et de retour arrière.

## Stack technique

* **SAP BusinessObjects BI Platform 2025** (Patch 12) : CMC, BI launch pad (Fiori), Web Intelligence, OpenDocument, gestion des promotions
* **Windows Server** sur machine virtuelle, avec Apache **Tomcat** intégré et base **SQL Anywhere** pour le référentiel et l'audit
* Pilotes **ODBC** : MySQL, MariaDB, PostgreSQL, MongoDB, Microsoft SQL Server, ainsi qu'un client **Oracle 19c**
* **LDAPS** pour l'authentification, certificats importés dans le magasin de confiance de la JVM SAP avec `keytool`
* **PowerShell**, 7-Zip et Theme Designer pour l'outillage et la personnalisation

## Démarche

### Installation

J'ai retenu une installation **personnalisée** : packs de langue limités au français et à l'anglais, ajout des modèles Web Intelligence RESTful, retrait des composants inutilisés (Crystal Reports, BW Publisher) et ports dédiés pour les agents de la plateforme. Les intégrations de diagnostic de l'éditeur n'ont pas été activées. L'installation elle-même dure environ une heure, suivie d'un redémarrage.

### Préparation du serveur

* Désactivation des mises à jour Windows automatiques pour garantir la **stabilité du service**.
* Installation des pilotes ODBC puis migration des sources de données par **export/import de la clé de registre ODBC**, en ne conservant que les connexions aux bases externes et en écartant celles propres à la plateforme (audit, CMS).

### Dimensionnement

L'assistant de configuration a permis de répartir les services sur plusieurs serveurs de traitement adaptatif (profil **XL**, 11 serveurs, 40 à 60 Go de RAM). Le **dimensionnement avancé**, validé avec l'éditeur sur un serveur de 64 Go, a consisté à ajuster la mémoire Java de chaque service : 2 Go pour la connectivité, le cœur et la gestion des promotions, 4 Go pour la visualisation, 8 Go pour le pont Web Intelligence, et la création d'un serveur dédié au service de jetons de sécurité. J'ai aussi désactivé la surveillance Web Intelligence sur les services concernés et relevé les limites du moteur Web Intelligence (listes de valeurs, tris personnalisés).

Les réglages applicatifs ont complété ce travail : répertoire temporaire dédié aux archives de promotion, destinations e-mail et système de fichiers pour les planifications, indexation de la recherche, purge automatique de la corbeille à 5 jours et rétention des événements d'audit à 180 jours.

### Sécurisation

* Blocage des envois vers les stockages cloud grand public et désactivation du **SQL à la carte**.
* Sécurité de niveau supérieur sur les univers et les connexions.
* Restriction des sources de données proposées au groupe des créateurs de rapports (7 types de sources désactivés).
* Connexion **LDAPS** à l'annuaire, avec import de l'autorité de certification racine et intermédiaire dans le magasin de certificats de la JVM.

### Migration des contenus

La gestion des promotions ne se prête pas à une procédure figée. J'ai donc défini des **bonnes pratiques** (une promotion par type d'objet, nomenclature numérotée, inclusion des paramètres de sécurité, aucun objet déjà présent en destination) et un **ordre strict** en dix étapes : niveaux d'accès, groupes et utilisateurs (hors comptes d'administration), profils, connexions, univers, dossiers, favoris, boîtes de réception, projets, puis planifications. Le contrôle final se fait par comparaison du delta entre l'ancien et le nouveau serveur.

### Personnalisation

Les pages de connexion du BI launch pad, d'OpenDocument et de la CMC proposent désormais **LDAP par défaut** et masquent le champ système. Le thème de l'établissement (logo et couleurs) est appliqué au BI launch pad et à OpenDocument par la méthode éditeur. Chaque opération est précédée d'une **sauvegarde** et accompagnée d'une procédure de contrôle et de retour arrière.

## Retour d'expérience

* La version 2025 change plusieurs habitudes : plus de dépendance à une installation Java séparée, disparition du conteneur d'applications web, et le fichier de surcharge du BI launch pad est désormais `FioriBI.properties`.
* L'interface de la CMC doit être basculée en anglais pour contourner des bugs d'affichage (boutons inactifs).
* Les surcharges de configuration doivent toujours être créées d'abord dans le dossier source conservé par les patchs et les redéploiements, la copie servie par Tomcat n'étant qu'une prise en compte immédiate.
* La propriété d'activation du thème n'est pas documentée pour OpenDocument : je l'ai vérifiée directement dans le code de l'archive applicative avant de m'appuyer dessus.
* Un patch SAP écrase les archives contenant le thème. La procédure prévoit donc de réappliquer la personnalisation après chaque mise à jour.
* Le redémarrage de Tomcat après purge de son cache prend environ une heure, ce qu'il faut anticiper dans les fenêtres d'intervention.

## Ressources

* [Documentation SAP sur l'import de certificats dans la plateforme BI](https://help.sap.com/docs/SUPPORT_CONTENT/bobjip/3519323954.html)
