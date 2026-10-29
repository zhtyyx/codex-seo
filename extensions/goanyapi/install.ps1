$ErrorActionPreference = "Stop"

$skillRoot = Join-Path $HOME ".agents/skills"
$skillDir = Join-Path $skillRoot "seo-goanyapi"
$mcpUrl = "https://mcp.goanyapi.com/mcp"
if (-not (Test-Path (Join-Path $skillRoot "seo"))) {
    throw "codex-seo must be installed first."
}
if (-not (Get-Command codex -ErrorAction SilentlyContinue)) {
    throw "Codex CLI is required to register the GoAnyAPI MCP server."
}

$existing = & codex mcp get goanyapi --json 2>$null
$getExitCode = $LASTEXITCODE
$addedMcp = $false
if ($getExitCode -eq 0) {
    $config = ($existing | Out-String | ConvertFrom-Json)
    if ($config.transport.url -ne $mcpUrl) {
        throw "The existing goanyapi MCP connection points to a different URL; no changes made."
    }
} else {
    & codex mcp add goanyapi --url $mcpUrl
    if ($LASTEXITCODE -ne 0) { throw "Could not add the GoAnyAPI MCP connection." }
    $addedMcp = $true
}

$sourceDir = Split-Path -Parent $MyInvocation.MyCommand.Path
New-Item -ItemType Directory -Path $skillDir -Force | Out-Null
Copy-Item (Join-Path $sourceDir "skills/seo-goanyapi/SKILL.md") (Join-Path $skillDir "SKILL.md") -Force
if ($addedMcp) {
    New-Item -ItemType File -Path (Join-Path $skillDir ".mcp-added-by-extension") -Force | Out-Null
}
Write-Host "Installed seo-goanyapi. Complete OAuth in Codex if prompted, then restart your session."
Write-Host "Setup: https://goanyapi.com/mcp"
