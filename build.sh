#!/bin/sh
# Build a standalone, hostable document from the artifact-shaped source.
#
# index.html is authored for the Artifact publisher, which wraps it in a
# doctype + <head> (charset, viewport) at publish time. A plain static host
# such as GitHub Pages does no such thing, and without the viewport meta
# mobile browsers assume a ~980px layout viewport -- so the phone media
# queries never match and handsets get the shrunken desktop layout.
#
# No <head>/<body> tags are emitted: they are optional in HTML5, and the
# parser puts <title>/<link>/<style> in the head and the first flow content
# in the body on its own. That matches how the source is already written,
# and avoids stranding <title> inside <body> where it would be ignored.
set -e
cd "$(dirname "$0")"

src="index.html"
out="docs/index.html"
mkdir -p docs

{
  printf '%s\n' '<!doctype html>'
  printf '%s\n' '<html lang="en">'
  printf '%s\n' '<meta charset="utf-8">'
  printf '%s\n' '<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">'
  printf '%s\n' '<meta name="color-scheme" content="dark">'
  printf '%s\n' '<meta name="description" content="A grid deduction game: triangulate a hidden transmitter from noisy signal readings before your probes run out.">'
  printf '%s\n' '<link rel="icon" href="data:image/svg+xml,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 100 100%22><text y=%22.9em%22 font-size=%2290%22>&#128225;</text></svg>">'
  cat "$src"
  printf '%s\n' '</html>'
} > "$out"

echo "built $out ($(wc -c < "$out") bytes)"
