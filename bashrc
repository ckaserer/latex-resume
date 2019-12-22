#!/bin/bash

readonly LATEX_RESUME_SCRIPT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# latex-resume
function latex-resume () {
  local command="docker run --rm -i --net=none -v "${LATEX_RESUME_SCRIPT_DIR}":/data ckaserer/latex:full lualatex cv.tex"
  echo "+ ${command} $@" && ${command} $@
}
readonly -f latex-resume
[ "$?" -eq "0" ] || return $?
