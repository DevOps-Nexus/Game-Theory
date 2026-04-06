#!/bin/bash
set -e

CMD="$1"
shift || true

case "$CMD" in
  repo)
    # Run Seven Stars on current repo
    ./ddto_stars.sh "$@"
    ;;
  all)
    # Auto-discover and run on all repos
    ./ddto_multi_auto.sh "$@"
    ;;
  dashboard)
    cp templates/ddto_dashboard.html ./ddto_dashboard.html
    echo "Dashboard copied to ./ddto_dashboard.html"
    ;;
  constellation)
    cp templates/constellation_index.html ./index.html
    echo "Constellation index template copied to ./index.html"
    ;;
  *)
    echo "Legend of the Seven Stars – D.D.T.O. CLI"
    echo
    echo "Usage:"
    echo "  ./sevenstars.sh repo        # run protocol on current repo"
    echo "  ./sevenstars.sh all         # run protocol on all discovered repos"
    echo "  ./sevenstars.sh dashboard   # copy per-repo dashboard template"
    echo "  ./sevenstars.sh constellation # copy constellation map template"
    ;;
esac
