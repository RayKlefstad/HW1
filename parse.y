%token Pass Break Continue Return Ident If Else Elif For While Def Arrow Class Or And Not In Is True False None Number String GE LE EQ NE
%token NOTUSED Except Lambda With As Finally Nonlocal Assert Yield From Global Raise Del Try Import
%token Indent Dedent Newline EndMarker
%token-table

%{
#include <iostream>
using namespace std;

#define YYDEBUG 1

#define token_image(tok)   yytname[YYTRANSLATE(tok)]
#define yyerror(s) cout << "PARSE ERROR r:" << row << " c:" << col << ": " << s << endl
#define scan_error(tok) cout << "SCAN ERROR r:" << row << " c:" << col << ": " << tok << endl
int yylex(void);


int row = 0;
int col = 0;
int indents = 0;

%}

%%
file: 
;
%%

#include "scan.cpp"


int scan_main()
{
    while (int token = yylex())
    {
        if (token != Newline && token != Indent && token != Dedent && token != EndMarker)
        {
            cout << "Token = " << token_image(token) << "\t\t";
            cout << "Lexeme = \"" << yytext << "\"";
            cout << endl;
        }
    }
    return 0;
}

int main(int argc, char *argv[])
{
    int opt;
    while (true)
        switch ( opt = getopt(argc, argv, "123456789:") )
        {
            case '1':
                scan_main();
                break;
            case '2':
                // parse_main();
                break;
            case '3':
            case '4':
            case '5':
            case '6':
            case '7':
            case '8':
            case '9':
                cerr << "Program option " << static_cast<char>(opt) << " TBD" << endl;
                break;
            case -1:
                exit(0);
            default:
                cerr << "Unknown program option: " << static_cast<char>(opt) << endl;
        }
    return 0;
}

