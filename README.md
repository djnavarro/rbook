
<!-- README.md is generated from README.Rmd. Please edit that file -->
Learning statistics with R
==========================

This repository contains all the source materials for *Learning Statistics with R*.

There are two versions of the content, the `original` version (LSR v0.6) written in LaTeX and the `bookdown` adaptation (LSR v0.6.1). The two versions are kept in distinct folders to ensure they share no dependencies.

Bookdown
--------

Add notes her

Original
--------

Add notes here

Docs
----

The `blogdown` directory contains the entire blogdown site. Like any blogdown site, the generated site appears in the `blogdown/public` subdirectory, which is (deliberately) ignored using the `.gitignore` file. GitHub pages deploys the site from the `docs` directory; to publish the site, simply copy the entire contents of `blogdown/public` to `docs` and then push to GitHub.

The reason for setting it up this way is twofold. First, blogdown is quite insistent that the static site be located in the "public" folder, and GitHub is equally insistent on "docs", so this is just a necessity. Second, it also doubles as a convenient way to generate drafts locally (within `blogdown/public`) and then copy to `docs` when you're ready to publish. (Yes you could create a git branch for drafts, but that seems more complex than necessary).
