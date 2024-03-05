# Package

version     = "0.2.1"
author      = "Mark Spanbroek"
description = "Monocypher"
license     = "MIT"

# Dependencies

requires "nim >= 1.2.0"
requires "nimterop >= 0.6.13 & < 0.7.0"

# Test dependencies
when NimMajor >= 2:
  taskRequires "test", "sysrandom >= 1.1.0 & < 2.0.0"
else:
  requires "sysrandom >= 1.1.0 & < 2.0.0"
