//compilation steps:
//step-1 : yacc -d 201511018.y
//step-2: lex 201511018.l
//step-3: gcc lex.yy.c y.tab.c -o 201511018
//step-4: ./201511018
//After this we get some warning regarding realloc() just ignore them




%{
#include<stdio.h>
#include<stdlib.h>
extern int yylex();
char* concat(char *a,char *b);
char* int_to_str(int);
int len(char *a);
char* n_concat(char*,char *b);

char* get_prefix(char *a,char *b);
char* get_suffix(char *a,char *b);
char* is_prefix(char *a,char *b);
char* is_suffix(char *a,char *b);
char* is_substring(char *a,char *b);
char* are_equal(char *a,char *b);
char* are_different(char *a,char *b);



void yyerror(char*);


%}



%union{ 
        char *p;
      
}

%token <p> ip 
%token NEWLINE
%type <p>O P Q R S T U V W  X Y Z 

%%

O : P  NEWLINE { printf("%s\n",$1); exit(1);}
  ;

P :P '<' '>' Q  {$$=are_different($1,$4);}
  |Q		 {$$=$1;}
  ;


Q : Q '=' R     {$$=are_equal($1,$3);}
  | R		 {$$=$1;}	
  ;

R : R '#' S  {$$=is_substring($1,$3);}
  | S        {$$=$1;}
  ; 


S : S '@' T   {$$=is_suffix($1,$3);}
  | T         {$$=$1;}
  ;

T : T '~' U {$$=is_prefix($1,$3);}
  | U	     {$$=$1;}
  ; 


U : U '&' V {$$=get_suffix($1,$3);}
  | V       {$$=$1;}
  ;


V : V '%' W {$$=get_prefix($1,$3);}
  | W	    {$$=$1;}
  ;  


W : W '*' X {$$=concat($1,$3);}
  | X	  {$$=$1;}
  ;

X : X '^' Y {$$=n_concat($1,$3);}
  | Y          {$$=$1;}
  ; 

Y : '?' Y { $$=int_to_str(len($2));}
  | Z     {$$=$1;}
  ;

Z : '(' P ')'    {$$=$2;}
  | ip  	{$$=$1;}
  ;


%%

void yyerror(char *err_status)
{
   
	fprintf(stderr, "%s\n", err_status);
	

}

int len(char *a)
{
	int i;
	for(i=0;a[i]!='\0';i++);
	return i;


}

char* int_to_str(int n)
{
	char *string;
	string=malloc(sizeof(char));
	int tmp,i,count=0,length;
	char c;
	while(n>0)
	{
		tmp=n%10;
		c=tmp+'0';
		realloc(string,(sizeof(char)));
		string[count]=c;
		count++;
		n=n/10;
	}
	string[count]='\0';
	length=len(string);
	for(i=0;i<(length/2);i++)
	{
		c=string[i];
		string[i]=string[length-1-i];
		string[length-1-i]=c;

	}

	return string;
}


int str_to_int(char *a)
{
	int n,length,count=0;
	length=len(a);
	n=0;
	while(count<length)
	{
		n=n*10+(a[count]-'0');
		count++;
			
	}
	return n;
}




char* concat(char *a,char *b)
{
	char *c;
	int i,count,len_a,length,len_b;
	c=malloc(sizeof(char));
	for(i=0;a[i]!='\0';i++)
	{
		realloc(c,(sizeof(char)));
		c[i]=a[i];
	}
	count=i;
	for(i=0;b[i]!='\0';i++)
	{	
		realloc(c,(sizeof(char)));
		c[count+i]=b[i];
	}
	c[count+i]='\0';
	return c;

}

char* n_concat(char *a,char *b)
{
	char *c;
	int i,final_length,n,count=0;
	n=str_to_int(b);
	final_length=len(a)*n;
	c=malloc(sizeof(char)*final_length);
	while(count<final_length)
	{
		for(i=0;a[i]!='\0';i++)
		{
			c[count+i]=a[i];		
		}
		count=count+i;
	}
	c[count]='\0';
	return c;
}

char* get_prefix(char *a,char *b)
{
	char *c;
	int n,i;
	n=str_to_int(b);
	c=malloc(sizeof(char));
	for(i=0;i<n;i++)
	{
		realloc(c,(sizeof(char)));
		c[i]=a[i];
	}
	c[i]='\0';
	return c;
}

char* get_suffix(char *a,char *b)
{
	char *c;
	int i,n,length;
	n=str_to_int(b);
	c=malloc(sizeof(char));
	length=len(a);
	for(i=0;i<n;i++)
	{
		realloc(c,(sizeof(char)));
		c[n-1-i]=a[length-1-i];
	}
	c[n]='\0';
	return c;
}

char* is_prefix(char *a,char *b)
{
	char *c;
	c=malloc(sizeof(char)*5);
	c="false";
	int max_len,i; 
	max_len=len(a);
	for(i=0;i<max_len;i++)
	{
		if(a[i]==b[i])
		{
			c="true";
			break;
		}
			
	}
	return c;
}


char* is_suffix(char *a,char *b)
{
	char *c;
	c=malloc(sizeof(char)*5);
	c="false";
	int max_len,i,length; 
	max_len=len(a);
	length=len(b);
	for(i=0;i<max_len;i++)
	{
		if(a[max_len-1-i]==b[length-1-i])
		{
			c="true";
			break;
		}
			
	}
	return c;
}


char* are_equal(char *a,char *b)
{
	char *c;
	c=malloc(sizeof(char)*5);
	c="false";
	int i,len2,len1;
	len2=len(b);
	len1=len(a);
	
	if(len2!=len1)
		return c;
	
	else
	{
		c="true";
		for(i=0;i<len1;i++)
		{
			if(a[i]!=b[i])
			{
				c="false";
				break;
			}	
		}		
	}
	return c;
}


char* are_different(char *a,char *b)
{
	char *c;
	c=malloc(sizeof(char)*5);
	if(are_equal(a,b)=="true")
		c="false";
	else
		c="true";
	return c;
}



char* is_substring(char *a,char *b)
{
	char *c;
	c=malloc(sizeof(char)*5);
	c="false";
	int status=1;	
	int i,j,length,k,z;
	length=len(b);
	for(i=0;i<length;i++)
	{
		status=1;
		if(a[0]==b[i])
		{
			c="true";
			j=len(a);
			z=1;
			while(z<j)
			{
				if(a[z]!=b[i+z])
				{
					status=0;
					c="false";
					break;			
				}
				z++;		
			}
			if(status==1)
				break;			

		}
		
	}
	return c;
}	



int  main() {
      yyparse();
	return 1;
    }

