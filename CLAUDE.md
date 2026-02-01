# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a bookdown project for "Computational Thinking for Social Scientists" - an educational textbook teaching computational methods to social scientists. The book covers R programming, data wrangling, functional programming, APIs/web scraping, machine learning, and SQL.

## Build Commands

```bash
# Build all formats (HTML, PDF, EPUB)
bash _build.sh

# Or directly via R
Rscript -e "bookdown::render_book('.', output_format = 'all')"

# Build HTML only (faster)
Rscript -e "bookdown::render_book('.', output_format = 'bookdown::gitbook')"
```

Output is generated in the `docs/` directory. Open `docs/index.html` to preview.

## Project Structure

- `index.Rmd` - Book front matter and introduction
- `01_motivation.Rmd` through `08_big_data.Rmd` - Chapter content
- `_common.R` - Shared R configuration run before each chapter
- `_bookdown.yml` - Bookdown configuration
- `_output.yml` - Output format settings
- `docs/` - Generated output (HTML, PDF, EPUB)

## Key Configuration

- Each chapter runs in a fresh R session (`new_session: true`)
- Uses xelatex for PDF generation
- GitHub Pages deployment from `docs/` folder
- Two-space indentation for R code
- UTF-8 encoding required

## R Package Management

Chapters use `pacman::p_load()` for loading packages, which auto-installs missing packages. Core packages used throughout: tidyverse, bookdown, ggplot2, tidymodels.

## Deployment

Push to `main` branch triggers GitHub Actions workflow (`.github/workflows/bookdown.yml`) that:
1. Sets up R and installs dependencies
2. Builds the bookdown site
3. Deploys to GitHub Pages

No need to build locally before pushing - just commit your `.Rmd` changes and push.
