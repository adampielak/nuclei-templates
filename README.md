# nuclei-templates

Curated nuclei templates aggregated via [cent](https://github.com/xm1k3/cent) and sorted by first-letter buckets (A-Z / 0-9 / misc).

## Last sync

- Date: 2026-05-27 19:43 UTC
- Templates added/updated this run: **248014**
- Junk files removed this run: **0**
- Total templates in repo: **937975**

## Layout

```
A/  apache-*, atlassian-*, ...
B/  ...
C/  CVE-*, cisco-*, ...
...
Z/
0/ 1/ ... 9/
misc/   non-alphanumeric leading char
```

## Pipeline

1. `cent -p /root/cent-nuclei-templates --config /root/.cent.yaml -C`
2. Collect `*.yaml`/`*.yml` into `/root/bnuck/`
3. Sort by first letter into bucket dirs in this repo
4. Drop junk: LICENSE LICENSE.libyaml NOTICE README.md go.mod xss-disable-mustache-escape.YAML yaml.png yamlint.sh yamllint-github-action-2.1.0
5. Commit & push to GitHub

Automated by `remote-sync.sh` (OOM-guarded, swap fallback).
