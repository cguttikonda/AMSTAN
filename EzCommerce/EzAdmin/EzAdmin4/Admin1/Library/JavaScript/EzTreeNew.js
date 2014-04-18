


// Global variables 
//These two variables are overwriten on defineMyTree.js if needed be

USETEXTLINKS = 1 
STARTALLOPEN = 0
count = 0
indexOfEntries = new Array()
nEntries = 0 
doc = document 
browserVersion = 1 
selectedFolder=0
navigator.family='ie4'

imgRoot='..\\..\\Images\\ImagesTree\\'

function initializeDocument() 
{

 foldersTree.initialize(0, 1, "") 
 
 if (!STARTALLOPEN)
    {
 			// close the whole tree 
  		clickOnNode(0) 
  			// open the root folder 
  		clickOnNode(0) 
	  } 

} 
 
 
 function clickOnNode(folderId) 
 { 
   var clickedFolder = 0 
   var state = 0 
  
   clickedFolder = indexOfEntries[folderId] 
   state = clickedFolder.isOpen 
   clickedFolder.setState(!state) //open<->close  
 
} 

// Definition of class Item (a document or link inside a Folder) 
// ************************************************************* 
 
function Item(itemDescription, itemLink) // Constructor 
{ 

  // constant data 
  this.desc = itemDescription 
  this.link = itemLink 
  this.id = -1 //initialized in initalize() 
  this.navObj = 0 //initialized in render() 
  this.iconImg = 0 //initialized in render() 
  this.iconSrc = imgRoot +"Ezdoc.gif" 
 
  // methods 
  this.initialize = initializeItem 
  this.createIndex = createEntryIndex 
  this.esconde = escondeBlock
  this.mostra = mostra 
  this.renderOb = drawItem 
  //this.totalHeight = totalHeight   
  this.blockStart = blockStart  
  this.blockEnd = blockEnd
  
} 


