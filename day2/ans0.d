#!/usr/bin/env rdmd

import std.ascii, std.algorithm, std.conv, std.file, std.range, std.stdio;

auto Input(string t) {
  string[] buffer;
  foreach (line; File(t).byLine())
    buffer ~= to!string(line);
  return buffer;
}

struct Pw {
  int min, max;
  char letter; string pass;

  this(string[] n) {
    min = n[0].split("-")[0].to!int, max = n[0].split("-")[1].to!int;
    letter = n[1][0];
    pass = n[2];
  }
};

void main() {
  auto range =
    Input("day2/inp0.txt")
      .map!(x => Pw(x.split!isWhite))
  ;

  // -- sol 0
  range
    .filter!(x => (x.pass.count(x.letter)) <= x.max)
    .filter!(x => (x.pass.count(x.letter)) >= x.min)
    .walkLength.writeln
  ;

  // -- sol 1
  range
    .filter!(x =>
        (x.pass.length >= x.max && x.pass[x.max-1] == x.letter)
      ^ (x.pass[x.min-1] == x.letter)
    )
    .walkLength.writeln
  ;
}
