/* A Bison parser, made by GNU Bison 3.7.5.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    TIPO = 258,                    /* TIPO  */
    ID = 259,                      /* ID  */
    IF = 260,                      /* IF  */
    ELSE = 261,                    /* ELSE  */
    WHILE = 262,                   /* WHILE  */
    FOR = 263,                     /* FOR  */
    CONTINUE = 264,                /* CONTINUE  */
    BREAK = 265,                   /* BREAK  */
    VOID = 266,                    /* VOID  */
    RETURN = 267,                  /* RETURN  */
    ICONSTANTE = 268,              /* ICONSTANTE  */
    FCONSTANTE = 269,              /* FCONSTANTE  */
    STRING = 270,                  /* STRING  */
    LPAREN = 271,                  /* LPAREN  */
    RPAREN = 272,                  /* RPAREN  */
    LCOLCH = 273,                  /* LCOLCH  */
    RCOLCH = 274,                  /* RCOLCH  */
    LCHAV = 275,                   /* LCHAV  */
    RCHAV = 276,                   /* RCHAV  */
    LITERAL_PONTO_E_VIRGULA = 277, /* LITERAL_PONTO_E_VIRGULA  */
    LITERAL_PONTO = 278,           /* LITERAL_PONTO  */
    LITERAL_VIRGULA = 279,         /* LITERAL_VIRGULA  */
    LITERAL_RECEBE = 280,          /* LITERAL_RECEBE  */
    ADDOP = 281,                   /* ADDOP  */
    EQOP = 282,                    /* EQOP  */
    ANDOP = 283,                   /* ANDOP  */
    OROP = 284,                    /* OROP  */
    NOTOP = 285,                   /* NOTOP  */
    RELOP = 286,                   /* RELOP  */
    INCR = 287,                    /* INCR  */
    MULOP = 288,                   /* MULOP  */
    DIVOP = 289,                   /* DIVOP  */
    EOL = 290,                     /* EOL  */
    ACORDE = 291                   /* ACORDE  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif
/* Token kinds.  */
#define YYEMPTY -2
#define YYEOF 0
#define YYerror 256
#define YYUNDEF 257
#define TIPO 258
#define ID 259
#define IF 260
#define ELSE 261
#define WHILE 262
#define FOR 263
#define CONTINUE 264
#define BREAK 265
#define VOID 266
#define RETURN 267
#define ICONSTANTE 268
#define FCONSTANTE 269
#define STRING 270
#define LPAREN 271
#define RPAREN 272
#define LCOLCH 273
#define RCOLCH 274
#define LCHAV 275
#define RCHAV 276
#define LITERAL_PONTO_E_VIRGULA 277
#define LITERAL_PONTO 278
#define LITERAL_VIRGULA 279
#define LITERAL_RECEBE 280
#define ADDOP 281
#define EQOP 282
#define ANDOP 283
#define OROP 284
#define NOTOP 285
#define RELOP 286
#define INCR 287
#define MULOP 288
#define DIVOP 289
#define EOL 290
#define ACORDE 291

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
