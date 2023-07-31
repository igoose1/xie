---
title: "Batch PDF Editing"
slug: "pdf"
date: 2023-07-31T21:54:52+07:00
tags:
 - code
---

I needed to do batch operations with images and get a merged PDF output. Desiring to
minimize a number of tools, at the end I've done all processing with ImageMagick and
Ghostscript. Zsh and GNU parallel were also my friends.

#### Convert and Chop 4 sides

```sh
convert input.png -crop +300+300 -crop -300-300 output.pdf
```

#### Convert and Rotate

```sh
convert input.png -rotate -90 -page A4 output.pdf
```

#### Convert many files in parallel

```sh
find . -name '*.jpg' | parallel convert {} {.}.pdf
```

#### Merge and optimize

```sh
gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -dPDFSETTINGS=/ebook -sOutputFile=merged.pdf \
	one.pdf two.pdf three.pdf
```

Result file will be optimized because of `-dPDFSETTINGS=/ebook`.
