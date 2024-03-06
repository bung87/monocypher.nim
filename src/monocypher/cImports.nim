import nimterop/[build, cimport]
import os

const
  src = currentSourcePath.parentDir/"build"

static:
  gitPull("https://github.com/LoupVaillant/Monocypher.git", checkout = "3.1.2", outdir = src)

static:
  cCompile(src/"src"/"monocypher.c")

cImport(src/"src"/"monocypher.h")
