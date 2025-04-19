#!/usr/bin/env bash
# _build.sh — minimal example
Rscript -e "bookdown::render_book('.', output_format = 'all')"
