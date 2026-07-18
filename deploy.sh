#!/usr/bin/env bash
# Build Hugo site and push to gh-pages branch.
set -euo pipefail

cd "$(dirname "$0")"

echo "▶ Building site..."
rm -rf public
hugo --minify --baseURL "/demos/" --buildFuture

echo "▶ Pushing public/ to gh-pages..."
pushd public > /dev/null
git init -q
git checkout -B gh-pages
git add .
git commit -m "Publish site $(date -u +%Y-%m-%dT%H:%M:%SZ)" -q
git push -f https://github.com/mafulong/demos.git gh-pages
popd > /dev/null

echo "✓ Done — site will be live at https://mafulong.eu.org/demos/ once Pages rebuilds (≤1 min)"