#!/bin/bash
set -e

if [ -z "$GITHUB_TOKEN" ] || [ -z "$GITHUB_USER" ]; then
  echo "Set GITHUB_TOKEN and GITHUB_USER first."
  exit 1
fi

BASE_DIR="$HOME/ddto-repos"
mkdir -p "$BASE_DIR"

PAGE=1

while true; do
  echo "Fetching repos page $PAGE..."
  RESP=$(curl -s -H "Authorization: token $GITHUB_TOKEN" \
    "https://api.github.com/users/$GITHUB_USER/repos?per_page=100&page=$PAGE")

  COUNT=$(echo "$RESP" | grep -c '"clone_url"')
  [ "$COUNT" -eq 0 ] && break

  echo "$RESP" | grep '"clone_url"' | cut -d '"' -f 4 | while read -r REPO; do
    echo "=================================================="
    echo "Processing repo: $REPO"
    echo "=================================================="

    cd "$BASE_DIR"
    NAME=$(basename "$REPO" .git)

    if [ -d "$NAME" ]; then
      cd "$NAME"
      git pull origin main || true
    else
      git clone "$REPO"
      cd "$NAME"
    fi

    if [ -f "../ddto-seven-stars/ddto_stars.sh" ]; then
      cp ../ddto-seven-stars/ddto_stars.sh .
    fi

    chmod +x ./ddto_stars.sh
    ./ddto_stars.sh || echo "⚠️ D.D.T.O. failed for $NAME, check logs."
  done

  PAGE=$((PAGE+1))
done
