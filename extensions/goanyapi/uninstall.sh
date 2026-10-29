#!/usr/bin/env bash
set -euo pipefail

skill_dir="${HOME}/.agents/skills/seo-goanyapi"
if [ -f "${skill_dir}/.mcp-added-by-extension" ]; then
    if ! command -v codex >/dev/null 2>&1; then
        echo "Codex CLI is required to remove the MCP connection added by this extension." >&2
        exit 1
    fi
    if existing="$(codex mcp get goanyapi --json 2>/dev/null)"; then
        existing_url="$(printf '%s' "${existing}" | python3 -c 'import json,sys; print(json.load(sys.stdin).get("transport", {}).get("url", ""))')"
        if [ "${existing_url}" = "https://mcp.goanyapi.com/mcp" ]; then
            codex mcp remove goanyapi
        else
            echo "The goanyapi MCP connection has changed; leaving it in place."
        fi
    fi
fi
if [ -d "${skill_dir}" ]; then
    rm -rf "${skill_dir}"
fi
echo "Removed seo-goanyapi."
