#!/usr/bin/env bash

sources=( "lively.lang" "lively.bindings" "lively.ast" "lively.source-transform" "lively.classes" "lively.vm" "lively.modules" "mocha-es6" "lively.resources" "lively.storage" "lively-system-interface" "lively.installer" "lively.serializer2" "lively.graphics" "lively.morphic" "lively.mirror" "lively.sync" "lively.notifications" "lively.changesets" "lively.shell" "lively.server" "lively.2lively" "lively.user" "lively.git" "lively.traits" )

for i in "${sources[@]}"
do
  npm rm -g $i
  rm -rf $i/node_modules;
done

