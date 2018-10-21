# TextProcessor
A text processor which performs certain operations on strings is developed using lex and yacc.
LEX and Yacc are used to achieve the following tasks.
This is similar to Calculator, except it is used with text strings.
Text processor : Let op1 and op2 are operands whose values are text (contains alphanumeric characters).
?op1 gives the length of op1.
Operations can be nested using braces ( ).
Precedence & associativity rules
Highest to lowest precedence, the operators are: (),?,^.*, %,&,~,@,#,=
Associativity is from left to right (except for ? and ^ which are right to left).
An appropriate CFG for this and used.
Example:
Input: abc^2 ===> Output: abcabc
Input: abc^?xyz ===> Output: abcabcabc
concatenate%6&3 ===> cat
concatenate%6&3 = cat ===> true
Note: please do refer README.pdf for other operations.

