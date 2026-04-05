# `R nfcore_utils`: a R package to join Nextflow and R

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
mamba create -n env_r_nfcore_utils conda-forge::r-nfcore_utils
mamba activate env_r_nfcore_utils
```

### In R from Github

```R
if (!require("remotes", quietly = TRUE))
    install.packages("remotes")

remotes::install_github("nf-core/r-nf-core-utils",
    build_vignettes=TRUE
)
```

### In R from [CRAN](https://cran.r-project.org/web/packages/nfcore_utils/index.html)

```R
install.packages("nfcore_utils")
```

## Usage example in a Nextflow template

Here is a simple example that show how to use the package in a Nextflow process template.

```R
library(nfcore.utils)

################################################
## INPUTS PARSING                             ##
################################################

# First define the options list you need
opt <- list(
  output_prefix = '${prefix}',
  input_file = '${input}',
  output_folder = '${output_folder}',
  value_integer = 1234, # Can be set to a default value
  value_double = 0.1234,
  seed = NULL # Will be set at the start of the script
)

# Call main function with validation checks
opt_valid <- process_inputs(
  opt,
  args = '${args}', # Args provided as --key value, will replace default value
  keys_to_nullify = c("output_prefix"),
  expected_files = c("input_file"),
  expected_folders = c("output_folder"),
  expected_double = c("value_double"),
  expected_integer = c("value_integer"),
  required_opts = c("input_file", "output_folder")
)

################################################
## MAIN SCRIPT                                ##
################################################

# Write here your script and outputs

################################################
## VERSIONS and LOG EMISSION                  ##
################################################

process_end(
  packages = list( # Write additionaly used packages
    "r-stats" = "stats" # conda package name = r package name
  ),
  task_name = '"${task.process}":',
  outdir = "."
)
```

## Documentation, News and Citation

To view documentation start R and enter:

```R
library(nfcore.utils)
help(package="nfcore.utils")

# Or to view the vignettes
browseVignettes("nfcore.utils")

# Or to see the news
utils::news(package="nfcore.utils")

# Or to cite nfcore.utils
citation("nfcore.utils")
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
