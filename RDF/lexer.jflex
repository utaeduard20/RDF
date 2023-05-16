package cup.example;
import java_cup.runtime.ComplexSymbolFactory;
import java_cup.runtime.ComplexSymbolFactory.Location;
import java_cup.runtime.Symbol;
import java.lang.*;
import java.io.InputStreamReader;

%%  


%class Lexer
%implements sym
%public
%unicode
%line
%column
%cup
%char
%{
	

    public Lexer(ComplexSymbolFactory sf, java.io.InputStream is){
		this(is);
        symbolFactory = sf;
    }
	public Lexer(ComplexSymbolFactory sf, java.io.Reader reader){
		this(reader);
        symbolFactory = sf;
    }
    
    private StringBuffer sb;
    private ComplexSymbolFactory symbolFactory;
    private int csline,cscolumn;

    public Symbol symbol(String name, int code){
		return symbolFactory.newSymbol(name, code,
						new Location(yyline+1,yycolumn+1, yychar), // -yylength()
						new Location(yyline+1,yycolumn+yylength(), yychar+yylength())
				);
    }
    public Symbol symbol(String name, int code, String lexem){
	return symbolFactory.newSymbol(name, code, 
						new Location(yyline+1, yycolumn +1, yychar), 
						new Location(yyline+1,yycolumn+yylength(), yychar+yylength()), lexem);
    }
    
    protected void emit_warning(String message){
    	System.out.println("scanner warning: " + message + " at : 2 "+ 
    			(yyline+1) + " " + (yycolumn+1) + " " + yychar);
    }
    
    protected void emit_error(String message){
    	System.out.println("scanner error: " + message + " at : 2" + 
    			(yyline+1) + " " + (yycolumn+1) + " " + yychar);
    }
%}

Newline    = \r | \n | \r\n
Whitespace = [ \t\f] | {Newline}
Identifier = [a-zA-z_][a-zA-z0-9_]+
rdfID = [0-9]
rdfnodeID = \"[0-9A-Za-z]*\"
rdfabout = \"[0-9A-Za-z]*\"
rdfresource = \"[0-9A-Za-z]*\"
rdfdatatype = \"[0-9A-Za-z]*\"
rdfparseType = \"[0-9A-Za-z]*\"
URI = \"[0-9A-Za-z]*\"
rdfRDF =  \"[0-9A-Za-z]*\"
rdfli = \"[0-9]*\"
rdfdescription = \"[0-9A-Za-z]*\"
rdfaboutEach = \"[0-9A-Za-z]*\"
rdfaboutEachPrefix = \"[0-9A-Za-z]*\"
rdfbagID = \"[0-9]*\"
anyString = [a-zA-z_][a-zA-z0-9_]
Number = [0-9]

/* comments */
Comment = {TraditionalComment} | {EndOfLineComment}
TraditionalComment = "/*" {CommentContent} \*+ "/"
EndOfLineComment = "//" [^\r\n]* {Newline}
CommentContent = ( [^*] | \*+[^*/] )*

ident = ([:jletter:] | "_" ) ([:jletterdigit:] | [:jletter:] | "_" )*


%eofval{
    return symbolFactory.newSymbol("EOF",sym.EOF);
%eofval}

%state CODESEG

%%  

