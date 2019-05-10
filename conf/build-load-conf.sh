#!/bin/sh

BASEDIR=$(dirname "$0")

if [ -z "$1" ]; then
    GRAPH_VERSION=data
else
    GRAPH_VERSION=$1
fi

sed -e '/MONARCH_GLOBALS/ {r '"$BASEDIR/monarch-load-global.yaml"'
                         d}' $BASEDIR/$GRAPH_VERSION/monarchLoadConfiguration.yaml.tmpl > $BASEDIR/monarchLoadConfiguration.yaml
