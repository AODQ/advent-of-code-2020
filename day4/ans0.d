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
    Input("day4/inp0.txt")
      .map!(x => x.length == 0 ? "$" : x)
      .join(" ")
      .split("$").map!(x => x.split(" ").filter!(x => x.length > 4))
  ;

  { // sol0
    int validPassports = 0;
    foreach (passport; range) {
      bool[string] hasFields;
      foreach (field; passport) {
        hasFields[field[0..3]] = true;
      }

      validPassports +=
          ("byr" in hasFields)
       && ("iyr" in hasFields)
       && ("eyr" in hasFields)
       && ("hgt" in hasFields)
       && ("hcl" in hasFields)
       && ("ecl" in hasFields)
       && ("pid" in hasFields)
      ;
    }
    validPassports.writeln;
  }

  { // sol1
    int validPassports = 0;
    foreach (passport; range) {
      string[string] hasFields;
      foreach (field; passport) {
        hasFields[field[0..3]] = field.split(":")[1];
      }

      bool cByr(string field) {
        auto x = field.to!int;
        return x >= 1920 && x <= 2002;
      }

      bool cIyr(string field) {
        auto x = field.to!int;
        return x >= 2010 && x <= 2020;
      }

      bool cEyr(string field) {
        auto x = field.to!int;
        return x >= 2020 && x <= 2030;
      }
      bool cHgt(string field) {
        if (field.length < 4) return false;
        auto x = field[0..$-2].to!int;
        if (field[$-2..$] == "in") return x >= 59 && x <= 76;
        if (field[$-2..$] == "cm") return x >= 150 && x <= 193;
        return false;
      }
      bool cHcl(string field) {
        if (field[0] != '#') return false;
        if (field.length != 7) return false;
        foreach (f; field[1..$]) {
          if (
              (f >= '0' && f <= '9')
           || (f >= 'A' && f <= 'F')
           || (f >= 'a' && f <= 'f')
          ) {
            continue;
          }
          return false;
        }

        return true;
      }

      bool cEcl(string field) {
        return
            field == "amb"
         || field == "blu"
         || field == "brn"
         || field == "gry"
         || field == "grn"
         || field == "hzl"
         || field == "oth"
        ;
      }

      bool cPid(string field) {
        if (field.length != 9) return false;
        foreach (f; field) {
          if (f < '0' || f > '9') return false;
        }
        return true;
      }

      validPassports +=
          ("byr" in hasFields ? cByr(hasFields["byr"]) : false)
       && ("iyr" in hasFields ? cIyr(hasFields["iyr"]) : false)
       && ("eyr" in hasFields ? cEyr(hasFields["eyr"]) : false)
       && ("hgt" in hasFields ? cHgt(hasFields["hgt"]) : false)
       && ("hcl" in hasFields ? cHcl(hasFields["hcl"]) : false)
       && ("ecl" in hasFields ? cEcl(hasFields["ecl"]) : false)
       && ("pid" in hasFields ? cPid(hasFields["pid"]) : false)
      ;
    }
    validPassports.writeln;
  }
}
