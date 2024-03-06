# Package

version     = "0.2.1"
author      = "Mark Spanbroek"
description = "Monocypher"
license     = "MIT"

srcDir        = "src"
skipDirs =  @["tests"]

installExt = @["nim", "c", "h"]
# Dependencies

requires "nim >= 1.2.0"

task pull, "pull monocypher":
  exec "nim c src/cImports.nim"

taskRequires "pull", "nimterop >= 0.6.13 & < 0.7.0"

# Test dependencies
when NimMajor >= 2:
  taskRequires "test", "sysrandom >= 1.1.0 & < 2.0.0"
else:
  requires "sysrandom >= 1.1.0 & < 2.0.0"
