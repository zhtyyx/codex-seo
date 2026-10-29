#!/usr/bin/env bash
set -euo pipefail

source_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
skill_root="${HOME}/.agents/skills"
skill_dir="${skill_root}/seo-goanyapi"
mcp_url="https://mcp.goanyapi.com/mcp"

if [ ! -d "${skill_root}/seo" ]; then
    echo "codex-seo must be installed first." >&2
    exit 1
fi
if ! command -v codex >/dev/null 2>&1; then
    echo "Codex CLI is required to register the GoAnyAPI MCP server." >&2
    exit 1
fi
if ! command -v python3 >/dev/null 2>&1; then
    echo "Python 3 is required to inspect an existing MCP connection." >&2
    exit 1
fi

added_mcp=0
if existing="$(codex mcp get goanyapi --json 2>/dev/null)"; then
    existing_url="$(printf '%s' "${existing}" | python3 -c 'import json,sys; print(json.load(sys.stdin).get("transport", {}).get("url", ""))')"
    if [ "${existing_url}" != "${mcp_url}" ]; then
        echo "The existing goanyapi MCP connection points to a different URL; no changes made." >&2
        exit 1
    fi
else
    codex mcp add goanyapi --url "${mcp_url}"
    added_mcp=1
fi

mkdir -p "${skill_dir}"
cp "${source_dir}/skills/seo-goanyapi/SKILL.md" "${skill_dir}/SKILL.md"
if [ "${added_mcp}" -eq 1 ]; then
    touch "${skill_dir}/.mcp-added-by-extension"
fi

echo "Installed seo-goanyapi. Complete OAuth in Codex if prompted, then restart your session."
echo "Setup: https://goanyapi.com/mcp"
