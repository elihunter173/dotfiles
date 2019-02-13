# System Configuration Files

This directory contains various, non-secret system files associated with my computer. These are not
managed by dotbot, as they shouldn't change regularly and would make dotbot require sudo, which I
don't want.

Included is `export.sh`, which is a simple shell script that copies system files to their
appropriate places. It does not do this dynamically and simply includes a list of hard-coded
locations.

## Getting Started

Run the included shell script as root.

```sh
sudo ./export.sh
```

## Authors

* Eli W. Hunter
