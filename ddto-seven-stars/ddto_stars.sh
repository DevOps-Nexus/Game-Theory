#!/bin/bash
set -e

# Color definitions
YELLOW='\033[1;33m'
MAGENTA='\033[1;35m'
RESET='\033[0m'

echo -e "
${YELLOW}  __      __           _           _____ _                       
  \\ \\    / /          | |         / ____| |                      
   \\ \\  / /__  _ __ __| | ___ _ _| (___ | |_ _ __ ___  ___  ___  
    \\ \\/ / _ \\| '__/ _\` |/ _ \\ '__\\___ \\| __| '__/ _ \\/ __|/ _ \\ 
     \\  / (_) | | | (_| |  __/ |  ____) | |_| | |  __/\\__ \\  __/ 
      \\/ \\___/|_|  \\__,_|\\___|_| |_____/ \\__|_|  \\___||___/\\___| 
${RESET}
${MAGENTA}        Legend of the Seven Stars – D.D.T.O. Protocol${RESET}
"

echo "Running D.D.T.O. Seven Stars protocol on $(basename "$(pwd)")..."

# Star 1: Repository health check
echo "⭐ Star 1: Repository health check"
if [ -d ".git" ]; then
  echo "  ✅ Git repository detected"
else
  echo "  ⚠️ Not a git repository"
fi

# Star 2: Branch analysis
echo "⭐ Star 2: Branch analysis"
if command -v git &> /dev/null && [ -d ".git" ]; then
  BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "unknown")
  echo "  Current branch: $BRANCH"
fi

# Star 3: File inventory
echo "⭐ Star 3: File inventory"
if command -v git &> /dev/null && [ -d ".git" ]; then
  FILE_COUNT=$(git ls-files | wc -l)
  echo "  Tracked files: $FILE_COUNT"
fi

# Star 4: Commit history summary
echo "⭐ Star 4: Commit history summary"
if command -v git &> /dev/null && [ -d ".git" ]; then
  COMMIT_COUNT=$(git rev-list --count HEAD 2>/dev/null || echo "0")
  echo "  Total commits: $COMMIT_COUNT"
fi

# Star 5: Documentation check
echo "⭐ Star 5: Documentation check"
for DOC in README.md CONTRIBUTING.md LICENSE CODE_OF_CONDUCT.md; do
  if [ -f "$DOC" ]; then
    echo "  ✅ $DOC found"
  else
    echo "  ❌ $DOC missing"
  fi
done

# Star 6: CI/CD check
echo "⭐ Star 6: CI/CD check"
if [ -d ".github/workflows" ]; then
  WF_COUNT=$(ls .github/workflows/*.yml .github/workflows/*.yaml 2>/dev/null | wc -l)
  echo "  ✅ GitHub Actions workflows: $WF_COUNT"
else
  echo "  ❌ No CI/CD workflows found"
fi

# Star 7: Summary
echo "⭐ Star 7: Summary"
echo "  D.D.T.O. protocol complete for $(basename "$(pwd)")"
echo "  ✨ All seven stars evaluated."
