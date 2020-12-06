#!/usr/bin/env rdmd

import std.ascii, std.algorithm, std.conv, std.file, std.range, std.stdio;

auto Input(string t) {
  string[] buffer;
  foreach (line; File(t).byLine())
    buffer ~= to!string(line);
  return buffer;
}

void main() {
  auto range = Input("day3/inp0.txt");

  { // -- sol 0
    int trees = 0;
    for (
      int idxX = 0, idxY = 0;
      idxY < range.length;
      idxX += 3, ++idxY
    ) {
      trees += range[idxY][idxX % $] == '#';
    }

    trees.writeln;
  }

  { // -- sol 1
    ulong treeMult = 1;
    foreach (offset; [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]) {
      ulong trees = 0;
      for (
        ulong idxX = 0, idxY = 0;
        idxY < range.length;
        idxX += offset[0], idxY += offset[1]
      ) {
        trees += range[idxY][idxX % $] == '#';
      }
      trees.writeln;
      treeMult *= trees;
    }

    treeMult.writeln;
  }
}
