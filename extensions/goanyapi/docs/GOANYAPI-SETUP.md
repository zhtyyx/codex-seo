# GoAnyAPI extension setup

This optional extension connects Codex SEO to the [official GoAnyAPI remote MCP server](https://goanyapi.com/mcp). GoAnyAPI provides website traffic, domain rating, backlinks, keywords, Google/Bing search results, and other website intelligence. The service uses OAuth and charges the authorized GoAnyAPI account's credits for billable tools. Check [goanyapi.com](https://goanyapi.com) and the [current API documentation](https://goanyapi.com/docs) for the live catalog and rates.

## Install

Install Codex SEO first. Then run one installer from a clone of this repository:

```bash
./extensions/goanyapi/install.sh
```

On Windows PowerShell:

```powershell
.\extensions\goanyapi\install.ps1
```

The installer copies the `seo-goanyapi` skill and adds `https://mcp.goanyapi.com/mcp` as the `goanyapi` Codex MCP connection if that name is unused. It keeps a matching existing connection and stops without changing it if the name points elsewhere. It does not request or store an API key.

Complete the browser authorization when Codex prompts for it. If the connection is still unauthenticated, follow the [official MCP setup guide](https://goanyapi.com/mcp) for your Codex version. Start a new Codex session after authorization so the tools are loaded.

## Verify and use

Check `codex mcp get goanyapi` for the configured URL. In the new session, check that a GoAnyAPI tool is available; `goanyapi_credits_balance` is a read-only, free verification call. Example prompts:

```text
$seo goanyapi traffic example.com
$seo goanyapi serp "best project management software" for US English
$seo goanyapi keywords "project management software"
```

The skill lists the available command routes. It checks the live tool schema for optional parameters and labels results with their GoAnyAPI source.

## Uninstall

```bash
./extensions/goanyapi/uninstall.sh
```

On Windows PowerShell, run `.\extensions\goanyapi\uninstall.ps1`. The uninstaller removes this extension's skill. It removes the `goanyapi` MCP entry only if this extension originally added it; a matching entry that existed before installation stays in place.
