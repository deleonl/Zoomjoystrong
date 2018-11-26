%{
	#include <stdio.h>
	#include "zoomjoystrong.h"
	int yyerror(const char* err);
	int yylex();
%}

%token END
%token END_STATEMENT
%token POINT
%token LINE
%token CIRCLE
%token RECTANGLE
%token SET_COLOR
%token INT
%token FLOAT

%%
program:	expr_list END END_STATEMENT
	;
expr_list:	expr
	|	expr_list expr
	;
expr:		point_statement
	|	line_statement
	|	circle_statement
	|	rect_statement
	|	color_statement
	;
point_statement:	POINT INT INT END_STATEMENT
	{
		if ($2 < 0 || $2 > WIDTH) {
			yyerror("Invalid x-coordinate");
		}
		else if ($3 < 0 || $3 > HEIGHT) {
			yyerror("Invalid y-coordinate");
		}
		else {
			point($2,$3);
		}
	}
	;
line_statement:		LINE INT INT INT INT END_STATEMENT
	{
		if ($2 < 0 || $4 < 0 || $2 > WIDTH || $4 > WIDTH) {
			yyerror("Invalid x-coordinate");
		}
		else if ($3 < 0 || $5 < 0 || $3 > HEIGHT || $4 > HEIGHT) {
			yyerror("Invalid y-coordinate");
		}
		else {
			line($2,$3,$4,$5);
		}
	}			
	;
circle_statement:	CIRCLE INT INT INT END_STATEMENT
	{
		if ($2 < 0 || $2 > WIDTH) {
			yyerror("Invalid x-coordinate");
		}
		else if ($3 < 0 || $3 > HEIGHT) {
			yyerror("Invalid y-coordinate");
		}
		else {
			circle($2,$3,$4);
		}
	}
	;
rect_statement:		RECTANGLE INT INT INT INT END_STATEMENT
	{
		if ($2 < 0 || $2 > WIDTH) {
			yyerror("Invalid x-coordinate");
		}
		else if ($3 < 0 || $3 > HEIGHT) {
			yyerror("Invalid y-coordinate");
		}
		else if ($4 < 0 || $4 + $2 > WIDTH) {
			yyerror("Invalid width");
		}
		else if ($5 < 0 || $5 + $3 > HEIGHT) {
			yyerror("Invalid height");
		}
		else {
			rectangle($2,$3,$4,$5);
		}
	}
	;
color_statement:	SET_COLOR INT INT INT END_STATEMENT
	{
		if ($2 < 0 || $3 < 0 || $4 < 0 || $2 > 255
			|| $3 > 255 || $4 > 255) {
			yyerror("Color values must be 0-255");
		}
		else {
			set_color($2,$3,$4);
		}
	}
	;
%%

int main(int argc, char** argv) {
	setup();
	yyparse();
}

int yyerror(const char* err){
	printf("%s\n", err);
}
