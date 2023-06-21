# Running Statistical Tests

This repository contains some scripts to help you install statistical tests.

To install dieharder on Ubuntu or Debian, run:
```bash
sudo apt-get install -y dieharder
```

`scripts/build_*.sh` installs the `ent`, `testu01`, and `practrand` randomness tests.

To run the tests, move the data file into a folder, then run
`path/to/run_*.sh [filename]` inside that folder. This will populate the
folder with the test results.
