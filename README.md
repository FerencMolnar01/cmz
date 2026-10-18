# cmz

A lossless file compressor for Windows. It also shrinks files that are already compressed: JPEG photos,
MP3 music, Office documents, PDFs, zip and gzip files, and FITS astronomy data. Every file comes back
byte for byte.

**Public beta, free to use until 31 December 2026.** Unpacking stays free without a time limit.

- Website and measurements: https://ferencmolnar01.github.io/cmz/
- Download: [Releases](https://github.com/FerencMolnar01/cmz/releases/latest)
- Feedback: fmolnar.no1@gmail.com

This repository holds the website and the released program. The source code is not public.

## Getting started

1. Download `cmz-1.0-beta.exe` from the latest release. During the beta the program is not code-signed, so
   Windows SmartScreen may warn about it: choose “More info”, then “Run anyway”.
2. On first start cmz offers to install itself for your user account (no administrator rights needed). It adds
   a Start menu entry, a “Compress with cmz” item to the Explorer right-click menu, and opens `.cmz` files on
   double-click. Windows Settings → Apps removes it again.
3. Each file becomes its own `.cmz` next to the original. cmz never overwrites or deletes anything.

To check your download, compare its SHA-256 checksum (PowerShell: `Get-FileHash cmz-1.0-beta.exe`) with the one
given in the release notes.

Requirements: 64-bit Windows 10 or 11.

## Beta terms

- cmz 1.0 beta may be used free of charge, privately and at work, until 31 December 2026. Unpacking `.cmz` files
  stays free after that date, and later versions of cmz will open every file made with the beta.
- You may pass on the unmodified download. Please do not modify, resell or repackage it.
- The beta is provided “as is”, without warranty of any kind. Keep your original files until you have checked
  that the unpacked result is what you need. To the extent permitted by law, the author is not liable for any
  damage or data loss arising from its use.

© 2026 Ferenc Molnár · Made in Hungary
