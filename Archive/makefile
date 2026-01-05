all:

	quarto render index.qmd
	open -a /Applications/Skim.app index.pdf

github:

	rm -rf index_files
	quarto render index.qmd
	cp index.pdf vitae.pdf
	echo "Updated/touched on $$(date +%Y-%m-%d)" > .tmp.git
	git add index.pdf vitae.pdf index.html index_files 
	git commit index.pdf vitae.pdf index.html index_files -F .tmp.git
	git push
	## For proper/complete push do it manually via git commit -am "foo..."

clean:

	rm -rf index.html index.pdf index.tex index_files

foo:



