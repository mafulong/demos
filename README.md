# Demos

Demo projects / static content served via GitHub Pages.

**Live URL**: <https://mafulong.eu.org/demos/>

## Stack

- [Hugo](https://gohugo.io/) (extended) v0.158+
- [hugo-book](https://github.com/alex-shpak/hugo-book) theme

## Build & Deploy (manual)

Pages source is configured to the `gh-pages` branch (no GitHub Actions used).
To publish updates:

```bash
# Build into ./public
hugo --minify --baseURL "/demos/"

# Push ./public to gh-pages branch (force, since gh-pages holds only build output)
cd public
git init -q
git checkout -b gh-pages
git add .
git commit -m "Publish site" -q
git push -f https://github.com/mafulong/demos.git gh-pages
cd ..
```

Or use the helper script: `./deploy.sh`

## Authoring

- Source content: `content/docs/*.md`
- Theme: `themes/hugo-book` (git submodule)
- Config: `hugo.toml`

## Pages Settings (one-time, in GitHub UI or API)

- Source: `Deploy from a branch`
- Branch: `gh-pages` / `(root)`