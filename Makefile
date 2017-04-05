.PHONY: yyyymmdd.sh
yyyymmdd.sh:
	grep '    ' README.md | sed -e 's/    //' > yyyymmdd.sh
