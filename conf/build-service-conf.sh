#!/bin/sh

BASEDIR=$(dirname "$0")

if [ -z "$1" ]; then
    GRAPH_VERSION=data
else
    GRAPH_VERSION=$1
fi

if [ -z "$2" ]; then
    CURIE_MAP='https://archive.monarchinitiative.org/201910/translationtable/curie_map.yaml'
else
    CURIE_MAP=$2
fi

wget $CURIE_MAP -O $BASEDIR/curie_map.yaml
wget https://raw.githubusercontent.com/monarch-initiative/monarch-cypher-queries/master/src/main/cypher/dynamic-queries/cypher.yaml -O $BASEDIR/cypher.yaml

sed 's/^/    /' $BASEDIR/curie_map.yaml > $BASEDIR/curies_indented.yaml

sed -e '/INJECT_CURIES/ {r '"$BASEDIR/curies_indented.yaml"'
                         d}' $BASEDIR/$GRAPH_VERSION/monarchConfiguration.yaml.tmpl > $BASEDIR/monarchConfiguration.yaml.tmp

sed -e '/INJECT_QUERIES/ {r '"$BASEDIR/cypher.yaml"'
                          d}' $BASEDIR/monarchConfiguration.yaml.tmp > $BASEDIR/monarchConfiguration.yaml

rm ./conf/monarchConfiguration.yaml.tmp
