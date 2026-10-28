#!/usr/bin/env bash
# Downloads the cmz public test files from their original publishers and checks each one's SHA-256.
# Nothing is hosted by us: every file comes from the address listed below.
# Usage:  bash get-test-files.sh [folder]      (default folder: cmz-test-files)
# Needs curl, sha256sum (or shasum) and unzip (or bsdtar). List: https://ferencmolnar01.github.io/cmz/test-files.html
set -u
DIR=${1:-cmz-test-files}
UA='cmz-test-files/1 (+https://ferencmolnar01.github.io/cmz/test-files.html)'
mkdir -p "$DIR" || exit 1
sha() { if command -v sha256sum > /dev/null; then sha256sum "$1" | cut -c1-64; else shasum -a 256 "$1" | cut -c1-64; fi; }
ok=0; n=0
while IFS='|' read -r id name size hash url note; do
  n=$((n+1)); p="$DIR/$name"
  if [ -f "$p" ] && [ "$(sha "$p")" = "$hash" ]; then echo "$id  $name  OK (already here)"; ok=$((ok+1)); continue; fi
  case "$note" in
    zip-entry=*)  # the file sits inside a larger zip: fetch it, take out the one entry, delete the zip
      e=${note#zip-entry=}; z="$DIR/_download.zip"
      curl -fsSL --retry 3 -A "$UA" -o "$z" "$url" || { echo "$id  $name  DOWNLOAD FAILED"; continue; }
      if command -v unzip > /dev/null; then unzip -p "$z" "$e" "*/$e" > "$p" 2> /dev/null; else bsdtar -xOf "$z" "$e" > "$p"; fi
      rm -f "$z" ;;
    *) curl -fsSL --retry 3 -A "$UA" -o "$p" "$url" || { echo "$id  $name  DOWNLOAD FAILED"; continue; } ;;
  esac
  case "$note" in
    dss-date=*)  # the DSS server writes the download date into the FITS header; put back the date of the measured copy
      [ "$(dd if="$p" bs=1 skip=480 count=11 2> /dev/null)" = "DATE    = '" ] &&
        printf '%s' "${note#dss-date=}" | dd of="$p" bs=1 seek=491 conv=notrunc 2> /dev/null ;;
  esac
  if [ "$(sha "$p")" = "$hash" ]; then echo "$id  $name  OK"; ok=$((ok+1))
  else echo "$id  $name  DIFFERENT: $(wc -c < "$p" | tr -d ' ') bytes, expected $size (the publisher may have changed the file)"; fi
