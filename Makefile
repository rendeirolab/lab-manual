all: html pdf

requirements:
	sudo apt install \
		pandoc \
		wkhtmltopdf

html:
	pandoc \
		--toc \
		--metadata-file=metadata.yaml \
		--css style.css \
		--pdf-engine pdflatex \
		-s README.md manual/*.md \
		-o rendeiro-lab_manual.html

pdf:
	# --css https://raw.githubusercontent.com/simov/markdown-viewer/master/themes/github.css
	pandoc \
		--toc \
		-f gfm -t html5 \
		--metadata-file=metadata.yaml \
		--css pdf.css \
		--pdf-engine=wkhtmltopdf \
  		--pdf-engine-opt='--enable-local-file-access' \
		-s README.md manual/*.md \
		-o rendeiro-lab_manual.pdf