<YYINITIAL> {
 	
 	
	"<rdf:RDF" { return symbolFactory.newSymbol("StartTag", StartTag); }
	"</rdf:RDF>"   { return symbolFactory.newSymbol("EndTag", EndTag); } 
	"<s:" {return symbolFactory.newSymbol("ResumeTag", ResumeTag); }
	"<ex:" {return symbolFactory.newSymbol("AnyTag", AnyTag); }
	"ID"  { return symbolFactory.newSymbol("ID", ID); } 
	"about"  { return symbolFactory.newSymbol("about",about ); } 
	"rdf:aboutEach" { return symbolFactory.newSymbol("aboutEach",aboutEach); }  
	"rdf:bagID" { return symbolFactory.newSymbol("about",bagID ); } 
	"rdf:Description" { return symbolFactory.newSymbol("Description",Description ); } 
	"parseType"  { return symbolFactory.newSymbol("parseType",parseType ); } 
	"resource"  { return symbolFactory.newSymbol("resource",resource ); } 
	"ref:nodeID"  { return symbolFactory.newSymbol("nodeID",nodeID ); } 
	 "container"  { return symbolFactory.newSymbol("container",container ); } 
	"idAboutAttr"     { return symbolFactory.newSymbol("idAboutAttr",idAboutAttr ); } 
	"aboutEachAttr"   { return symbolFactory.newSymbol("aboutEachAttr",aboutEachAttr ); } 
	"bagIdAttr"      { return symbolFactory.newSymbol("bagIdAttr",bagIdAttr ); } 
	"propAttr"        { return symbolFactory.newSymbol("propAttr",propAttr ); } 
	"property"  { return symbolFactory.newSymbol("property",property ); } 
	"typedNode"       { return symbolFactory.newSymbol("typedNode",typedNode ); } 
	"propName"        { return symbolFactory.newSymbol("propName",propName ); } 
	"typeName"        { return symbolFactory.newSymbol("typeName",typeName ); } 
	"idRefAttr"     { return symbolFactory.newSymbol("idRefAttr",idRefAttr); } 
	"value"          { return symbolFactory.newSymbol("value", value); } 
	"name"           { return symbolFactory.newSymbol("name",name ); } 
	"IDsymbol" { return symbolFactory.newSymbol("IDsymbol",IDsymbol ); } 
	"NSname"          { return symbolFactory.newSymbol("NSname",NSname ); } 
	"sequence"        { return symbolFactory.newSymbol("sequence",sequence ); } 
	"bag"             { return symbolFactory.newSymbol("bag",bag ); } 
	"alternative"     { return symbolFactory.newSymbol("alternative",alternative ); } 
	"member"          { return symbolFactory.newSymbol("member", member); } 
	"referencedItem"  { return symbolFactory.newSymbol("referencedItem", referencedItem); } 
	"inlineItem" { return symbolFactory.newSymbol("inlineItem",inlineItem ); } 
	"dataType" { return symbolFactory.newSymbol("dataType",dataType ); } 
	
	
	
  {Whitespace} { return symbolFactory.newSymbol("WS", WS);}
  
  {rdfID}      { return symbolFactory.newSymbol("RDFID", RDFID); }
  {Number}     { return symbolFactory.newSymbol("NUMBER", NUMBER, Integer.parseInt(yytext())); }
  {rdfnodeID}  { return symbolFactory.newSymbol("RDFNODEID", RDFNODEID); }
  {rdfabout} 	 { return symbolFactory.newSymbol("RDFABOUT", RDFABOUT); }
  {rdfresource}	  { return symbolFactory.newSymbol("RDFRESOURCE", RDFRESOURCE); }
  {rdfdatatype}    { return symbolFactory.newSymbol("RDFDATATYPE", RDFDATATYPE); }
  {rdfparseType}   { return symbolFactory.newSymbol("RDFPARSETYPE", RDFPARSETYPE); }
  {URI}  { return symbolFactory.newSymbol("URI", URI); }
  {rdfRDF}  { return symbolFactory.newSymbol("RDFR", RDFR); }
  {rdfli} { return symbolFactory.newSymbol("RDFLI",RDFLI); } 
  {rdfdescription} {  return symbolFactory.newSymbol("RDFDESCR",RDFDESCR); } 
  	{rdfaboutEach} {   return symbolFactory.newSymbol("RDFABOUTE",RDFABOUTE); } 
  	{rdfaboutEachPrefix} { return symbolFactory.newSymbol("RDFAEP",RDFAEP); } 
  	{rdfbagID} { return symbolFactory.newSymbol("RDFBAGID",RDFBAGID); }
  	{anyString} 	 {return symbolFactory.newSymbol("anyString",anyString); }
  	
  "<<" 		{ return symbol("OLSHIFT",OLSHIFT); }
   "<" 			{ return symbolFactory.newSymbol("OLT",OLT); }
   ">" 			{ return symbolFactory.newSymbol("OGT",OGT); }
   ">="			 { return symbolFactory.newSymbol("OGE",OGE); }
   "=<" 		{ return symbolFactory.newSymbol("OLE",OLE); }
   ">>" 		{ return symbolFactory.newSymbol("ORSHIFT",ORSHIFT); }
   "[" 			{ return symbolFactory.newSymbol("KLSQBKT",KLSQBKT); }
   "]" 			{ return symbolFactory.newSymbol("KRSQBKT",KRSQBKT); }
   "{" 			{ return symbolFactory.newSymbol("KLBRKT",KLBRKT); }
   "}"			 { return symbolFactory.newSymbol("KRBRKT",KRBRKT); }
   "="          { return symbolFactory.newSymbol("EQUAL", EQUAL); }
   ","			{ return symbolFactory.newSymbol("COMMA", COMMA); }
   "@"			{ return symbolFactory.newSymbol("ARON", ARON); }
   "/"			{ return symbolFactory.newSymbol("SLASH", SLASH); }
   "\\"			{ return symbolFactory.newSymbol("OPSL", OPSL); }
   "?"			{ return symbolFactory.newSymbol("QUEST", QUEST); }
   "!"			{ return symbolFactory.newSymbol("EXCL", EXCL); }
   "_" 			{ return symbolFactory.newSymbol("UNDER", UNDER); }
   ":"      		{ return symbolFactory.newSymbol("FULL", FULL); }
   "\""			{ return symbolFactory.newSymbol("QOT", QOT); }
   ";"          { return symbolFactory.newSymbol("SEMI", SEMI); }
   "+"          { return symbolFactory.newSymbol("PLUS", PLUS); }
   "-"          { return symbolFactory.newSymbol("MINUS", MINUS); }
   "*"          { return symbolFactory.newSymbol("TIMES", TIMES); }
   "n"          { return symbolFactory.newSymbol("UMINUS", UMINUS); }
   "("          { return symbolFactory.newSymbol("LPAREN", LPAREN); }
   ")"          { return symbolFactory.newSymbol("RPAREN", RPAREN); }
}



// error fallback
.|\n          { emit_warning("Unrecognized character '" +yytext()+"' -- ignored"); }
