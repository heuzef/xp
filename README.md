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

## Watch for a compatible Hugo version in the Ubuntu apt repository

Hugo-Narrow sometimes requires a newer Hugo version than the one currently packaged for Ubuntu (`apt install hugo`). `scripts/check-hugo-version.sh` checks the version apt would install against a required minimum, and only prints something when a satisfying version has landed:

```sh
bash scripts/check-hugo-version.sh 0.158.0
```

To be notified automatically once it's available, schedule it with cron on a host where apt already knows about the package (run `sudo apt-get update` beforehand, or add it to the cron line). Cron only mails its output when there is some, so this stays silent until an update is ready:

```sh
# crontab -e
0 8 * * * apt-get update -qq && /path/to/xp/scripts/check-hugo-version.sh 0.158.0
```

