
# fnm
export PATH="/root/.local/share/fnm:$PATH"
eval "`fnm env`"

# pnpm
export PNPM_HOME=/root/.pnpm
export PATH="${PNPM_HOME}:${PATH}"

# Load Angular CLI autocompletion.
source <(ng completion script)
