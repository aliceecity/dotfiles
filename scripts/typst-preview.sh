#!/bin/sh

firefox -new-tab /tmp/typstpreview.pdf &
typst watch "$1" /tmp/typstpreview.pdf >& /dev/null 