function Folder(folderDescription, hreference) //constructor 
{ 
  //constant data 

  this.desc = folderDescription 
  this.hreference = hreference 

  this.id = -1 
  this.navObj = 0
  this.iconImg = 0  
  this.nodeImg = 0  
  this.isLastNode = 0 
 
  //dynamic data 

  this.isOpen = true   
  this.iconSrc = imgRoot+"Ezfolderopen.gif"   
  this.children = new Array()
  this.nChildren = 0 
 
  //methods 

  this.initialize = initializeFolder 
  this.setState = setStateFolder 
  this.addChild = addChild 
  this.createIndex = createEntryIndex 
  this.escondeBlock = escondeBlock
  this.esconde = escondeFolder 
  this.mostra = mostra 
  this.renderOb = drawFolder 
  //this.totalHeight = totalHeight 
  this.subEntries = folderSubEntries 
  this.outputLink = outputFolderLink 
  this.blockStart = blockStart
  this.blockEnd = blockEnd  
} 
 function initializeFolder(level, lastNode, leftSide) 
 { 
 

   var j=0 
   var i=0 
   var numberOfFolders 
   var numberOfDocs 
   var nc 
       
   nc = this.nChildren 
    
   this.createIndex() 
  
   var auxEv = "" 
  
   if (browserVersion > 0) 

     auxEv = "<a href='javascript:clickOnNode("+this.id+")'>" 
   else 
     auxEv = "<a>" 
 
   if (level>0) 
     if (lastNode) //the last child in the children array 
     { 
       this.renderOb(leftSide + auxEv + "<img name='nodeIcon" + this.id + "' id='nodeIcon" + this.id + "' src='" + imgRoot + "Ezmlastnode.gif' width=16 height=22 border=0></a>") 
       leftSide = leftSide + "<img src='" + imgRoot + "Ezblank.gif' width=16 height=22>"  
       this.isLastNode = 1 
     } 
     else 
     { 
       this.renderOb(leftSide + auxEv + "<img name='nodeIcon" + this.id + "' id='nodeIcon" + this.id + "' src='" + imgRoot + "Ezmnode.gif' width=16 height=22 border=0></a>") 
       leftSide = leftSide + "<img src='" + imgRoot + "Ezvertline.gif' width=16 height=22>" 
       this.isLastNode = 0 
     } 
   else 
     this.renderOb("") 
    
   if (nc > 0) 
   { 
     level = level + 1 
     for (i=0 ; i < this.nChildren; i++)  
     { 
       if (i == this.nChildren-1) 
         this.children[i].initialize(level, 1, leftSide) 
       else 
         this.children[i].initialize(level, 0, leftSide) 
       } 
   } 
   
 } 
  
 function setStateFolder(isOpen) 
 { 
 
   var subEntries 
   var totalHeight 
   var fIt = 0 
   var i=0 
  
   if (isOpen == this.isOpen) 
     return 
  
   this.isOpen = isOpen 
    
   propagateChangesInState(this) 
  
 } 
  
 function propagateChangesInState(folder) 
 {   
   var i=0 
  
   if (folder.isOpen) 
   { 
     if (folder.nodeImg) 
       if (folder.isLastNode) 
         folder.nodeImg.src = imgRoot +"Ezmlastnode.gif" 
       else 
 	    folder.nodeImg.src = imgRoot +"Ezmnode.gif" 
     if(folder.id=="0")
    	 folder.iconImg.src = imgRoot +"Ezfolderopen.gif" //"EZC_logo.jpg"
     else         
     folder.iconImg.src = imgRoot+"Ezfolderopen.gif" 
     for (i=0; i<folder.nChildren; i++) 
       folder.children[i].mostra() 
   } 
   else 
   { 
     if (folder.nodeImg) 
       if (folder.isLastNode) 
         folder.nodeImg.src = imgRoot +"Ezplastnode.gif" 
       else 
 	    folder.nodeImg.src = imgRoot +"Ezpnode.gif" 
     if(folder.id=="0")
     folder.iconImg.src = imgRoot +"Ezfolderclosed.gif" //"EZC_logo.jpg"
     else     
     folder.iconImg.src = imgRoot +"Ezfolderclosed.gif"
     
     for (i=0; i<folder.nChildren; i++) 
       folder.children[i].esconde() 
   }  
 } 
  
 function escondeFolder() 
 { 
   this.escondeBlock()
   this.setState(0) 
   
 } 
  
 function drawFolder(leftSide) 
 { 
   var idParam = "id='folder" + this.id + "'"
   
   this.blockStart("folder")
 
   doc.write("<Tr><Td>") 
   doc.write(leftSide) 
   this.outputLink()    
   doc.write("<img id='folderIcon" + this.id + "' name='folderIcon" + this.id + "' src='" + this.iconSrc+"' border=0></a>") 
   doc.write("</Td><Td valign=middle nowrap>") 
  
   if (USETEXTLINKS) 
   { 
     this.outputLink() 
     doc.write(this.desc + "</a>") 
   } 
   else 
     doc.write(this.desc) 
   doc.write("</Td>")  
 
   this.blockEnd()
   this.navObj = doc.all["folder"+this.id] 
   this.iconImg = doc.all["folderIcon"+this.id] 
   this.nodeImg = doc.all["nodeIcon"+this.id] 
    
 } 
 function outputFolderLink() 
 { 
   doc.write("<a href='javascript:clickOnNode("+this.id+")'>" )
 } 
 function addChild(childNode) 
 { 
   this.children[this.nChildren] = childNode 
   this.nChildren++ 
   return childNode 
 } 
  
 function folderSubEntries() 
 { 
   var i = 0 
   var se = this.nChildren 
  
   for (i=0; i < this.nChildren; i++){ 
     if (this.children[i].children) //is a folder 
       se = se + this.children[i].subEntries() 
   } 
  
   return se 
} 
function initializeItem(level, lastNode, leftSide) 
{  

  this.createIndex() 
 
  if (level>0) 
    if (lastNode) //the last 'brother' in the children array 
    { 
      this.renderOb(leftSide + "<img src='" + imgRoot + "Ezlastnode.gif' width=16 height=22>") 
      leftSide = leftSide + "<img src='" + imgRoot + "Ezblank.gif' width=16 height=22>"  
      
    } 
    else 
    { 
      this.renderOb(leftSide + "<img src='" + imgRoot + "Eznode.gif' width=16 height=22>") 
      leftSide = leftSide + "<img src='" + imgRoot + "Ezvertline.gif' width=16 height=22>" 
    } 
  else 
    this.renderOb("")  
    
} 
 
function drawItem(leftSide) 
{ 

  this.blockStart("item")
  doc.write("<doc id=compdiv style='position:absolute;height:60%;overflow:auto'>")
  doc.write("<Tr><Td>") 
  doc.write(leftSide) 
  doc.write("<a href=" + this.link + ">") 
  doc.write("<img id='itemIcon"+this.id+"' ") 
  doc.write("src='"+this.iconSrc+"' border=0>") 
  doc.write("</a>") 
  doc.write("</Td><Td valign=middle nowrap>") 
  
  if (USETEXTLINKS) 
    doc.write("<a href=" + this.link + ">" + this.desc + "</a>") 
  else 
    doc.write(this.desc) 
doc.write("</div>")
  this.blockEnd()
  
  this.navObj = doc.all["item"+this.id] 
  this.iconImg = doc.all["itemIcon"+this.id] 
} 
// Methods common to both objects (pseudo-inheritance) 
// ******************************************************** 
 
