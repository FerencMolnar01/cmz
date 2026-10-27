# cmz

A lossless file compressor for Windows. It also shrinks files that are already compressed: JPEG photos,
MP3 music, Office documents, PDFs, zip and gzip files, and FITS astronomy data. Every file comes back
byte for byte.

**Public beta, free to use until 31 December 2026.** Unpacking stays free without a time limit.

- Website and measurements: https://ferencmolnar01.github.io/cmz/
- Download: [cmz-1.0-beta4.exe](https://github.com/FerencMolnar01/cmz/releases/download/v1.0-beta4/cmz-1.0-beta4.exe) · [all releases](https://github.com/FerencMolnar01/cmz/releases)
- Feedback: fmolnar.no1@gmail.com

cmz is a joint work: Ferenc Molnár built it together with Claude, an AI model made by Anthropic. Ferenc set the
goals and decided what stays and what goes; Claude wrote much of the code and ran the measurements.

This repository holds the website and the released program. The source code is not public.

## Getting started

1. Download `cmz-1.0-beta4.exe` from the [releases](https://github.com/FerencMolnar01/cmz/releases). During the beta the program is not code-signed, so
   Windows SmartScreen may warn about it: choose “More info”, then “Run anyway”.
2. On first start cmz offers to install itself for your user account (no administrator rights needed). It adds
   a Start menu entry, a “Compress with cmz” item to the Explorer right-click menu, and opens `.cmz` files on
   double-click. Windows Settings → Apps removes it again.
3. Each file becomes its own `.cmz` next to the original. cmz never overwrites or deletes anything.

To check your download, compare its SHA-256 checksum (PowerShell: `Get-FileHash cmz-1.0-beta4.exe`) with the one
given in the release notes.

Requirements: 64-bit Windows 10 or 11.

## Beta terms

- cmz 1.0 beta may be used free of charge, privately and at work, until 31 December 2026. Unpacking `.cmz` files
  stays free after that date, and later versions of cmz will open every file made with the beta.
- You may pass on the unmodified download. Please do not modify, resell or repackage it.
- The beta is provided “as is”, without warranty of any kind. Keep your original files until you have checked
  that the unpacked result is what you need. To the extent permitted by law, the author is not liable for any
  damage or data loss arising from its use.

## Third-party notices

cmz contains code derived from CFITSIO (the Rice compression routines in `ricecomp.c`, originally written by
Richard White, STScI), which cmz uses to rebuild Rice-compressed FITS data byte for byte. The CFITSIO licence
requires the following notice:

```
Copyright (Unpublished--all rights reserved under the copyright laws of
the United States), U.S. Government as represented by the Administrator
of the National Aeronautics and Space Administration.  No copyright is
claimed in the United States under Title 17, U.S. Code.

Permission to freely use, copy, modify, and distribute this software
and its documentation without fee is hereby granted, provided that this
copyright notice and disclaimer of warranty appears in all copies.

DISCLAIMER:

THE SOFTWARE IS PROVIDED 'AS IS' WITHOUT ANY WARRANTY OF ANY KIND,
EITHER EXPRESSED, IMPLIED, OR STATUTORY, INCLUDING, BUT NOT LIMITED TO,
ANY WARRANTY THAT THE SOFTWARE WILL CONFORM TO SPECIFICATIONS, ANY
IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, AND FREEDOM FROM INFRINGEMENT, AND ANY WARRANTY THAT THE
DOCUMENTATION WILL CONFORM TO THE SOFTWARE, OR ANY WARRANTY THAT THE
SOFTWARE WILL BE ERROR FREE.  IN NO EVENT SHALL NASA BE LIABLE FOR ANY
DAMAGES, INCLUDING, BUT NOT LIMITED TO, DIRECT, INDIRECT, SPECIAL OR
CONSEQUENTIAL DAMAGES, ARISING OUT OF, RESULTING FROM, OR IN ANY WAY
CONNECTED WITH THIS SOFTWARE, WHETHER OR NOT BASED UPON WARRANTY,
CONTRACT, TORT , OR OTHERWISE, WHETHER OR NOT INJURY WAS SUSTAINED BY
PERSONS OR PROPERTY OR OTHERWISE, AND WHETHER OR NOT LOSS WAS SUSTAINED
FROM, OR AROSE OUT OF THE RESULTS OF, OR USE OF, THE SOFTWARE OR
SERVICES PROVIDED HEREUNDER.
```

© 2026 Ferenc Molnár · Made in Hungary
