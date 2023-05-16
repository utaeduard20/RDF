package cup.example;

public class ParserWithTree extends Parser{

	public ParserWithTree() 
	{
		super();
	}
	protected MultiTreeNode createDeclarationNode(MultiTreeNode declaration) 
	{ 
		MultiTreeNode newNode = new MultiTreeNode("Declaration");
		newNode.addChild(declaration);
		return newNode;
	}
 	protected MultiTreeNode createFunctionDeclarationNode(MultiTreeNode typeSpecifier, String identifierName, MultiTreeNode paramsList, MultiTreeNode compoundStatement) 	
 	{ 
 		MultiTreeNode newNode = new MultiTreeNode("FunctionDeclaration", identifierName);
 		newNode.addChild(typeSpecifier);
 		if (paramsList != null)
 			newNode.addChild(paramsList);
 		newNode.addChild(compoundStatement);
 		return newNode; 
 	}
 	
  	protected MultiTreeNode createTypeSpecifier(String typeName)
  	{ 
  		MultiTreeNode newNode = new MultiTreeNode("TypeSpecifier", typeName);
  		return newNode;
  	}
	protected MultiTreeNode createListNode(String listName, MultiTreeNode firstChild)
	{
		MultiTreeNode newNode = new MultiTreeNode(listName);
		newNode.addChild(firstChild);
		return newNode;
	}
	protected MultiTreeNode createVarDeclaration(MultiTreeNode typeSpecifier, String identifierName, Integer value )
	{
		MultiTreeNode newNode = new MultiTreeNode("Var Declaration", identifierName);
		newNode.addChild(typeSpecifier);		
		newNode.addChild(new MultiTreeNode("IntValue", "" + value));
		return newNode;
	}
	protected MultiTreeNode createCompoundStatement(MultiTreeNode declarations, MultiTreeNode instructions)
	{
		MultiTreeNode newNode = new MultiTreeNode("CompoundStatement");
		if (declarations != null)
			newNode.addChild(declarations);
		if (instructions != null)
			newNode.addChild(instructions);
		return newNode;
	}
	protected MultiTreeNode createIfStatement(String identifier, MultiTreeNode ifInstructions, MultiTreeNode elseInstructions)
	{
		MultiTreeNode newNode = new MultiTreeNode("IfStatement", identifier);
		newNode.addChild(ifInstructions);
		if (elseInstructions != null)
			newNode.addChild(elseInstructions);
		return newNode;
	}
}
