DISABLED_RULES_1=WHITESPACE_RULE,COMMA_PARENTHESIS_WHITESPACE,CURRENCY
DISABLED_RULES_2=EN_QUOTES,CURRENCY_SPACE,ENGLISH_WORD_REPEAT_BEGINNING_RULE
DISABLED_RULES=${DISABLED_RULES_1},${DISABLED_RULES_2}

proj := ${shell cat project}

md5 = $1 ${addsuffix .md5,$1}

.PHONY: all 

all: ${proj}.ast build

build: ${call to-md5,${proj}.ast}
	latexmk -pdf ${proj}.tex
	latexmk -c

continuous: ${proj}.tex
	trap "make clean" SIGINT; latexmk -pvc -pdf ${proj}.tex

kill-evince:
	N="$$(ps | grep evince | grep -o '^[0-9]* ')"; kill $$N &>/dev/null || true

${proj}.ast: ${proj}.tex
	pandoc -f latex -t html ${proj}.tex > ${proj}.ast

%.md5: FORCE
    @${if ${filter-out ${shell cat $@ 2>/dev/null},${shell md5sum $*}},md5sum $* > $@}

FORCE:

clean: kill-evince
	latexmk -c

test:
	pandoc -f latex -t markdown ${proj}.tex | languagetool -d ${DISABLED_RULES} -
