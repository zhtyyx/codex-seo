# Codex SEO

[简体中文](README.md) | English

Free, open-source SEO audits inside [OpenAI Codex CLI](https://developers.openai.com/codex).

> **Origin:** Codex SEO is a port of [claude-seo](https://github.com/AgriciDaniel/claude-seo) by Agrici Daniel (MIT). All credit for the audit methodology, skills, and scripts goes to the upstream project and its contributors; this repository adapts it to run on Codex CLI. See [LICENSE](LICENSE) and [CONTRIBUTORS.md](CONTRIBUTORS.md).

<p>
  <a href="https://github.com/zhtyyx/codex-seo/actions/workflows/ci.yml"><img src="https://github.com/zhtyyx/codex-seo/actions/workflows/ci.yml/badge.svg" alt="CI" /></a>
  <a href="https://developers.openai.com/codex"><img src="https://img.shields.io/badge/Codex%20CLI-Skills-blue" alt="Codex CLI skills" /></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="License: MIT" /></a>
  <a href="https://github.com/AgriciDaniel/claude-seo"><img src="https://img.shields.io/badge/port%20of-claude--seo-8A2BE2" alt="Port of claude-seo" /></a>
  <a href="https://linux.do/"><img src="https://img.shields.io/badge/Linux.do-Community-2b6de8" alt="Linux.do Community" /></a>
</p>

Give it any website and it runs a full SEO audit, then hands you a prioritized action plan. It checks everything a good SEO consultant would:

- **Technical SEO.** Crawlability, indexing, sitemaps, robots.txt, redirects, page speed and Core Web Vitals.
- **Content quality.** E-E-A-T (experience, expertise, authority and trust), thin pages and topic coverage.
- **Structured data.** Finds, validates and writes Schema.org markup for rich results.
- **AI search (GEO).** How likely Google AI Overviews, AI Mode, ChatGPT, Perplexity and Gemini are to cite your pages.
- **Local and e-commerce SEO.** Google Business Profile, reviews, map pack, product pages and international sites.

Codex SEO is built from 26 sub-skills and 19 specialist role playbooks. A full audit walks through every analyst role (technical, content, schema, speed, AI search and more), persisting each role's findings along the way. Every recommendation explains why it matters and how you will know it worked.

## Install

You need [OpenAI Codex CLI](https://developers.openai.com/codex) with skills support, and Python 3.11 to 3.14.

```bash
git clone --depth 1 https://github.com/zhtyyx/codex-seo.git
bash codex-seo/install.sh
```

Windows (PowerShell):

```powershell
git clone --depth 1 https://github.com/zhtyyx/codex-seo.git
powershell -ExecutionPolicy Bypass -File codex-seo\install.ps1
```

The installer copies the skills to `~/.agents/skills/` (where Codex discovers user skills), and creates an isolated Python runtime with a headless browser. Nothing global is touched; uninstall with `bash uninstall.sh`.

**Your first audit:**

```bash
codex                                    # start Codex CLI

$seo audit https://example.com           # full site audit with a prioritized plan
$seo page https://example.com/pricing    # one page, in depth
$seo geo https://example.com             # how ready you are for AI search
$seo schema https://example.com          # check and generate structured data
```

## Commands

Mention a skill with `$` in Codex CLI, e.g. `$seo audit https://example.com` (plain English like "run an SEO audit on ..." works too). The main command groups:

<details>
<summary><b>Audits and Planning</b></summary>
<ul><li><code>$seo setup</code>: Create or refresh the isolated Python runtime and Chromium</li><li><code>$seo doctor</code>: Check runtime readiness without changing the system</li><li><code>$seo audit &lt;url&gt;</code>: Full website audit, all specialist roles</li><li><code>$seo page &lt;url&gt;</code>: Deep single-page analysis</li><li><code>$seo plan &lt;type&gt;</code>: Strategic SEO planning (saas, local, ecommerce, publisher, agency)</li></ul>
</details>
<details>
<summary><b>Technical SEO</b></summary>
<ul><li><code>$seo technical &lt;url&gt;</code>: Technical SEO audit across 9 categories</li><li><code>$seo sitemap &lt;url | generate&gt;</code>: Analyze or generate XML sitemaps</li><li><code>$seo images &lt;url&gt;</code>: Image optimization analysis</li><li><code>$seo hreflang &lt;url&gt;</code>: Hreflang and i18n SEO audit and generation</li><li><code>$seo programmatic &lt;url&gt;</code>: Programmatic SEO analysis and planning</li><li><code>$seo google [command]</code>: Google SEO APIs: GSC, PageSpeed, CrUX, Indexing, GA4, PDF reports</li><li><code>$seo drift baseline | compare | history &lt;url&gt;</code>: SEO drift monitoring with SQLite snapshots</li></ul>
</details>
<details>
<summary><b>Content and E-E-A-T</b></summary>
<ul><li><code>$seo content &lt;url&gt;</code>: E-E-A-T and content quality analysis</li><li><code>$seo content-brief &lt;topic&gt;</code>: Content brief: target keywords, outline, internal links</li><li><code>$seo cluster &lt;keyword&gt;</code>: SERP-based semantic clustering</li><li><code>$seo sxo &lt;url&gt;</code>: Search Experience Optimization: page type, user stories, personas</li><li><code>$seo flow [stage]</code>: FLOW framework prompts (CC BY 4.0, evidence-led)</li><li><code>$seo competitor-pages &lt;url&gt;</code>: Competitor comparison page generation</li></ul>
</details>
<details>
<summary><b>Schema and AI Search</b></summary>
<ul><li><code>$seo schema &lt;url&gt;</code>: Detect, validate and generate Schema.org markup</li><li><code>$seo geo &lt;url&gt;</code>: AI Overviews and Generative Engine Optimization</li><li><code>$seo agentic &lt;url&gt;</code>: Agent readiness: Lighthouse Agentic Browsing X/N, AI agent access, llms.txt, Markdown, WebMCP</li></ul>
</details>
<details>
<summary><b>Local, Links, Commerce</b></summary>
<ul><li><code>$seo local &lt;url&gt;</code>: Local SEO: GBP, citations, reviews, map pack</li><li><code>$seo maps [command]</code>: Maps intelligence: geo-grid, GBP audit, reviews, competitors</li><li><code>$seo backlinks &lt;url&gt;</code>: Backlink profile analysis (Moz, Bing, Common Crawl)</li><li><code>$seo ecommerce &lt;url&gt;</code>: E-commerce SEO and marketplace intelligence</li></ul>
</details>
<details>
<summary><b>Extensions</b> (optional add-ons)</summary>
<ul><li><code>$seo image-gen [use-case]</code>: AI image generation for SEO assets</li><li><code>$seo goanyapi [command]</code>: Live traffic, DR, backlinks, keywords, and SERP data via <a href="https://goanyapi.com">GoAnyAPI</a> MCP</li><li><code>$seo seranking [command]</code>: AI Share-of-Voice across ChatGPT, Gemini, Perplexity, AI Overviews, AI Mode</li><li><code>$seo profound [command]</code>: LLM citation tracking with time-series data</li><li><code>$seo bing [command] &lt;url&gt;</code>: Bing Webmaster Tools + IndexNow URL submission</li><li><code>$seo unlighthouse &lt;url&gt;</code>: Multi-page Lighthouse runner, runs locally</li></ul>
</details>

Full reference: [docs/COMMANDS.md](docs/COMMANDS.md).

## How an audit works

1. **It learns your site.** Codex SEO detects the type of business (SaaS, local, e-commerce, publisher or agency) and adjusts its checks.
2. **The specialists line up.** Up to 17 roles audit the site in sequence: technical, content, schema, speed, AI search and more, each writing its findings as it finishes.
3. **You get a plan, not a pile of warnings.** Findings are scored and sorted into a prioritized action plan. Each recommendation says what it is based on, what it depends on and how you will know it worked.

Reports are saved as Markdown, and `$seo google report` turns them into a polished PDF.

Methodology: [thinking framework](skills/seo/references/thinking-framework.md). Architecture: [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md).

## FAQ

<details>
<summary><b>What is Codex SEO?</b></summary>

A free, open-source SEO audit tool that runs inside Codex CLI. It checks technical SEO, Core Web Vitals, content quality, Schema.org structured data, AI search readiness, local SEO, e-commerce and international SEO, then gives you a prioritized action plan. It follows Google's own documentation, including the [AI Optimization Guide](https://developers.google.com/search/docs/fundamentals/ai-optimization-guide).

</details>

<details>
<summary><b>Is it really free? Where did it come from?</b></summary>

Yes. It is MIT licensed, with no per-site pricing and no tracking. This repository is a port of [claude-seo](https://github.com/AgriciDaniel/claude-seo) (Claude Code) to OpenAI Codex CLI; the audit methodology and scripts come from the upstream project. A few optional extensions connect to paid services where you bring your own account, but everything works without them.

</details>

<details>
<summary><b>Do I need API keys?</b></summary>

No. Codex SEO works out of the box. If you want real field data, you can connect free Google APIs (PageSpeed Insights, Chrome UX Report, Search Console and Google Analytics 4) with `$seo google setup`. Your keys stay on your machine.

</details>

<details>
<summary><b>How does it help with AI search like Google AI Overviews and ChatGPT?</b></summary>

Google says optimizing for AI search is still SEO, so Codex SEO starts with the basics that AI answers rely on: being indexed, fast and clear. Then `$seo geo` scores how easy your pages are to quote, checks that AI crawlers can reach them and looks at your brand's presence on Wikipedia, Reddit, YouTube and LinkedIn. `$seo agentic` checks how well AI agents can use your site.

</details>

<details>
<summary><b>Does it work on JavaScript sites like Next.js, React or Vue?</b></summary>

Yes. When a page needs JavaScript to show its content, Codex SEO opens it in a headless browser automatically, so single-page apps are audited as visitors see them.

</details>

<details>
<summary><b>Does my data leave my computer?</b></summary>

Codex SEO runs inside Codex CLI, so the pages and data it analyzes are sent to the OpenAI model backing your Codex session, the same as anything else you work on in Codex CLI. Reports are saved as files on your machine. No SEO service or other third party sees your data unless you connect an extension or API yourself. Besides the site you audit, some checks read public sources such as Wikipedia, Reddit and Common Crawl. See [PRIVACY.md](PRIVACY.md) for the full list.

</details>

<details>
<summary><b>Good to know: requirements, limits and uninstall</b></summary>

**Requirements.** OpenAI Codex CLI and Python 3.11 to 3.14. `$seo setup` installs the headless browser for you.

**Cost of a full audit.** A full `$seo audit` runs 17 specialist role passes in the main session, so it uses more tokens than a single-page check. Everything runs on the model your Codex session is configured with.

**Limits.** Without Google API keys, Core Web Vitals are lab estimates and indexing is inferred from the page. Pages that load key content only after scrolling or clicking can give noisy results.

**Uninstall.** `bash uninstall.sh` removes the skills.

</details>

**Docs:** [Installation](docs/INSTALLATION.md) · [Commands](docs/COMMANDS.md) · [Architecture](docs/ARCHITECTURE.md) · [Troubleshooting](docs/TROUBLESHOOTING.md) · [Extensions setup](docs/MCP-INTEGRATION.md) · [Security](SECURITY.md) · [Privacy](PRIVACY.md)

## Community

学 AI，上 L 站：[Linux.do](https://linux.do/), the Chinese-speaking community for AI tooling, agents and open source.

## License and credits

MIT License, see [LICENSE](LICENSE).

Codex SEO is a port of [Claude SEO](https://github.com/AgriciDaniel/claude-seo) by Agrici Daniel. The upstream project, its contributors, and the MIT copyright notice are credited in [LICENSE](LICENSE) and [CONTRIBUTORS.md](CONTRIBUTORS.md). Contributions to this port are welcome: read [CONTRIBUTING.md](CONTRIBUTING.md) first.
