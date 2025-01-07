all: build

requirements:
	sudo apt install \
		pandoc \
		wkhtmltopdf
# To have internal links in PDF
# one must install xfonts-75dpi and wkhtmltopdf from a .deb
# (https://stackoverflow.com/a/78727807/1469535)

clean:
	-rm -rf build
	-rm ORDER

format:
	find source -type f -name "*.md" | xargs mdformat

set_order:
	echo "\
README.md \
source/getting_started.md \
source/mission_statement.md \
source/code_of_conduct.md \
source/communication_and_meetings.md \
source/infrastructure.md \
source/project_planning.md \
source/research.md \
source/record_keeping.md \
source/learning.md \
source/infrastructure.md \
source/public_data.md \
source/manuscript_writing.md \
" > ORDER

# source/mission_statement.md \
# source/culture.md \


html: set_order
	mkdir -p build/html
	bash html.sh

pdf: set_order
	mkdir -p build/pdf
	bash pdf.sh

build: format html pdf
