#!/usr/bin/env bash
source config.sh


## http://charles.lescampeurs.org/category/mac

brew install sphinx --mysql

## Start sphinx
searchd -c /usr/local/etc/sphinx.conf

## Stop sphinx
earchd -c /usr/local/etc/sphinx.conf --stop

## manage the index
indexer -c /usr/local/etc/sphinx.conf --rotate yourindex
indexer -c /usr/local/etc/sphinx.conf --rotate yourindex_delta
