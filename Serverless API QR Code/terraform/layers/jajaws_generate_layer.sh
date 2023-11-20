#!/bin/sh

mkdir python
python3 -m pip install segno --no-user -t ./segno_tmp/
cd ./segno_tmp/
mv segno/ segno-*.dist-info/  ../python/
cd ..
rm -r segno_tmp/
zip -r jajaws_qr_code_layer.zip ./python/
rm -r python