function mostra() 
{ 
 
       var str = new String(doc.links[0])
       //alert(str)
       if (str.slice(16,21) != "merce")
  	    return
  	    
       this.navObj.style.display = "block"    
       
} 
function escondeBlock() 
{ 
   if (this.navObj.style.display == "none") 
      return 
    this.navObj.style.display = "none" 
} 
 
function blockStart(idprefix) {
var idParam = "id='" + idprefix + this.id + "'"
if(idprefix=="item")
count=count+1
if(count==1)
{
	doc.write("<div id=compdiv style='position:absolute;height:80%;overflow:auto'>")
		/*doc.write("<body onLoad='scrollInit()' onresize=scrollInit() scroll=no >")
		doc.write("<form>")
		doc.write("<div id='theads'>")
		doc.write("<Table  width=60% align=center border=0 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >") 		  
		doc.write("<Tr><th width=20%>&nbsp;</th></Tr>")
		doc.write("</Table >");
		doc.write("</div>");

		doc.write("<DIV id='OuterBox1Div' style='position:absolute'>")
		doc.write("<DIV id='InnerBox1Div'>") 
		//<Table  width="100%" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >*/
}		
	
  
  doc.write("<Table  border=0 cellspacing=0 cellpadding=0 ")  
  doc.write(idParam + " style='display:block; position:block;'>") 

}

function blockEnd() {
  doc.write("</Table >")   

}
function createEntryIndex() 
{ 

  this.id = nEntries 
  indexOfEntries[nEntries] = this 
  nEntries++ 
 
} 
// Events 

function clickOnFolder(folderId) 
{ 
  var clicked = indexOfEntries[folderId] 
 
 
  if (!clicked.isOpen) 
    clickOnNode(folderId) 
 
  return  
 
  if (clicked.isSelected) 
    return 
} 
 
function clickOnNode(folderId) 
{ 
	
  var clickedFolder = 0 
  var state = 0 
  clickedFolder = indexOfEntries[folderId] 
  state = clickedFolder.isOpen 
  clickedFolder.setState(!state) //open<->close  
} 
 

// Auxiliary Functions for Folder-Tree backward compatibility 
// *********************************************************** 
 
function gFld(description, hreference) 
{ 
  folder = new Folder(description, hreference) 
  return folder 
} 
function gLnk(target, description, linkData, targetRoot ) 
{ 
  fullLink = "" 
  if (targetRoot=="")
  {
  	fullLink = linkData
  	//fullLink = linkData+"  target= \"_parent\" " 
  }
  else
  	fullLink = linkData
 	
  linkItem = new Item(description, fullLink) 
  return linkItem 
} 
function insFld(parentFolder, childFolder) 
{
  return parentFolder.addChild(childFolder) 
} 
 
function insDoc(parentFolder, document) 
{ 
  parentFolder.addChild(document) 
} 
 
//Dynamic tree.js
 USETEXTLINKS = 1  
  STARTALLOPEN = 0 //replace 0 with 1 to show the whole tree
  var foldersTree = gFld("<span class=folderStyle>&nbsp;Organogram Structure</span>", "www.ezcommerceinc.com.htm")
  
 fArr=new Array();
 fsArr=new Array();

InsFolders(foldersTree,"")
insDocument(foldersTree,"")

function InsFolders(root,rootPath)
{

	for(i=0;i<folderArr.length;i++)
  	{
 		if(folderArr[i].pFolder==rootPath)
  		{
			fArr[i]=insFld(root, gFld("<span class=folderStyle>&nbsp;"+folderArr[i].cFolder+"</span>", ""))
  			fName=folderArr[i].cFolder;
  			insDocument(fArr[i],fName)
  			createSub(fArr[i],fName)
		}
 	}	
} 
function insDocument(parent,parentRoot)
{

	for(x=0;x<TopicArray.length;x++)
 	{
 		if(TopicArray[x].fFolder==parentRoot)
 		{
 			insDoc(parent, gLnk("bsscright", "<span class=docStyle>&nbsp;"+TopicArray[x].fContent+"</span>", TopicArray[x].fName,TopicArray[x].fFolder))	
 	 	}
  	}
 
}
function createSub(tarArr,fSubName)
{

	var p=0;
	var fsubsubArr=new Array();
	var fSubSubName="";
	for(var j=0;j<folderArr.length;j++)
 	{	
 		if(folderArr[j].pFolder == fSubName)
 		{
 			fsubsubArr[p]=insFld(tarArr, gFld("<span class=folderStyle>&nbsp;"+folderArr[j].cFolder+"</span>", ""))
 			fSubSubName=fSubName+'/'+folderArr[j].cFolder;
 			insDocument(fsubsubArr[p],fSubSubName)
 			createSub(fsubsubArr[p],fSubSubName);
 			p++;
 		}
 	}
}

 
 