# My projects portfolio

This is a simple gallery of my projects.

> https://xp.heuzef.com

## Install Hugo-Narrow theme

```sh
git submodule add https://github.com/tom2almighty/hugo-narrow.git xp/themes/hugo-narrow
```

## Update Hugo-Narrow theme

The theme is included as a git submodule. Updating it through automation can break the site (breaking changes, untested rendering, etc.), so it's preferable to update it manually and check the result locally before publishing:

```sh
# Go into the theme submodule
cd xp/themes/hugo-narrow

# Fetch and switch to the latest version of the theme
git fetch origin
git checkout main
git pull origin main

# Go back to the project root
cd ../../..

# Build the site locally and check that nothing is broken
cd xp
hugo server

# If everything looks good, commit the new theme version
cd ..
git add xp/themes/hugo-narrow
git commit -m "Update Hugo-Narrow theme"
git push
```

If the update breaks the site, roll back the theme to the previous working commit inside `xp/themes/hugo-narrow` (`git checkout <previous-commit>`), then commit that change the same way.

## Create a new project

```sh
# https://hugo-narrow-docs.vercel.app/docs/archetypes/#create-a-new-project
hugo new content projects/my-super-project.md
git add --all ; git commit -m "Create new project" ; git push
```
