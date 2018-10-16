DEBUG=''
BROWS := $(shell command -v firefox --browser 2> /dev/null)
test-site:
	./node_modules/.bin/artillery quick --count 50 -n 50 https://static-site.web.assurehedge.com

test: test-site
	echo "done"
bench-site-%:
	echo "testing for $*"
	./node_modules/.bin/artillery dino
	DEBUG='' ./node_modules/.bin/artillery run --quiet -o $*.json artillery.yaml > testout.txt
	cat $*.json
	./node_modules/.bin/artillery report $*.json
	${BROWS} $*.json.html
	