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
all upstream authors — the original `author:` field is preserved in each YAML.
The contributing repositories are listed in `cent.yaml` upstream. If you find
your work here and want it removed, open an issue and it will be dropped on
the next sync.

Special thanks to [@serialstream0](https://github.com/serialstream0) for
reporting hardcoded OOB callback URLs (including ones embedded in hex-encoded
payloads) — those templates have been sanitized or removed, and the sync
pipeline now scrubs the same patterns on every run so they cannot reappear
from upstream.

## Layout

Templates are split by engine and version so users do not get compatibility
warnings from nuclei when loading the wrong dialect:

```
nuclei-v3/   # nuclei v3+ templates (top-level: http, code, javascript, flow, dns, ...)
nuclei-v2/   # legacy nuclei v2 templates (top-level: requests). Loadable by nuclei v3
             # but emits deprecation warnings.
xray/        # xray-poc dialect (top-level: rules). NOT compatible with nuclei.
```

Each tree is sharded by leading character of the filename (`A/`, `B/`, ..., `0/`, `1/`, `misc/`)
to keep directory sizes manageable.

## Usage

```bash
# Run only modern nuclei templates against a target
nuclei -t nuclei-v3/ -u https://target

# Include legacy v2 as well
nuclei -t nuclei-v3/ -t nuclei-v2/ -u https://target

# xray templates must be loaded by xray, not nuclei
xray webscan --plugins phantasm --poc 'xray/**/*.yaml' --url https://target
```

## Caveats

- A subset of templates (≈13.5k under `nuclei-v2/`) reference a hardcoded
  wordlist path `/home/mahmoud/Wordlist/AllSubdomains.txt` for subdomain
  fuzzing. Replace with your own wordlist before running, or skip them.
- OOB callback URLs have been rewritten to nuclei's built-in
  `{{interactsh-url}}` placeholder so payloads do not leak data to
  third-party collaborator instances.

## Don't be evil

These templates are for **authorized** security testing only — your own
infrastructure, scope explicitly granted by the asset owner, CTFs, or bug
bounty programs where you are within scope. Running them against systems you
do not own or have permission to test is illegal in most jurisdictions and
unkind everywhere. Respect rate limits. Respect humans on the other end.

## Sync

This mirror is regenerated automatically.
