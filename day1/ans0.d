#!/usr/bin/env rdmd

import std.algorithm;
import std.conv;
import std.file;
import std.file;
import std.range;
import std.stdio;

auto Input(string t) {
  string[] buffer;
  foreach (line; File(t).byLine())
    buffer ~= to!string(line);
  return buffer;
}

void main() {
  auto range = Input("day1/inp0.txt").map!(x => x.to!int).enumerate;

  // -- sol 0
  foreach (itA, a; range)
  foreach (itB, b; range[itA+1..$]) {
    if (a + b == 2020) {
      writefln("%s + %s = %s {%s}", a, b, a+b, a*b);
      break;
    }
  }

  // -- sol 1
  foreach (itA, a; range)
  foreach (itB, b; range[itA+1..$])
  foreach (itC, c; range[itB+1..$]) {
    if (a + b + c == 2020) {
      writefln("%s + %s + %s = %s {%s}", a, b, c, a+b+c, a*b*c);
      break;
    }
  }
}
