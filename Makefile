DRULES_1=WHITESPACE_RULE,COMMA_PARENTHESIS_WHITESPACE,CURRENCY
DRULES_2=EN_QUOTES,CURRENCY_SPACE,ENGLISH_WORD_REPEAT_BEGINNING_RULE
DRULES_3=UPPERCASE_SENTENCE_START
DRULES=${DRULES_1},${DRULES_2},${DRULES_3}

LANGUAGETOOL = languagetool -l en-US -d ${DRULES}

PREVIEWER := evince

KILL_COMMAND = ps | grep ${PREVIEWER} | sed 's/^[ ]*//g' | grep -o '^[0-9]* '

proj := ${shell cat project}

all: test build

build: ${proj}.tex
	latexmk -pdf ${proj}.tex

continuous: ${proj}.tex
	trap "make clean" SIGINT; latexmk -xelatex -pvc -pdf ${proj}.tex

kill-evince:
	N="$$(${KILL_COMMAND})"; kill $$N &>/dev/null || true

clean: kill-evince
	latexmk -c

test:
	pandoc -f latex -t markdown ${proj}.tex | ${LANGUAGETOOL} -
