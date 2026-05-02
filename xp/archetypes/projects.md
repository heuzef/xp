---
title: '{{ replace .File.ContentBaseName "-" " " | title }}'
description: "Project description"
summary: "Project summary"
featured: false
date: '{{ .Date }}'
draft: false
slug: '{{ replace .File.ContentBaseName "-" " " | title }}'
tags: ["tags 1", "tags 2"]
cover: ""
link: "https://heuzef.com"
status: "in_progress" # Options: completed, in_progress, planning
mermaid: true # charts
---
