---
title: 'Optimisation des vérifications des sauvegardes'
summary: "Projet de fin d'études GMSI (CESI) : analyse fonctionnelle et recherche de solution pour automatiser la vérification humaine des sauvegardes"
featured: false
date: '2015-06-01T00:00:00+02:00'
draft: false
slug: optimisation-des-verifications-des-sauvegardes
tags: ["pfe", "cesi", "sauvegarde", "backuppc", "perl", "open-source", "analyse-fonctionnelle", "cahier-des-charges", "glpi", "zabbix", "gestion-de-projet"]
cover: "images/pfe-verification-sauvegardes.png"
link: "/files/HEUZEFlorentPFEgmsi36.pdf"
status: "completed" # Options: completed, in_progress, planning
---
## Contexte

Ce projet de fin d'études a été réalisé en 2015 dans le cadre de la formation en alternance **GMSI** (Gestionnaire en Maintenance et Support Informatique) au CESI de Blanquefort, au sein de l'entreprise Firewall-Services, ESN spécialisée dans les solutions basées sur les logiciels libres.

Depuis 2001, Firewall-Services garantit à ses clients l'intégrité de leurs sauvegardes grâce à une vérification humaine mensuelle réalisée sur l'outil libre **BackupPC**. Cette tâche, en charge de mon poste de technicien de maintenance, représentait déjà 225 machines à vérifier chez 13 clients, soit près de 200 heures par an.

## Problématique

Ces vérifications manuelles, répétitives et fastidieuses, favorisaient la perte de concentration et de motivation, augmentant le risque d'erreur humaine sur des données sensibles. L'objectif du projet était donc de trouver une solution pour **réduire le temps consacré à ces vérifications**, tout en améliorant leur qualité et le confort de travail des techniciens.

## Démarche

Le projet a suivi une méthodologie d'analyse fonctionnelle complète :

* **Analyse du besoin** et calcul du budget/retour sur investissement (10 000 € HT/an de coût humain estimé).
* **Cahier des charges fonctionnel** définissant 4 fonctions principales (garantir l'intégrité des sauvegardes, informer les clients, contrôler le stockage, tracer les points de contrôle sur GLPI) et 6 contraintes (compatibilité BackupPC, matériel, éthique du logiciel libre,...).
* **Recherche de solutions** et comparatif de 4 pistes.
* **Validation** par un profil fonctionnel chiffrant la réponse de chaque solution au cahier des charges.

## Solution retenue

L'analyse a désigné le développement d'une **extension BackupPC en Perl**, avec un taux de réponse au besoin de 98 %. Cette solution s'intègre directement à l'outil existant, exploite ses librairies (API), ne nécessite pas de nouvel outil pour les techniciens, et reste diffusée sous licence libre GPL en lien avec la communauté BackupPC déjà sollicitée en amont du projet.

## Ressources

* [Télécharger le dossier complet du PFE (PDF)](/files/HEUZEFlorentPFEgmsi36.pdf)
* [La Pull Request sur GitHub](https://github.com/backuppc/backuppc/pull/419)
