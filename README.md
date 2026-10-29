# Codex SEO

简体中文 | [English](README.en.md)

在 [OpenAI Codex CLI](https://developers.openai.com/codex) 里免费、开源地做 SEO 审计。

> **出处：** Codex SEO 移植自 Agrici Daniel 的 [claude-seo](https://github.com/AgriciDaniel/claude-seo)（MIT 协议）。审计方法论、技能与脚本的功劳属于上游项目及其贡献者，本仓库将其适配到 Codex CLI 运行。完整的版权与贡献者信息见 [LICENSE](LICENSE) 和 [CONTRIBUTORS.md](CONTRIBUTORS.md)。

<p>
  <a href="https://github.com/zhtyyx/codex-seo/actions/workflows/ci.yml"><img src="https://github.com/zhtyyx/codex-seo/actions/workflows/ci.yml/badge.svg" alt="CI" /></a>
  <a href="https://developers.openai.com/codex"><img src="https://img.shields.io/badge/Codex%20CLI-Skills-blue" alt="Codex CLI skills" /></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-yellow.svg" alt="License: MIT" /></a>
  <a href="https://github.com/AgriciDaniel/claude-seo"><img src="https://img.shields.io/badge/port%20of-claude--seo-8A2BE2" alt="Port of claude-seo" /></a>
  <a href="https://linux.do/"><img src="https://img.shields.io/badge/Linux.do-Community-2b6de8" alt="Linux.do Community" /></a>
</p>

给它任何一个网站，它会跑一次完整的 SEO 审计，然后交给你一份按优先级排好序的行动计划。它检查的内容和一个合格的 SEO 顾问一样：

- **技术 SEO**：可抓取性、收录、sitemap、robots.txt、重定向、页面速度和 Core Web Vitals
- **内容质量**：E-E-A-T（经验、专业、权威、可信）、薄页面、主题覆盖
- **结构化数据**：发现、校验并生成 Schema.org 标记
- **AI 搜索（GEO）**：你的页面被 Google AI Overviews、AI Mode、ChatGPT、Perplexity、Gemini 引用的可能性
- **本地与电商 SEO**：Google Business Profile、评价、地图包、商品页和多语言站点

Codex SEO 由 26 个子技能和 19 个专家角色剧本组成。一次完整审计会依次走过每个分析角色（技术、内容、结构化数据、速度、AI 搜索等），每个角色的发现都会落盘留证。每条建议都会说明它为什么重要、你怎么验证它生效。

## 安装

需要带 skills 支持的 [OpenAI Codex CLI](https://developers.openai.com/codex)，以及 Python 3.11 到 3.14。

```bash
git clone --depth 1 https://github.com/zhtyyx/codex-seo.git
bash codex-seo/install.sh
```

Windows（PowerShell）：

```powershell
git clone --depth 1 https://github.com/zhtyyx/codex-seo.git
powershell -ExecutionPolicy Bypass -File codex-seo\install.ps1
```

安装器会把技能复制到 `~/.agents/skills/`（Codex 从这里发现用户技能），并创建带无头浏览器的隔离 Python 运行时。不碰系统全局环境，卸载用 `bash uninstall.sh`。

**第一次审计：**

```bash
codex                                    # 启动 Codex CLI

$seo audit https://example.com           # 全站审计，输出按优先级排好的行动计划
$seo page https://example.com/pricing    # 单页深度分析
$seo geo https://example.com             # AI 搜索就绪度
$seo schema https://example.com          # 检测并生成结构化数据
```

## 命令

在 Codex CLI 里用 `$` 提及技能即可调用，例如 `$seo audit https://example.com`（自然语言说「帮我做一次 SEO 审计，网址是 …」也可以）。主要命令组：

<details>
<summary><b>审计与规划</b></summary>
<ul><li><code>$seo setup</code>：创建或刷新隔离 Python 运行时和 Chromium</li><li><code>$seo doctor</code>：只读体检，不改动系统</li><li><code>$seo audit &lt;url&gt;</code>：全站审计，全部专家角色</li><li><code>$seo page &lt;url&gt;</code>：单页深度分析</li><li><code>$seo plan &lt;type&gt;</code>：按行业做战略规划（saas、local、ecommerce、publisher、agency）</li></ul>
</details>
<details>
<summary><b>技术 SEO</b></summary>
<ul><li><code>$seo technical &lt;url&gt;</code>：9 大类技术审计</li><li><code>$seo sitemap &lt;url | generate&gt;</code>：分析或生成 XML sitemap</li><li><code>$seo images &lt;url&gt;</code>：图片优化分析</li><li><code>$seo hreflang &lt;url&gt;</code>：多语言与 hreflang 审计、生成</li><li><code>$seo programmatic &lt;url&gt;</code>：程序化 SEO 分析与规划</li><li><code>$seo google [command]</code>：Google SEO API：GSC、PageSpeed、CrUX、Indexing、GA4、PDF 报告</li><li><code>$seo drift baseline | compare | history &lt;url&gt;</code>：基于 SQLite 快照的 SEO 漂移监控</li></ul>
</details>
<details>
<summary><b>内容与 E-E-A-T</b></summary>
<ul><li><code>$seo content &lt;url&gt;</code>：E-E-A-T 与内容质量分析</li><li><code>$seo content-brief &lt;topic&gt;</code>：内容简报：目标关键词、大纲、内链</li><li><code>$seo cluster &lt;keyword&gt;</code>：基于 SERP 的语义聚类</li><li><code>$seo sxo &lt;url&gt;</code>：搜索体验优化：页面类型、用户故事、画像</li><li><code>$seo flow [stage]</code>：FLOW 框架提示词（CC BY 4.0）</li><li><code>$seo competitor-pages &lt;url&gt;</code>：竞品对比页生成</li></ul>
</details>
<details>
<summary><b>结构化数据与 AI 搜索</b></summary>
<ul><li><code>$seo schema &lt;url&gt;</code>：检测、校验并生成 Schema.org 标记</li><li><code>$seo geo &lt;url&gt;</code>：AI Overviews 与生成式引擎优化</li><li><code>$seo agentic &lt;url&gt;</code>：Agent 就绪度：Lighthouse Agentic Browsing X/N、AI agent 访问、llms.txt、Markdown、WebMCP</li></ul>
</details>
<details>
<summary><b>本地、外链、电商</b></summary>
<ul><li><code>$seo local &lt;url&gt;</code>：本地 SEO：GBP、引用、评价、地图包</li><li><code>$seo maps [command]</code>：地图情报：geo-grid、GBP 审计、竞对半径</li><li><code>$seo backlinks &lt;url&gt;</code>：外链画像分析（Moz、Bing、Common Crawl）</li><li><code>$seo ecommerce &lt;url&gt;</code>：电商 SEO 与市场情报</li></ul>
</details>
<details>
<summary><b>扩展</b>（可选）</summary>
<ul><li><code>$seo image-gen [use-case]</code>：为 SEO 素材生成 AI 图片</li><li><code>$seo goanyapi [command]</code>：通过 <a href="https://goanyapi.com">GoAnyAPI</a> MCP 查询流量、DR、外链、关键词和 SERP</li><li><code>$seo seranking [command]</code>：ChatGPT、Gemini、Perplexity、AI Overviews、AI Mode 的 AI 声量份额</li><li><code>$seo profound [command]</code>：LLM 引用追踪与时间序列</li><li><code>$seo bing [command] &lt;url&gt;</code>：Bing 站长工具 + IndexNow 提交</li><li><code>$seo unlighthouse &lt;url&gt;</code>：多页 Lighthouse，本地运行</li></ul>
</details>

完整命令参考：[docs/COMMANDS.md](docs/COMMANDS.md)。

## 审计是怎么跑的

1. **先摸清你的站。** Codex SEO 自动识别业务类型（SaaS、本地服务、电商、内容站、代理机构），并据此调整检查项。
2. **专家依次上场。** 最多 17 个角色按顺序审计：技术、内容、结构化数据、速度、AI 搜索等，每个角色完成即写入自己的发现文件。
3. **你拿到的是计划，不是一堆告警。** 发现会被打分并归入按优先级排序的行动计划。每条建议都写清依据是什么、依赖什么、怎么验证生效。

报告保存为 Markdown，一句「生成 PDF 报告」即可用 `$seo google report` 输出 PDF。

方法论：[思维框架](skills/seo/references/thinking-framework.md)；架构：[docs/ARCHITECTURE.md](docs/ARCHITECTURE.md)。

## 常见问题

<details>
<summary><b>这是从哪来的？免费吗？</b></summary>

本仓库是 [claude-seo](https://github.com/AgriciDaniel/claude-seo)（Claude Code 版）到 OpenAI Codex CLI 的移植，审计方法论与脚本来自上游项目，基于其最新的 v2.5.0 基线。MIT 协议，无按站计费、无跟踪。少数可选扩展连接付费服务（自带账号），不装也完全可用。

</details>

<details>
<summary><b>需要 API key 吗？</b></summary>

不需要，开箱即用。想要真实字段数据，可以用 `$seo google setup` 接入免费的 Google API（PageSpeed Insights、Chrome UX Report、Search Console、GA4）。你的密钥只保存在本机。

</details>

<details>
<summary><b>对 AI 搜索（AI Overviews、ChatGPT）有帮助吗？</b></summary>

Google 明确说 AI 搜索优化本质上仍是 SEO，所以 Codex SEO 先夯实 AI 回答依赖的基础：被收录、够快、表达清晰。然后 `$seo geo` 评估你的页面有多容易被引用、AI 爬虫能否访问、品牌在 Wikipedia、Reddit、YouTube、LinkedIn 上的存在感；`$seo agentic` 检查 AI agent 能多好地使用你的网站。

</details>

<details>
<summary><b>Next.js / React / Vue 这类 JS 站支持吗？</b></summary>

支持。页面需要 JavaScript 才出内容时，Codex SEO 会自动用无头浏览器打开，SPA 按访客看到的样子审计。

</details>

<details>
<summary><b>数据会离开我的电脑吗？</b></summary>

Codex SEO 跑在 Codex CLI 里，被分析的页面和数据会发送给你 Codex 会话背后的 OpenAI 模型，和你在 Codex 里做的其他事一样。报告以文件形式保存在你本机。除非你自己接入扩展或 API，没有任何 SEO 服务或第三方看到你的数据。除被审计网站外，部分检查会读取 Wikipedia、Reddit、Common Crawl 等公开来源。完整清单见 [PRIVACY.md](PRIVACY.md)。

</details>

<details>
<summary><b>须知：要求、边界与卸载</b></summary>

**要求**：OpenAI Codex CLI 与 Python 3.11 到 3.14，`$seo setup` 会装无头浏览器。

**全站审计的成本**：`$seo audit` 在主会话里跑 17 个角色，token 消耗高于单页检查，用的是你 Codex 会话配置的模型。

**边界**：没有 Google API key 时，Core Web Vitals 是实验估算、收录状态由页面推断。关键内容靠滚动或点击才加载的页面，结果可能有噪音。

**卸载**：`bash uninstall.sh` 移除技能。

</details>

**文档**：[安装](docs/INSTALLATION.md) · [命令](docs/COMMANDS.md) · [架构](docs/ARCHITECTURE.md) · [故障排查](docs/TROUBLESHOOTING.md) · [扩展配置](docs/MCP-INTEGRATION.md) · [安全](SECURITY.md) · [隐私](PRIVACY.md)

## 社区

学 AI，上 L 站：[Linux.do](https://linux.do/)，中文 AI 工具、Agent 与开源社区。

## 许可与致谢

MIT 协议，见 [LICENSE](LICENSE)。

Codex SEO 移植自 Agrici Daniel 的 [Claude SEO](https://github.com/AgriciDaniel/claude-seo)。上游项目、其贡献者与 MIT 版权声明在 [LICENSE](LICENSE) 和 [CONTRIBUTORS.md](CONTRIBUTORS.md) 中致谢。欢迎向本移植贡献：请先阅读 [CONTRIBUTING.md](CONTRIBUTING.md)。
