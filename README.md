# `R nf-core-utlis`: a R package to join Nextflow and R

<!-- badges: start -->
  [![Release](https://img.shields.io/badge/release%20version-0.0.1-green.svg)](https://github.com/nf-core/nf-core-r-utils)
  [![codecov](https://codecov.io/gh/nf-core/nf-core-r-utils/graph/badge.svg?token=XXXXXXXXX)](https://codecov.io/gh/nf-core/nf-core-r-utils)
  ![install with conda-forge](https://img.shields.io/badge/install%20with-conda-forge-brightgreen.svg?style=flat)
<!-- badges: end -->

<table>
  <tr>
    <td style="width:75%; vertical-align:center;">
      This package is aimed to anyone wanting to use R script within Nextflow.
      Its aim is to provide function allowing to lin easily Nextflow parameters to the R logic.
      It also perform validity check on the variable passed to ensure proper execution.
    </td>
    <td style="width:25%; text-align:center; vertical-align:center;">
      <img src="https://github.com/nf-core/nf-core-r-utils/raw/devel/inst/figures/icon_nf-core_utils.png" style="max-height:200px;" />
    </td>
  </tr>
</table>

## Installation

### With conda-forge

```bash
mamba create -n env_nf_core_utils conda-forge::r-nf-core-utils
mamba activate env_nf_core_utils
```

### In R from Github

```R
if (!require("remotes", quietly = TRUE))
    install.packages("remotes")

remotes::install_github("nf-core/nf-core-r-utils",
    build_vignettes=TRUE
)
```

### In R from [CRAN](https://cran.r-project.org/web/packages/nf-core-utils/index.html)

```R
install.packages("nf-core-utils")
```

## Main functions

### Example

Here is a simple example that show how to represent a complex pedigree with a lot of different information.

```R
library(nf-core-utils)
```

## Documentation, News and Citation

To view documentation start R and enter:

```R
library(nf-core-utils)
help(package="nf-core-utils")

# Or to view the vignettes
browseVignettes("nf-core-utils")

# Or to see the news
utils::news(package="nf-core-utils")

# Or to cite Pedixplore
citation("nf-core-utils")
```

## Credits

R nf-core/utils was written by the nf-core community, with major contributions from [Louis Le Nézet](https://github.com/LouisLeNezet/), [XXXX](https://github.com/).

Additional contributors were [XXXXX](https://github.com/XXXXX).

## Contributions and Support

If you would like to contribute to this package, please see the [contributing guidelines](.github/CONTRIBUTING.md).

For further information or help, don't hesitate to get in touch on the [Slack `#nf-core-r-utils` channel](https://nfcore.slack.com/channels/nf-core-r-utils) (you can join with [this invite](https://nf-co.re/join/slack)).

## Citations

If you use R nf-core/utils for your analysis, please cite it using the `nf-core` publication as follows:

> **The nf-core framework for community-curated bioinformatics pipelines.**
>
> Philip Ewels, Alexander Peltzer, Sven Fillinger, Harshil Patel, Johannes Alneberg, Andreas Wilm, Maxime Ulysse Garcia, Paolo Di Tommaso & Sven Nahnsen.
>
> _Nat Biotechnol._ 2020 Feb 13. doi: [10.1038/s41587-020-0439-x](https://dx.doi.org/10.1038/s41587-020-0439-x).

An extensive list of references for the tools used by the pipeline can be found in the [`CITATIONS.md`](CITATIONS.md) file.
