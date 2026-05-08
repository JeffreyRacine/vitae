# CV Website Operations

This repository is the development copy for Jeffrey S. Racine's CV website and
official PDF CV. The public site is served from the GitHub repository
`JeffreyRacine/vitae`, while the weekly Google Scholar refresh is rendered
locally because GitHub-hosted rendering cannot reliably query Google Scholar.

## Working Model

Use three distinct roles:

1. **Development checkout**
   - Path: `/Users/jracine/Development/CV_website`
   - Purpose: design changes, content edits, review, local rendering, and local
     commits before publication.
   - This is the normal place to edit `index.qmd`, `cv.css`, scripts, and
     supporting files.

2. **GitHub repository**
   - Remote: `git@github.com:JeffreyRacine/vitae.git`
   - Public site: `https://jeffreyracine.github.io/vitae/`
   - Purpose: source of truth for publication history and GitHub Pages hosting.

3. **Production cron checkout**
   - Path: `$HOME/Library/Mobile Documents/com~apple~CloudDocs/Documents/CV`
   - Purpose: convenience production checkout used by the scheduled local render.
   - This checkout exists in iCloud so it is available across M2Studio, M2MBP,
     and `pc-racine1.mcmaster.ca`.

## Why This Structure

A local production clone outside iCloud would usually be cleaner for automation:
it avoids cloud-sync races and keeps `.git` state on a normal filesystem.

For this CV workflow, however, iCloud solves a real coordination problem. Jeffrey
works across M2Studio, M2MBP, and `pc-racine1.mcmaster.ca`, and home-directory
sync aliases such as `push_to_KTH431` and `pull_from_KTH431` can clobber
automatic updates in ordinary home-folder paths. The iCloud CV folder has proven
to be a stable cross-machine location and avoids those sync-alias conflicts.

The resulting best-fit design is:

- edit and review in `/Users/jracine/Development/CV_website`;
- push accepted changes to GitHub;
- let the iCloud production checkout pull from GitHub;
- let M2Studio run the weekly Google Scholar refresh and push the rendered
  update back to GitHub Pages;
- pull from GitHub in the development checkout before starting future CV work.

This is not a generic textbook deployment layout. It is a practical layout for a
single-author, multi-Mac workflow where Google Scholar refresh must remain local
and GitHub Pages should still host the static output.

## Scheduled Publisher

M2Studio is the designated scheduled publisher. It is reliable, usually
available, and is where Jeffrey spends most of his time.

Do not install the weekly scheduled CV publisher on M2MBP or
`pc-racine1.mcmaster.ca` while M2Studio remains the designated publisher. Running
multiple weekly publishers can cause duplicate Google Scholar queries, racing
commits, and unnecessary Git conflicts.

The iCloud checkout may be pulled or inspected from other machines, but routine
automated publishing should remain single-host.

## Recommended Crontab Entry

Install this on M2Studio only:

```cron
0 0 * * 0 /opt/local/bin/bash -l -c '{ set -e; mkdir -p "$HOME/Library/Logs/CV"; if [ -f "$HOME/.bashrc" ]; then source "$HOME/.bashrc"; fi; cd "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Documents/CV"; CV_PUSH=1 /opt/local/bin/bash ./CV.sh; } >> "$HOME/Library/Logs/CV/cron.log" 2>&1'
```

This improves the older one-line cron entry by:

- creating a durable log directory before rendering;
- logging the whole workflow, not only `CV.sh`;
- using a quoted iCloud path rather than backslash-heavy path escaping;
- setting `CV_PUSH=1`, which tells `CV.sh` to push successful render commits;
- keeping environment setup explicit through the login shell and `.bashrc`;
- leaving the rendering, locking, git pull, commit-if-changed, and push behavior
  inside `CV.sh`.

## What `CV.sh` Is Responsible For

`CV.sh` should remain the operational script for the production checkout. Its
current responsibilities are:

- stop if another render is already running by using `.cv-render.lock`;
- source `$HOME/.bashrc` when available;
- run `git pull --ff-only` when the current branch has an upstream;
- remove stale `index_files`;
- render `index.qmd` with Quarto;
- copy `index.pdf` to `vitae.pdf`;
- stage the required source and static output assets;
- commit only when rendered output changed;
- push only when `CV_PUSH=1`.

The cron line should stay boring. If the workflow becomes more complex, add that
logic to `CV.sh` or to a small version-controlled wrapper script, not directly to
crontab.

## Routine Development Flow

For normal content or design changes:

1. Work in `/Users/jracine/Development/CV_website`.
2. Render and review locally.
3. Commit locally.
4. Push the accepted branch or merge to GitHub.
5. In the iCloud production checkout, run `git pull --ff-only`.
6. Let M2Studio cron handle the next scheduled Google Scholar refresh.

After the weekly cron job pushes an automated Google Scholar refresh, run this in
the development checkout before starting new work:

```bash
git pull --ff-only
```

## Manual Production Run

From the iCloud production checkout, a manual production-equivalent run is:

```bash
cd "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Documents/CV"
CV_PUSH=1 /opt/local/bin/bash ./CV.sh
```

Use `CV_PUSH=0` or omit `CV_PUSH` for a local render/commit test that should not
push.

## Failure Recovery

If the scheduled job fails:

1. Inspect `$HOME/Library/Logs/CV/cron.log` on M2Studio.
2. Check whether the iCloud production checkout is clean:

   ```bash
   git status --short --branch
   ```

3. If a render was interrupted and no process is running, remove a stale lock:

   ```bash
   rm -rf .cv-render.lock
   ```

4. Resolve any git conflict manually before re-running `CV.sh`.
5. Prefer `git pull --ff-only`; do not use merge pulls for routine production
   refreshes.

## Guardrails

- Do not edit the iCloud production checkout for design work.
- Do not run the weekly automation on more than one machine at a time.
- Do not push from cron unless `CV.sh` completed a successful render.
- Treat GitHub as the publication source of truth and the iCloud checkout as the
  scheduled-render convenience copy.
- Before making new CV edits in Development, pull the latest automated refresh
  from GitHub.
