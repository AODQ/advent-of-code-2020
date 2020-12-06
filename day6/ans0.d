#!/usr/bin/env rdmd

import std.ascii, std.algorithm, std.conv, std.file, std.range, std.stdio;

auto Input(string t) {
  string[] buffer;
  foreach (line; File(t).byLine())
    buffer ~= to!string(line);
  return buffer;
}

void main() {
  auto range =
    Input("day6/inp0.txt")
      .map!(x => x.length == 0 ? "$" : x)
      .join(" ")
      .split("$").array
  ;

  range
    .map!(s => s.filter!(c => !c.isWhite).array.sort)
    .map!(x => x.uniq.walkLength).reduce!"a+b".writeln
  ;

  uint sum = 0;
  foreach (i; range) {
    auto len = i.split(" ").filter!(x => x != "").walkLength;
    sum +=
      i.filter!(a => !a.isWhite).array.sort
       .chunkBy!((a, b) => a == b)
       .filter!(a => a.walkLength == len).walkLength
    ;
  }
  sum.writeln;
}
