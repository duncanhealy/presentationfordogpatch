DEBUG=''
BROWS := $(shell command -v firefox --browser 2> /dev/null)
test-site:
	./node_modules/.bin/artillery quick --count 50 -n 50 https://static-site.web.assurehedge.com

test: test-site
	echo "done"
bench-site:
	./node_modules/.bin/artillery dino
	DEBUG='' ./node_modules/.bin/artillery run --quiet -o report.json artillery.yaml > testout.txt
	cat report.json
	./node_modules/.bin/artillery report report.json
	${BROWS} report.json.html
	