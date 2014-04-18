	var tabCount=0;
	var tabNo=1;
	
	function EzProduct(code,desc)
	{
		this.code=code;
		this.desc=desc;
	}
	
	function EzDoctor(code,desc)
	{
		this.code=code;
		this.desc=desc;
	}
	
	var myProducts = new Array()
	myProducts[0]= new EzProduct("prod1","Product 1")
	myProducts[1]= new EzProduct("prod2","Product 2")
	myProducts[2]= new EzProduct("prod3","Product 3")
	myProducts[3]= new EzProduct("prod4","Product 4")
	myProducts[4]= new EzProduct("prod5","Product 5")


	function ezAddNewRow(tabNo)
 	{
 		if(tabCount==0)
 			tabCount=tabNo;
		var tabObj=document.getElementById("InnerBox1Tab")
		var rowItems = tabObj.getElementsByTagName("tr");
		var rowCountValue = rowItems.length;
		var rowId = tabObj.insertRow(rowCountValue);
		elementsArray=new Array();
		elementsArray[0] ='<select name="product" style="width:100%"><option value="">--Select--</option>'
		for(objLen=0;objLen<myProducts.length;objLen++)
			elementsArray[0] += '<option value='+myProducts[objLen].code+'>'+myProducts[objLen].desc+'</option>'
		elementsArray[0] += '</select>'
		elementsArray[1]='<input type="text" name="batchNo" class=InputBox size="16" maxLength="16">'
		elementsArray[2]='<input type="text" name="qty" class=InputBox size="10" maxLength="10">'
		eleWidth = new Array();

		eleWidth[0] = "60%";
		eleWidth[1] = "20%";
		eleWidth[2] = "20%";

		len=elementsArray.length
		for (i=0;i<len;i++){
			cell0Data = elementsArray[i]
			cell0=rowId.insertCell(i);
			cell0.innerHTML=cell0Data;
			cell0.align="center";
		        cell0.width= eleWidth[i]
		}
 		//rowCount++;

	}

	function moreProdLines()
	{
		if(chkEmpty())
		{
			if(document.all){
				retVal=showModalDialog('../Sales/ezDialogBox.jsp'," ",'center:yes;dialogWidth:25;dialogHeight:8;status:no;minimize:yes');
				moreRows(tabNo,retVal)
			}else{
				createPopUPWindow(tabNo)
			}
		}
	}
	function moreRows(tabNo,retVal)
	{
		if (!( eval(retVal) == "undefined") && retVal != null)
		{
	  		if ((retVal!=null)&&(retVal > 0))
	  		{
	 			if (parseInt(retVal) > 30 )
	 			{
  					alert("You cannot enter more than thirty products");
	 			}
	 			else
	 			{
  					for (lineCount=0;lineCount<retVal;lineCount++)
  					{
  						ezAddNewRow(tabNo);
  						tabNo++;
						curIndex++;
					}
  				}
 			}
			
		}
	      
	}
	function netscapeFunction(tabNo)
	{
		var inputObj=document.getElementById("Rownos")
		var retVal=0;
		if(inputObj!=null)
			retVal=inputObj.value
 		if(retVal==""){
			alert("Please enter number of lines to add")
		}else{
			HideNetDiv()
			moreRows(tabNo,retVal)
 		}
	}
	function chkEmpty()
	{
		var newProd=document.getElementsByTagName("select");
		if(newProd != null)
		{
	    		var x=0;
	    		for(var j=0;j<newProd.length;j++)
	    		{
	    			if(newProd[j].value=="")
	    			{
	    				alert("Please fill all the  rows then click Add Lines")
	    				return false
	    			}
	    		}
	    		return true
         	}else{
         		return true
         	}
	}
	function showText(rCount)
	{
		var temp="";
		if(rowCount<=1)
			temp ='myForm.text3'
		else
			temp='myForm.text3['+rCount+']'
		openWindowEdit(temp)
	}
	function divScroll()
	{
		var headDiv= document.getElementById("theads")
		var linesDiv= document.getElementById("InnerBox1Div")
		var linesDivTop=linesDiv.offsetTop
		if(!(document.all)){
			linesDiv.style.background="#FFFFFF"
			headDiv.style.overflow="auto"
			linesDiv.style.top=linesDivTop
		}
		headDiv.scrollLeft=linesDiv.scrollLeft
	}
	function createPopUPWindow(tc)
	{
		var addrowsText="";
		addrowsText += '<br><Table align=center width="80%" style="background:#006666" border=1 borderColorDark=#ffffff borderColorLight=#006666 cellPadding=2 cellSpacing=0><tr><td style="background:#006666" align=center><Table align=center width="70%"><Tr><Th><nobr>Please enter the Number of Rows you want to Add :'
		addrowsText += '<input type=text id="Rownos" name="Rownos" class=InputBox size=5 style="text-align:right" maxlength="2"></nobr></Th></Tr></Table><br>'
		addrowsText += '<Table align="center"><Tr><Td align=center>'
		addrowsText += '<img src="../../Images/Buttons/'+buttonsPath+'/ok.gif" border="none" style="cursor:pointer;cursor:hand" onClick="netscapeFunction('+tc+')">&nbsp;&nbsp;'
		addrowsText += '<img src="../../Images/Buttons/'+buttonsPath+'/cancel.gif" border="none" style="cursor:pointer;cursor:hand" onClick="HideNetDiv()">'
		addrowsText += '</Td></Tr></Table></Td></Tr></Table>'
		var addRowsDiv=document.getElementById("ezAddRows");
		if(addRowsDiv==null)
		{
			ezDiv=document.createElement("DIV");
			with(ezDiv)
			{
				id="ezAddRows";
				style.position="absolute";
				style.zIndex=500;
				style.visibility="inherit";
				style.top="20%";
				style.left="0%";
				style.width="100%";
				innerHTML=addrowsText;
			}
			document.body.appendChild(ezDiv);
			var inputObj=document.getElementById("Rownos")
			if(inputObj!=null){
				inputObj.focus();
			}
		}else{
			var inputObj=document.getElementById("Rownos")
			addRowsDiv.style.visibility="visible"
			if(inputObj!=null){
				inputObj.value="";
			inputObj.focus();
			}
		}
	}
	function HideNetDiv()
	{
		var addRowsDiv=document.getElementById("ezAddRows");
		addRowsDiv.style.visibility="hidden"
	}
