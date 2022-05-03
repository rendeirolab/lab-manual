all: html pdf


html:
	pandoc \
		--toc \
		--metadata-file=metadata.yaml \
		--css style.css \
		-s README.md manual/*.md \
		-o rendeiro-lab_manual.html

pdf:
	# --css https://raw.githubusercontent.com/simov/markdown-viewer/master/themes/github.css
	pandoc \
		--toc \
		-f gfm -t html5 \
		--metadata-file=metadata.yaml \
		--css pdf.css \
		-s README.md manual/*.md \
		-o rendeiro-lab_manual.pdf
