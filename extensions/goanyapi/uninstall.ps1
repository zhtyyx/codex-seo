$ErrorActionPreference = "Stop"

$skillDir = Join-Path $HOME ".agents/skills/seo-goanyapi"
if (Test-Path (Join-Path $skillDir ".mcp-added-by-extension")) {
    if (-not (Get-Command codex -ErrorAction SilentlyContinue)) {
        throw "Codex CLI is required to remove the MCP connection added by this extension."
    }
    $existing = & codex mcp get goanyapi --json 2>$null
    if ($LASTEXITCODE -eq 0) {
        $config = ($existing | Out-String | ConvertFrom-Json)
        if ($config.transport.url -eq "https://mcp.goanyapi.com/mcp") {
            & codex mcp remove goanyapi
            if ($LASTEXITCODE -ne 0) { throw "Could not remove the GoAnyAPI MCP connection." }
        } else {
            Write-Host "The goanyapi MCP connection has changed; leaving it in place."
        }
    }
}
if (Test-Path $skillDir) { Remove-Item $skillDir -Recurse -Force }
Write-Host "Removed seo-goanyapi."
