
function EzHelpKeywords(aKey,aText)
{
	this.helpKey=aKey;
	this.helpText=aText;
}

var myKeys= new Array();
myKeys[0]= new EzHelpKeywords("NA"," is impermissible in My Cart - contact customer care for ordering");
myKeys[1]= new EzHelpKeywords("RE"," is impermissible in My Cart - contact customer care for ordering");
myKeys[2]= new EzHelpKeywords("CS"," is impermissible in My Cart - contact customer care for ordering");
myKeys[3]= new EzHelpKeywords("NM"," could not be added , as Material Code does not exists in Job Quote");
myKeys[4]= new EzHelpKeywords("NQ"," could not be added , as Job Quote does not belong to default Sold-To");
myKeys[5]= new EzHelpKeywords("NL"," could not be added , as Material Code and Line Item of Job Quote does not match");
myKeys[6]= new EzHelpKeywords("CQ"," could not be added , as Cart Qty should not greater than Open Qty of given Job Quote");
myKeys[7]= new EzHelpKeywords("EQ"," could not be added , as Job Quote got expired");
myKeys[8]= new EzHelpKeywords("JR"," is Impermissible in My Cart (rejected on Job Quote)");
myKeys[9]= new EzHelpKeywords("PA"," is Not Include in Your Portfolio or Default Ship-To - Please contact ASB for further details");
myKeys[10]= new EzHelpKeywords("DX"," could not be added to cart: DXV products cannot be mixed with other Brands");