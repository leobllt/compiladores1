calculadora:	calculadora_lexer.l calculadora_parser.y calculadora_header.h
				bison -d calculadora_parser.y
				flex -o calculadora_lexer.lex.c calculadora_lexer.l
				gcc -o $@ calculadora_parser.tab.c calculadora_lexer.lex.c calculadora_funcoes.c -lm
				@echo Arquivos compilados com sucesso!