# nuclei-templates

![Templates](https://img.shields.io/badge/engines-nuclei%20%7C%20xray-blue)
![License](https://img.shields.io/badge/license-various%20upstream-lightgrey)
![Authorized use only](https://img.shields.io/badge/use-authorized%20testing%20only-red)

A curated mirror of community-contributed [nuclei](https://github.com/projectdiscovery/nuclei)
and [xray](https://github.com/chaitin/xray) templates, aggregated via
[cent](https://github.com/xm1k3/cent) from many upstream repositories and
re-published here for convenient consumption.

## Credits

Every template in this repository was written by someone else. Huge thanks to
all upstream authors, the original `author:` field is preserved in each YAML.
The contributing repositories are listed in `cent.yaml` upstream. If you find
your work here and want it removed, open an issue and it will be dropped on
the next sync.

Special thanks to [@serialstream0](https://github.com/serialstream0) for
reporting hardcoded OOB callback URLs (including ones embedded in hex-encoded
payloads). Those templates have been sanitized or removed, and the sync
pipeline now scrubs the same patterns on every run so they cannot reappear
from upstream.

## Layout

The tree follows [projectdiscovery/nuclei-templates](https://github.com/projectdiscovery/nuclei-templates):
one top-level directory per protocol, then a category, and CVE templates are
grouped by year.

```
http/cves/<year>/        http/exposed-panels/     http/technologies/
http/default-logins/     http/exposures/          http/misconfiguration/
http/takeovers/          http/vulnerabilities/    http/osint/ ...
network/  dns/  file/  ssl/  headless/  javascript/  code/  cloud/  dast/
workflows/
xray/                    # xray-poc dialect (top-level `rules:`), NOT loadable by nuclei
unclassified/            # no recognizable protocol block
```

Templates are placed by their protocol block, CVE id (filename or `id:`) and
`tags:`. Names carry cent's dedup suffixes (`_1`, `_2`, md5 hash) when several
upstream repos ship a template with the same file name.

## Usage

```bash
# All HTTP templates
nuclei -t http/ -u https://target

# Only CVEs from one year
nuclei -t http/cves/2024/ -u https://target

# xray templates must be loaded by xray, not nuclei
xray webscan --plugins phantasm --poc 'xray/*.yaml' --url https://target
```

## Caveats

- A subset of legacy templates (top-level `requests:`) references a hardcoded
  wordlist path `/home/mahmoud/Wordlist/AllSubdomains.txt` for subdomain
  fuzzing. Replace with your own wordlist before running, or skip them.
- OOB callback URLs have been rewritten to nuclei's built-in
  `{{interactsh-url}}` placeholder so payloads do not leak data to
  third-party collaborator instances.

## Don't be evil

These templates are for **authorized** security testing only: your own
infrastructure, scope explicitly granted by the asset owner, CTFs, or bug
bounty programs where you are within scope. Running them against systems you
do not own or have permission to test is illegal in most jurisdictions and
unkind everywhere. Respect rate limits. Respect humans on the other end.

## Sync

This mirror is updated automatically.
