# Running Statistical Tests

This repository contains scripts to assist with installing and using various 
statistical test suites.

To install dieharder on Ubuntu or Debian, run:
```bash
sudo apt-get install -y dieharder
```

`scripts/build_*.sh` installs the `ent`, `testu01`, and `practrand` randomness tests.

To run the tests, move the data file into a folder, then run
`path/to/run_*.sh [filename]` inside that folder. This will populate the
folder with the test results.

## How to Cite
If you use `random_test` in your research, please cite the accompanying [paper](https://doi.org/10.3390/e26121053):

```
@article{foreman2024statistical,
  title={Statistical testing of random number generators and their improvement using randomness extraction},
  author={Foreman, Cameron and Yeung, Richie and Curchod, Florian J},
  journal={Entropy},
  volume={26},
  number={12},
  pages={1053},
  year={2024},
  publisher={Multidisciplinary Digital Publishing Institute}
  doi={https://doi.org/10.3390/e26121053}
}
```