done << 'LIST'
01|war_and_peace.txt|3359610|2d5bb2ad5f422765e714617e21fa31bbaf8958aa79682c86fca6660fcc5d1b2b|https://www.gutenberg.org/cache/epub/2600/pg2600.txt|
02|az_arany_ember_1.txt|555710|d2118a7ba84c0433165e0b233221b08e2b18d589452f92b282ebedaf55bcabe8|https://www.gutenberg.org/cache/epub/56591/pg56591.txt|
03|moby_dick.epub|814023|1bc88e79ef7cf9d5325abe0071e6302265b708df56d3af07db124c81e84197f6|https://www.gutenberg.org/cache/epub/2701/pg2701-images-3.epub|
04|irs_f1040.pdf|220237|3d31c226df0d189ced80e039d01cf0f8820c1019681a0f0ca6264de277b7e982|https://www.irs.gov/pub/irs-pdf/f1040.pdf|
05|irs_p17.pdf|3088632|2d2381d62c7c77ed4b64b83ac23c28ed85b7c8304eb580c09bd9fd660be0840b|https://www.irs.gov/pub/irs-pdf/p17.pdf|
06|onlyoffice_sample.pdf|1329569|52a4c59f9858efa9bbe6740bbacd1005f09c33db0aae11e39ff730f00a379bb6|https://raw.githubusercontent.com/ONLYOFFICE/document-templates/0a52fb76fa53fddf7d70da28878537cde3d29421/sample/sample.pdf|
07|onlyoffice_sample.docx|410390|d678383aee1f2deb84808353fcf77e1ffd865495aa5079ff9bca90a24a9ca0f5|https://raw.githubusercontent.com/ONLYOFFICE/document-templates/0a52fb76fa53fddf7d70da28878537cde3d29421/sample/sample.docx|
08|onlyoffice_sample.xlsx|76825|3d8a1ab5d84e5644995bd3384dd6c567ceeaacade34cf90cabd9d0bc430a5e41|https://raw.githubusercontent.com/ONLYOFFICE/document-templates/0a52fb76fa53fddf7d70da28878537cde3d29421/sample/sample.xlsx|
09|onlyoffice_sample.pptx|87354|524d1144395e5889f217ee9f84c7331433e2ac99735d933f82390ca9a49dcb5d|https://raw.githubusercontent.com/ONLYOFFICE/document-templates/0a52fb76fa53fddf7d70da28878537cde3d29421/sample/sample.pptx|
10|nasa_as11-40-5874.jpg|2236993|9c93e64991da8c71352e8290f4faa57f1239bd87d74f956a8489a93d7201c8bb|https://images-assets.nasa.gov/image/as11-40-5874/as11-40-5874~orig.jpg|
11|kodim23.png|557596|e3111a2fd4da24af15d6459ef9eacfe54106b38e27b4a21821b75c3f5d2d5baf|http://r0k.us/graphics/kodak/kodak/kodim23.png|
12|sipi_4.2.03.tiff|786572|3f590b52279fb59b81906f1e928ae713a5357b1afc1a2017a103adb563fb4494|https://sipi.usc.edu/database/download.php?vol=misc&img=4.2.03|
13|putty_0.83_w64.exe|1709672|16cbe40fb24ce2d422afddb5a90a5801ced32ef52c22c2fc77b25a90837f28ad|https://the.earth.li/~sgtatham/putty/0.83/w64/putty.exe|
14|curl-8.11.1.tar.gz|4169067|a889ac9dbba3644271bd9d1302b5c22a088893719b72be3487bc3d401e5c4e80|https://curl.se/download/curl-8.11.1.tar.gz|
15|sqlite-amalgamation-3470200.zip|2811504|aa73d8748095808471deaa8e6f34aa700e37f2f787f4425744f53fdd15a89c40|https://www.sqlite.org/2024/sqlite-amalgamation-3470200.zip|
16|chinook.sqlite|1067008|bdf635be69850bd3be09c9a2dbeef7ddfb80036bd3ef3381383cd03b61e4a61a|https://github.com/lerocha/chinook-database/releases/download/v1.4.5/Chinook_Sqlite.sqlite|
17|airport-codes.csv|8822393|e001037619f2cd5a2d3afe84ebbf83fc7b803edab6cc74f638342f1a078d9b43|https://raw.githubusercontent.com/datasets/airport-codes/0527400233e4c19b265b589689328d1a10ceaaa8/data/airport-codes.csv|
18|countries.json|1398004|0d92fb23b43ae080bd439f5dc5d61a8845395fdd0af1479b433c59fe079bd6fd|https://raw.githubusercontent.com/mledoze/countries/6031f5df137c41c76d180c55a0782185ae3ed05b/countries.json|
19|apache_2k.log|171239|c7efa3eb686e3a96bd2f8f4457b2a7887e9cf2f3649327f1b4e87af841363ce8|https://raw.githubusercontent.com/logpai/loghub/374038faa4ca122dd7ca0730372c0b78f76f8597/Apache/Apache_2k.log|
20|bach_march_in_d.wav|9961516|9d87a1d1183496452bd9b40e37a255ece7378821dabd8ae5a7b65dbe4f3dec2d|https://upload.wikimedia.org/wikipedia/commons/d/d3/Bach%2C_JS_-_March_in_D_%28Piano_Performance_by_eld%C3%BCendes%C3%BCarez%29.wav|
21|usafa_band_symphony3.mp3|7801849|c5f09c9ffe52762e6b556d79612ba1e07a3dacd57295e4146a09525807b755ba|https://upload.wikimedia.org/wikipedia/commons/d/da/Symphony_No._3_in_C_Minor_-_II._Maestoso_-_Stellar_Brass_-_United_States_Air_Force_Academy_Band.mp3|
22|librivox_pride_01_64kb.mp3|2625429|aa7339960c90bed4c57ffe144c96b7a8ef4de482d6505d19906bb50248fe6f0c|https://archive.org/download/prideandprejudice_1005_librivox/prideandprejudice_01_austen_64kb.mp3|
23|kplr011904151-2009131105131_llc.fits|77760|d14d76faf0bb4a245c1a728c5fbe3831c084570c0fed253b46d1b9b28837a337|https://archive.stsci.edu/missions/kepler/lightcurves/0119/011904151/kplr011904151-2009131105131_llc.fits|
24|dss_orion_10arcmin.fits|766080|025b6059ea05e40051aa43c42191769cfc33ca5fc82387d4ce11a14af2f64c79|https://archive.stsci.edu/cgi-bin/dss_search?v=poss2ukstu_red&r=83.82&d=-5.39&e=J2000&h=10&w=10&f=fits|dss-date=2026-10-27
25|AIA20240101_0000_0171.fits|1258560|7bd72d03d357cd95a949b5d4294f7acfc251dd5436bac71d374690605f07333a|http://jsoc.stanford.edu/data/aia/synoptic/2024/01/01/H0000/AIA20240101_0000_0171.fits|
26|H-H1_GWOSC_4KHZ_R1-1126259447-32.hdf5|1040781|c5ea87beced5094b56b4d694f3a36e6d59f74d3a46e546b980a6a199d1f252a9|https://gwosc.org/eventapi/html/GWTC-1-confident/GW150914/v3/H-H1_GWOSC_4KHZ_R1-1126259447-32.hdf5|
27|sao|7251944|c2d0ea2cc59d4c21b7fe43a71499342a00cbe530a1d5548770e91ecd6214adcc|https://sun.aei.polsl.pl//~sdeor/corpus/silesia.zip|zip-entry=sao
LIST
echo
echo "$ok of $n files match the measured copies. Folder: $DIR"
