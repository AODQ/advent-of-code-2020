#!/usr/bin/env rdmd

import std.ascii, std.algorithm, std.conv, std.file, std.range, std.stdio;

auto Input(string t) {
  string[] buffer;
  foreach (line; File(t).byLine())
    buffer ~= to!string(line);
  return buffer;
}

void main() {
  auto range = Input("day5/inp0.txt");

  uint maxId = 0;
  uint[] ids;
  foreach (field; range) {
    uint y = 0;
    uint det = 128;
    for (uint i = 0; i < 7; ++ i) {
      det >>= 1;
      y += field[i] == 'B' ? det : 0;
    }

    y *= 8;
    det = 8;
    for (uint i = 0; i < 3; ++ i) {
      det >>= 1;
      y += field[7+i] == 'R' ? det : 0;
    }

    maxId = max(y, maxId);
    ids ~= y;
  }
  maxId.writeln;

  auto idx = ids.sort();

  for (uint i = idx[0]; i < idx[$-1]; ++ i) {
    for (uint j = 1; j < idx.length-1; ++ j) {
      if (idx[j] == i-1 && idx[j+1] == i+1)
        i.writeln;
    }
  }
}
