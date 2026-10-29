# Codex SEO: Universal SEO Analysis Skill

> Project instructions for **OpenAI Codex CLI** (this file is read automatically
> at session start) and any other agent harness that reads project-root agent
> instructions: Cursor, Cursor Cloud Agents, Google Antigravity, Gemini CLI,
> Grok Build, Cline, Aider.

## Portability note

Codex SEO is a Codex CLI port of [Claude SEO](https://github.com/AgriciDaniel/claude-seo)
by Agrici Daniel (MIT). Skills follow the Agent Skills open standard
(`SKILL.md` with `name`/`description` frontmatter), so the same files load in
any compatible harness. Validate with:

```bash
./scripts/codex-seo run portability_check.py
```

### Per-harness notes

| Harness | How to load codex-seo |
|---|---|
| **OpenAI Codex CLI** | Install skills to `~/.agents/skills/` via `bash install.sh` (Codex discovers user skills there), or work inside this repo: Codex scans `.agents/skills` up to the repo root. The `/seo` slash command is a custom prompt copied to `~/.codex/prompts/seo.md`; skills can also be invoked as `$seo audit <url>`. |
| **Cursor** | Symlink or copy `skills/` and `agents/` into `.cursor/rules/`. Commands are invoked as text prompts; the harness reads `SKILL.md` body as system context. |
| **Cursor Cloud Agents** | Push the repo; Cloud Agents read `AGENTS.md` automatically at session start. |
| **Google Antigravity** | Point the workspace at this repo root; Antigravity reads `AGENTS.md` first, falls back to `skills/`. |
| **Gemini CLI** | `gemini init` in this repo loads `AGENTS.md`. Skills are activated via `activate_skill <name>` in conversation. |
| **Grok Build** | Open this repository in Grok Build. It reads `AGENTS.md` and Agent Skills compatible layouts without a separate layout. |
| **Cline** | Loads `AGENTS.md` from project root. Skills appear as system messages. |
| **Aider** | Reads `AGENTS.md` if present; otherwise falls back to README. Skills run inline. |

## Project Overview

This repository contains **Codex SEO**, a comprehensive SEO analysis skill suite
for Codex CLI. It follows the Agent Skills open standard and the 3-layer
architecture (directive, orchestration, execution). 26 sub-skills (22 core +
1 orchestrator + 1 framework integration + 2 extension mirrors), 19 specialist
role playbooks (16 core + 1 framework integration + 2 extension mirrors; Codex
runs them as sequential role passes, see "Execution model" below), and an
extensible reference system cover technical SEO, content quality, schema
markup, image optimization, sitemap architecture, AI search optimization,
local SEO (GBP, citations, reviews, map pack), maps intelligence, semantic
topic clustering, search experience optimization (SXO), SEO drift monitoring,
e-commerce SEO, and international SEO with cultural adaptation profiles.
Matomo is available as an optional extension for self-hosted analytics.

## Architecture

```
codex-seo/
  AGENTS.md                          # Project instructions (this file)
  CONTRIBUTORS.md                    # Community credits
  skills/                            # 26 sub-skills (installed to ~/.agents/skills)
    seo/                           # Main orchestrator skill
      SKILL.md                     # Entry point, routing table, core rules
      references/                  # On-demand knowledge files (13 files)
    seo-audit/SKILL.md            # Full site audit with sequential role passes
    seo-page/SKILL.md             # Deep single-page analysis
    seo-technical/SKILL.md        # Technical SEO (9 categories)
    seo-content/SKILL.md          # E-E-A-T and content quality
    seo-content-brief/SKILL.md    # Content brief generation
    seo-schema/SKILL.md           # Schema.org markup detection/generation
    seo-sitemap/SKILL.md          # XML sitemap analysis/generation
    seo-images/SKILL.md           # Image optimization analysis
    seo-geo/SKILL.md              # AI search / GEO optimization
    seo-agentic/                  # Agent readiness (Lighthouse Agentic Browsing, WebMCP)
    seo-local/SKILL.md            # Local SEO (GBP, citations, reviews, map pack)
    seo-maps/SKILL.md             # Maps intelligence (geo-grid, GBP audit, reviews, competitors)
    seo-plan/SKILL.md             # Strategic SEO planning
    seo-flow/SKILL.md             # FLOW framework integration
    seo-programmatic/SKILL.md     # Programmatic SEO at scale
    seo-competitor-pages/SKILL.md # Competitor comparison pages
    seo-hreflang/SKILL.md         # International SEO / hreflang
    seo-google/                   # Google SEO APIs
    seo-backlinks/SKILL.md        # Backlink profile analysis
    seo-cluster/                  # Semantic topic clustering
    seo-sxo/                      # Search Experience Optimization
    seo-drift/                    # SEO drift monitoring
    seo-ecommerce/                # E-commerce SEO
    seo-dataforseo/SKILL.md       # Live SEO data via DataForSEO MCP (extension mirror)
    seo-image-gen/                # AI image generation for SEO assets (extension mirror)
  agents/                          # 19 specialist role playbooks
    seo-technical.md             # Crawlability, indexability, security
    seo-content.md               # E-E-A-T, readability, thin content
    ... (see agents/ directory)
  scripts/                         # 61 Python execution scripts
    codex-seo                    # Runtime launcher (bash)
    runtime.py                   # Managed venv runtime (setup/doctor/run)
    codex_config.py              # MCP + env config helper for ~/.codex
    google_auth.py               # Credential management (OAuth, SA, API key)
    fetch_page.py                # Page fetcher with UA rotation
    url_safety.py                # Canonical URL/SSRF safety module
    ... (see scripts/ directory)
  schema/                          # Schema.org JSON-LD templates
  extensions/                      # Optional add-on install helpers (9 extensions)
    dataforseo/ firecrawl/ banana/ ahrefs/ bing-webmaster/
    profound/ seranking/ matomo/ unlighthouse/
  docs/                            # Extended documentation
```

## Execution model (Codex CLI)

Codex CLI runs every analysis in the main session; it has no declarative
subagent dispatch. The 19 `agents/*.md` files are **role playbooks**: during a
full audit the orchestrator skill loads each playbook, executes it end to end,
writes findings to `output_dir/findings/<role>.md`, then moves to the next
role. Installers place the playbooks at `~/.agents/skills/seo/agents/`.

### Tool-name compatibility

Where skills mention harness tools (`Read`, `Write`, `Edit`, `Bash`, `Glob`,
`Grep`, `WebFetch`), each harness has an equivalent:

| Skill text | Codex | Cline | Aider | Cursor / Antigravity |
|---|---|---|---|---|
| Read       | read_file        | read_file       | (inline)        | read |
| Write      | write_file       | write_file       | /add then edit  | write |
| Edit       | apply_patch      | replace_in_file | /edit           | edit |
| Bash       | shell            | execute_command | /run            | terminal |
| Glob       | shell glob       | search_files    | (inline)        | find |
| Grep       | shell grep       | search_files    | /grep           | grep |
| WebFetch   | shell curl / browse | (browser tool) | (n/a)        | fetch |

These mappings are automatic in most harnesses; they are listed for
transparency in case a recipe needs a specific call.

Bundled tools run through the launcher:

```bash
# inside a clone (CODEX_SEO_ROOT is the repo root)
./scripts/codex-seo run <script.py>
# after install.sh (canonical absolute form, rewritten by the installer)
"$HOME/.agents/skills/seo/scripts/codex-seo" run <script.py>
```

## Commands

| Command | Use Case |
|---------|----------|
| `$seo audit <url>` | Full website audit with sequential role passes |
| `$seo page <url>` | Single page analysis |
| `$seo technical <url>` | Technical SEO across 9 categories |
| `$seo content <url>` | E-E-A-T and content quality |
| `$seo content-brief <topic>` | Detailed content brief: keywords, outline, internal links |
| `$seo schema <url>` | Schema markup detection, validation, generation |
| `$seo sitemap <url>` | Sitemap validation |
| `$seo sitemap generate` | Create new sitemap with industry templates |
| `$seo images <url>` | Image optimization |
| `$seo geo <url>` | AI search optimization (GEO) |
| `$seo agentic <url>` | Agent readiness (Lighthouse Agentic Browsing, AI agent access, WebMCP) |
| `$seo local <url>` | Local SEO (GBP, citations, reviews) |
| `$seo maps [command]` | Maps intelligence (geo-grid, GBP audit, competitors) |
| `$seo backlinks <url>` | Backlink profile analysis |
| `$seo cluster <seed>` | SERP-based semantic clustering |
| `$seo sxo <url>` | Search Experience Optimization |
| `$seo drift baseline\|compare\|history <url>` | SEO drift monitoring |
| `$seo ecommerce <url>` | E-commerce SEO |
| `$seo hreflang [url]` | Hreflang and international SEO |
| `$seo plan <type>` | Strategic planning by industry |
| `$seo programmatic [url\|plan]` | Programmatic SEO analysis |
| `$seo competitor-pages [url\|generate]` | Competitor comparison pages |
| `$seo flow [stage] [url\|topic]` | FLOW framework prompts |
| `$seo google [command] [url]` | Google SEO APIs (GSC, PSI, CrUX, GA4) |
| `$seo dataforseo [command]` | Live SEO data (extension) |
| `$seo goanyapi [command]` | Live traffic, DR, backlinks, keywords, and SERP data via GoAnyAPI MCP (extension) |
| `$seo image-gen [use-case] <desc>` | AI image generation (extension) |
| `$seo firecrawl [command] <url>` | Full-site crawling (extension) |
| `$seo ahrefs [command] <url>` | Backlinks, organic keywords, and content data via the official Ahrefs MCP (extension) |
| `$seo seranking [command]` | AI Share-of-Voice across ChatGPT, Gemini, Perplexity, AI Overviews, AI Mode (extension) |
| `$seo profound [command]` | LLM citation tracking with time-series data (extension) |
| `$seo bing [command] <url>` | Bing Webmaster Tools + IndexNow URL submission (extension) |
| `$seo unlighthouse <url>` | Multi-page Lighthouse runner, runs locally (extension) |

## Development Rules

- Keep SKILL.md files under 500 lines / 5000 tokens
- Reference files should be focused and under 200 lines
- Scripts must have docstrings, CLI interface, and JSON output
- Follow kebab-case naming for all skill directories
- Bundled tools run through `"${CODEX_SEO_ROOT}/scripts/codex-seo" run`; the installer rewrites this to `"$HOME/.agents/skills/seo/scripts/codex-seo"`
- Extension credentials persist in `~/.config/codex-seo/env.json`; the launcher merges them into every bundled script's environment
- Manual Python dependencies install into `~/.agents/skills/seo/.venv/`
- Test with `python3 -m pytest tests/` after changes (if applicable)

## Security Rules

- **Never commit credentials**: `.env`, `client_secret*.json`, `oauth-token.json`, `service_account*.json` are all in `.gitignore`
- **URL validation**: All scripts that connect to user-supplied URLs must use `scripts/url_safety.py` (`validate_url_strict()` plus the pinned safe request helpers). This blocks private IPs, loopback, metadata endpoints, redirect rebinding, and DNS rebinding.
- **OAuth tokens**: Never store `client_secret` in the token file. Read it from the client_secret.json file at runtime.
- **No hardcoded paths**: Use `os.path.dirname(os.path.abspath(__file__))` for relative paths, never a user-specific absolute path
- **Config location**: `~/.config/codex-seo/google-api.json` and `~/.config/codex-seo/backlinks-api.json` (user-space, not in repo)

## Report Generation Rules

- **All SEO reports must use `scripts/google_report.py`** as the canonical report generator
- **Dependencies**: `matplotlib>=3.8.0` (charts) + `weasyprint>=70.0` (HTML-to-PDF), both in `requirements.txt`
- **Format**: A4 PDF via WeasyPrint + matplotlib charts at 200 DPI
- **Style**: Clean white title page with navy (#1e3a5f) accent, Times New Roman body font
- **Color palette**: Navy #1e3a5f (headers), dark gold #b8860b (accents), forest green #2d6a4f (pass), warm amber #d4740e (warnings), deep red #c53030 (fail), warm cream #faf9f7 (backgrounds)
- **Structure**: Title page → TOC with scores → Executive Summary → Data sections → Recommendations → Methodology
- **Charts**: 85% width, max-height 120mm, figure captions on every chart, saved to `charts/` at 200 DPI
- **No `page-break-inside: avoid`** on any element (causes white gaps in WeasyPrint)
- **Post-generation review**: `_review_pdf()` runs automatically, checking for empty images, thin sections, duplicates
- **Before presenting any PDF to the user**: verify the review passes (`"status": "PASS"`)
- **Cross-skill enforcement**: After completing ANY analysis command (audit, page, technical, content, schema, geo, local, maps), offer: "Generate a PDF report? Use `$seo google report`"
- **Google logo** appears on title page when using Google API data ("Powered by Google APIs")

## Key Principles

1. **Progressive Disclosure**: Metadata always loaded, instructions on activation, resources on demand
2. **Industry Detection**: Auto-detect SaaS, e-commerce, local, publisher, agency
3. **Sequential Role Passes**: Full audits execute all 17 analyst roles with findings persisted per role
4. **Extension System**: DataForSEO, GoAnyAPI, Firecrawl, Banana, Ahrefs, SE Ranking, Profound, Bing Webmaster, Matomo, and Unlighthouse extensions

## Credits

Port of [claude-seo](https://github.com/AgriciDaniel/claude-seo) for OpenAI Codex CLI.
Created by [@AgriciDaniel](https://github.com/AgriciDaniel).
v1.9.0 community contributions by Lutfiya Miller, Chris Muller, Florian Schmitz,
Dan Colta, and Matej Marjanovic. See [CONTRIBUTORS.md](CONTRIBUTORS.md).
