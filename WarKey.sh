#!/bin/bash
tar -zvvcf WarKey-$1.tar.gz WarKey.exe
tar -jvvcf WarKey-$1.tar.bz2 WarKey.exe
zip -9 WarKey-$1.zip WarKey.exe
tar -zvvcf WarKey-$1-source.tar.gz WarKey.au3
tar -jvvcf WarKey-$1-source.tar.bz2 WarKey.au3
zip -9 WarKey-$1-source.zip WarKey.au3
mv WarKey.exe WarKey-$1.exe
mv WarKey.au3 WarKey-$1.au3
