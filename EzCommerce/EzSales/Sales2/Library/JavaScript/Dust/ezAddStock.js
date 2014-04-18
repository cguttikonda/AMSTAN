	function ezAddNewRow(tabNo)
 	{
 		if(tabCount==0)
 			tabCount=tabNo;
		var tabObj=document.getElementById("InnerBox1Tab")
		var rowItems = tabObj.getElementsByTagName("tr");
		var rowCountValue = rowItems.length;
		var rowId = tabObj.insertRow(rowCountValue);
		elementsArray=new Array();
		elementsArray[0] ='<select name="product"  onChange="displayPack(this,'+rowCount+')"  tabIndex='+parseInt(tabCount)+1+' style="width:100%"><option value="">'+selProductLable+'</option>'
		for(objLen=0;objLen<myProducts.length;objLen++)
			elementsArray[0] += '<option value='+myProducts[objLen].code+'>'+myProducts[objLen].desc+'</option>'
		elementsArray[0] += '</select>'
		elementsArray[1]='<input type="text" class="tx" size=3  name=pack  style="text-align:left"  readonly>'
		elementsArray[2]='<input type="text" class="tx" size=6  name=unitPrice  style="text-align:left"  readonly>'
        	elementsArray[3]='<input type="text" class="inputBox" name="OpenBal"  style="text-align:right"  tabIndex='+parseInt(tabCount)+1+' size=8 maxlength="9" value="0" onBlur="validateField(this,'+rowCount+',0)">'
		//elementsArray[4]='<input type="text" class="tx" name="receipt"   style="text-align:right"  size=8 maxlength="9" value="0" readonly>'
		elementsArray[4]='<input type="text" class="inputBox" name="receipt"   style="text-align:right"  size=8 maxlength="9" value="0" onBlur="validateField(this,'+rowCount+',0)">'
		elementsArray[5]='<input type="text" class="inputBox" name="Returnmrk" style="text-align:right" tabIndex='+parseInt(tabCount)+1+' size=8 maxlength="9" value="0" onBlur="validateField(this,'+rowCount+',0)">'
		elementsArray[6]='<input type="text" class="inputBox" name="sales" style="text-align:right" tabIndex='+parseInt(tabCount)+1+' size=8 maxlength="9" value="0" onBlur="validateField(this,'+rowCount+',0)">'
		elementsArray[7]='<input type="text" class="inputBox" name="Returnco" style="text-align:right" tabIndex='+parseInt(tabCount)+1+' size=8 maxlength="9" value="0" onBlur="validateField(this,'+rowCount+',0)">'
		//elementsArray[8]='<input type="text" class="tx" name="CloseBal"  style="text-align:right;"   size=8 maxlength="9" value="0" readonly>'
		elementsArray[8]='<input type="text" class="inputBox" name="CloseBal"  style="text-align:right;"   size=8 maxlength="9" value="0" onBlur="validateField(this,'+rowCount+',0)" >'
		elementsArray[9]='<input type="text" class="inputBox" name="Transit" style="text-align:right" tabIndex='+parseInt(tabCount)+1+' size=8 maxlength="9" value="0" onBlur="validateField(this,'+rowCount+',0)">'
		elementsArray[10]='<input type="hidden" name="text3"><a href="JavaScript:showText('+rowCount+')"><image src="../../Images/Buttons/'+buttonsPath+'/text.gif" border=0  style={text-decoration:none}>'
		eleWidth = new Array();

		eleWidth[0] = "18%";
		eleWidth[1] = "5%";
		eleWidth[2] = "9%";
		eleWidth[3] = "9%";
		eleWidth[4] = "9%";
		eleWidth[5] = "9%";
		eleWidth[6] = "9%";
		eleWidth[7] = "9%";
		eleWidth[8] = "9%";
		eleWidth[9] = "9%";
		eleWidth[10] = "5%";

		len=elementsArray.length
		for (i=0;i<len;i++){
			cell0Data = elementsArray[i]
			cell0=rowId.insertCell(i);
			cell0.innerHTML=cell0Data;
			if((i==1)||(i==2))
				cell0.align="left";
			else
				if(i==len-1)
					cell0.align="center";
				else
					cell0.align="right";
			cell0.width= eleWidth[i]
		}
 		rowCount++;

	}

	function moreProdLines(tabNo){
		if(chkEmpty())
		{
			if(document.all){
				retVal=showModalDialog('../Sales/ezDialogBox.jsp'," ",'center:yes;dialogWidth:35;dialogHeight:12;status:no;minimize:yes');
				moreRows(tabNo,retVal)
			}else{
				createPopUPWindow(tabNo)
			}
		}
	}
	function moreRows(tabNo,retVal)
	{	var flag=false;
		if (!( eval(retVal) == "undefined") && retVal != null)
		{
	  		if ((retVal!=null)&&(retVal > 0)){
	 			if (parseInt(retVal) > 30 ){
  					alert("Customer have only 30 Product to enter Stock Info");
	 			}else{
  					for (lineCount=0;lineCount<retVal;lineCount++){
	  					ezAddNewRow(tabNo);
					flag=true;
					}
  				}
 			}
			if(flag)
			{
			butObj=document.getElementById("button_submit");
			if (butObj!=null)
				if(butObj.style.display=="none")
					butObj.style.display="block";
			spobj1=document.getElementById("DivNoStock");
			if (spobj1!=null)
				spobj1.style.visibility="hidden";
			headObj=document.getElementById("theads");
			if (headObj!=null)
				headObj.style.visibility="visible";
			linesDiv=document.getElementById("InnerBox1Div")
  			if(linesDiv!=null){
				linesDiv.style.height="160"
				linesDiv.style.visibility="visible"
			}
			setScroll()
			
		
			if(retVal==1 && lines==false)
			{
				document.forms[0].product.focus()
				lines=true
			}
			else
			{
				document.forms[0].product[document.forms[0].product.length-retVal].focus()
				lines=true
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
