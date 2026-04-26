## Test environments
* local Linux (Ubuntu 22.04), R 4.5.3
* GitHub Actions (Ubuntu, macOS, Windows)
* win-builder (R-devel, R-release)

## R CMD check results
0 errors | 1 warning | 0 notes

* Warning:
  "OS reports request to set locale to 'en_US.UTF-8' cannot be honored"

  This warning originates from the check environment or a dependency,
  not from the package itself. It is commonly observed on systems where
  this locale is unavailable and does not affect package functionality.

## Comments
Initial submission.
