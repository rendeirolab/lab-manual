all: build

requirements:
	sudo apt install \
		pandoc \
		wkhtmltopdf

format:
	find . -type f -name "*.md" | xargs mdformat

set_order:
	echo "\
source/README.md \
source/code_of_conduct.md \
source/mission_statement.md \
source/culture.md \
source/getting_started.md \
source/communication.md \
source/research.md \
source/record_keeping.md \
source/learning.md \
source/infrastructure.md \
source/public_data.md \
source/manuscript_writing.md \
source/fun.md \
" > ORDER

html:
	mkdir -p build/html
	bash html.sh

pdf:
	mkdir -p build/pdf
	bash pdf.sh

build: format set_order html pdf
