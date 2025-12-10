# CV

## Dec 10 2025

Updated workflow as GitHub can't support scraping GS data (403 error,
blocked).

Think this is as good as it can get. First, the repo does not get
rsynced to other machines so can't get clobbered that way. Second,
repo is on iCloud and locally kept tightly syncrochinzed with the
macOS Finder option "Keep Downloaded" enabled by going to the iCloud
folder "Documents", then control-clock and selece "Keep Downloaded".

This appears to permit _any_ machine to run a cron job and _all_
machines will be kept synchrnonized when they next connect to the
internet (which, unless travelling without a connection while updating
my CV ought to be essentially a close-to-zero probability occurrance).

A cron job on my home machine

```
0 0 * * * /opt/local/bin/bash -l -c 'source ~/.bashrc && cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/Documents/CV/ && /opt/local/bin/bash ./CV.sh > cron.log 2>&1'
```

executes in the local iCloud directory where the files are located
every midnight (could be weekly etc.), the updated files get pushed to
GitHub with a message

```
echo "Updated GS info: $(date +'%Y-%m-%d %H:%M:%S')"
```

If I update the main file index.qmd I push that separately with its
own message.

The file index.pdf gets copied to vitae.pdf which also gets pushed for
compatibility with existing links in McMaster Experts, my email sig
etc.

Last night it ran and appeared to execute properly.
