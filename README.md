# Plaintest — Daily Cessna 172 Finder

Automatically searches aircraft listing sites once a day, ranks the best Cessna 172
matches against my criteria, flags any "unicorn," and emails me a top-10 digest.
Runs free on GitHub Actions — no computer needs to be on.

## What it looks for
- Cessna 172, **1975 or newer**
- **No reported damage history**
- **Low total time** preferred
- **Under $75,000** — unless it's a unicorn worth stretching for

A *unicorn* = either a 1975+ clean, low-time 172 that somehow lists at/under $75k,
or a late-model 172R/172S with very low time and no damage (the "won't outgrow it" plane).

All criteria, price ceiling, and scoring weights live in the `CONFIG` block at the
top of `plane_finder.py` — edit anytime.

## Files
- `plane_finder.py` — the search, scoring, unicorn-detection, and email logic
- `.github/workflows/daily-plane-finder.yml` — the daily schedule (runs on GitHub's servers)
- `requirements.txt` — Python dependencies

## How you get the digest
By default the workflow posts each run's results as a **GitHub Issue** titled
`Cessna 172 digest — YYYY-MM-DD`. GitHub emails/notifies you about new issues,
so there's **nothing to configure** — it uses the built-in `GITHUB_TOKEN`.

Want email instead? See [Optional: email delivery](#optional-email-delivery) below.

## One-time setup

### 1. Test it
**Actions** tab → **Daily Plane Finder** → **Run workflow**. Watch the log; you'll
see it fetch each site, score listings, write the digest, and open the issue.

> First run only: if you see a permissions error opening the issue, go to
> **Settings → Actions → General → Workflow permissions** and select
> **Read and write permissions**.

### 2. It's now automatic
The schedule runs daily at **12:00 UTC** (7 AM US Central / 8 AM Eastern). To change
the time, edit the `cron:` line in the workflow — format is `minute hour day month weekday`,
always in UTC.

## Optional: email delivery
The script can also email the digest over SMTP instead of (or in addition to)
the issue. Add these five secrets under **Settings → Secrets and variables →
Actions** and wire them into the workflow's "Run plane finder" step as env vars
(use a Gmail **App Password**, not your normal password):

| Secret name      | Value                                  |
|------------------|----------------------------------------|
| `PF_SMTP_HOST`   | `smtp.gmail.com`                       |
| `PF_SMTP_PORT`   | `587`                                  |
| `PF_SMTP_USER`   | your Gmail address                     |
| `PF_SMTP_PASS`   | your 16-character Gmail App Password    |
| `PF_TO_ADDR`     | where the digest should be sent        |

Gmail App Password: Google Account → Security → 2-Step Verification → App passwords.

## Honest expectations
- Listing sites sometimes **block automated requests (HTTP 403)**. If a run shows
  "parsed 0 listings," that's the site blocking, not a logic bug. Run locally with
  `python plane_finder.py --debug` to dump the HTML and adjust the parser's CSS selectors.
- **Back this up with the sites' own saved-search email alerts** (Trade-A-Plane, Controller).
  Those run server-side and never get blocked. This repo adds the ranking + unicorn layer
  on top; the saved searches guarantee nothing slips past.
- Keep this to personal use and respect each site's robots.txt / Terms of Service.

## Always verify
Confirm damage history, logs, and hours directly with the seller and a pre-buy inspection.
This tool surfaces candidates; it does not replace due diligence.
