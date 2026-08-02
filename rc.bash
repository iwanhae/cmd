#!/bin/bash

SCRIPT_DIR=$HOME/git/cmd
export PATH="$SCRIPT_DIR/bin:$SCRIPT_DIR/bin_local:$PATH"

export PGUSER=wan
export PGDATABASE=postgres
export PGHOST=127.0.0.1
