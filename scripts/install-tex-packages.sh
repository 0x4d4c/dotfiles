#!/bin/bash -eu

TEXMFHOME="${HOME}/.local/share/texmf"

mkdir -p "${TEXMFHOME}/tex/latex"

# pdfpc-latex-notes
repo_path="${dots}/repos/pdfpc-latex-notes"
if [ -d "${repo_path}" ]; then
  git -C "${repo_path}" pull --quiet
else
  git clone https://github.com/cebe/pdfpc-latex-notes.git "${repo_path}"
fi
mkdir -p "${TEXMFHOME}/tex/latex/pdfpc-latex-notes"
cp "${repo_path}/pdfpcnotes.sty" "${TEXMFHOME}/tex/latex/pdfpc-latex-notes/"
