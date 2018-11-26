%{
	#include "zjs.tab.h"
	#include <stdio.h>	
%}

%option yylineno

%%
end		{ return END; }
;		{ return END_STATEMENT; }
point		{ return POINT; }
line		{ return LINE; }
circle		{ return CIRCLE; }
rectangle	{ return RECTANGLE; }
set_color	{ return SET_COLOR; }
[0-9]+		{ return INT; }
[0-9]+\.[0-9]+	{ return FLOAT; }
[' '|\t|\n|\r]	;
.		{ printf("NOT A TOKEN ON LINE %d: %d\n", yylineno, (int) yytext[0]); }
%%

int yywrap() {
	return 1;
}
