#!/usr/bin/env bash
#
# Bump the config version, move CHANGELOG [Unreleased] entries into a dated
# release section and create an annotated git tag.
#
# Usage:
#   scripts/bump.sh [patch|minor|major]
#
# After bumping, push with:  git push && git push --tags
#
set -euo pipefail

cd "$(dirname "$0")/.."

VERSION_FILE="lua/config/version.lua"
CHANGELOG_FILE="CHANGELOG.md"
TYPE="${1:-patch}"

case "$TYPE" in
	patch | minor | major) ;;
	*)
		echo "usage: $0 [patch|minor|major]" >&2
		exit 1
		;;
esac

CURRENT="$(sed -n 's/^return "\(.*\)"$/\1/p' "$VERSION_FILE")"
if [[ -z "$CURRENT" ]]; then
	echo "error: cannot read current version from $VERSION_FILE" >&2
	exit 1
fi

IFS='.' read -r MAJOR MINOR PATCH <<< "$CURRENT"

case "$TYPE" in
	patch) PATCH=$((PATCH + 1)) ;;
	minor) MINOR=$((MINOR + 1)) && PATCH=0 ;;
	major) MAJOR=$((MAJOR + 1)) && MINOR=0 && PATCH=0 ;;
esac

NEXT="$MAJOR.$MINOR.$PATCH"

if git rev-parse --verify "refs/tags/v$NEXT" >/dev/null 2>&1; then
	echo "error: tag v$NEXT already exists" >&2
	exit 1
fi

if ! grep -q '^## \[Unreleased\]' "$CHANGELOG_FILE"; then
	echo "error: $CHANGELOG_FILE is missing a [Unreleased] section" >&2
	exit 1
fi

TMP="$(mktemp)"

# Rename [Unreleased] -> [vX.Y.Z] - date
sed "s/^## \[Unreleased\]$/## [$NEXT] - $(date +%F)/" "$CHANGELOG_FILE" > "$TMP"
mv "$TMP" "$CHANGELOG_FILE"

# Re-add an empty [Unreleased] section before the first version heading
awk 'BEGIN { inserted = 0 } { if (!inserted && /^## \[/) { print "## [Unreleased]"; print ""; inserted = 1 } print }' "$CHANGELOG_FILE" > "$TMP"
mv "$TMP" "$CHANGELOG_FILE"

printf 'return "%s"\n' "$NEXT" > "$VERSION_FILE"

git add "$VERSION_FILE" "$CHANGELOG_FILE"
git commit -m "chore: release v$NEXT"
git tag -a "v$NEXT" -m "v$NEXT"

echo "Released v$NEXT (was v$CURRENT)"
echo "Push with: git push && git push --tags"
