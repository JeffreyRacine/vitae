all:
	quarto render index.qmd
	open -a /Applications/Skim.app index.pdf

render:
	quarto render index.qmd
	cp index.pdf vitae.pdf

publish-local:
	CV_PUSH=0 /opt/local/bin/bash ./CV.sh

publish:
	CV_PUSH=1 /opt/local/bin/bash ./CV.sh

install-hooks:
	./scripts/install-git-hooks.sh

clean:
	rm -rf index.html index.pdf index.tex index_files
