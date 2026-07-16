# My projects portfolio

This is a simple gallery of my projects.

> https://xp.heuzef.com

## Install Hugo-Narrow theme

```sh
git submodule add https://github.com/tom2almighty/hugo-narrow.git xp/themes/hugo-narrow
```

## Create a new project

```sh
# https://hugo-narrow-docs.vercel.app/docs/archetypes/#create-a-new-project
hugo new content projects/my-super-project.md
git add --all ; git commit -m "Create new project" ; git push
```

## Update Hugo-Narrow theme

The theme is included as a git submodule. Updating it through automation can break the site (breaking changes, untested rendering, etc.), so it's preferable to update it manually and check the result locally before publishing:

```sh
# Go into the theme folder and backup-it
cd xp/themes/
cp -vr hugo-narrow hugo-narrow.bak

# Fetch and switch to the latest version of the theme
cd hugo-narrow
git fetch origin
git checkout main
git pull origin main

# Go back to the project root, build the site locally and check that nothing is broken
cd ../../
hugo server

# If everything looks good, commit the new theme version
cd ..
git add xp/themes/hugo-narrow
git commit -m "Update Hugo-Narrow theme"
git push

# If not, revert to the backup
cd xp/themes/
rm -fr hugo-narrow
mv hugo-narrow.bak/ hugo-narrow
cd ../../
hugo server
```
