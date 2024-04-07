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

## How to Cite
If you use `random_test` in your research, please cite the accompanying [paper](https://arxiv.org/abs/2403.18716):

```
@article{foreman2024statistical,
  title={Statistical testing of random number generators and their improvement using randomness extraction},
  author={Foreman, Cameron and Yeung, Richie and Curchod, Florian J},
  journal={arXiv preprint arXiv:2403.18716},
  year={2024}
}
```
