function funPrint()
{
	try
	{
		divToPopUp=top.display.document.getElementById("ezPageHelp");
		if(divToPopUp==null)
		{
			divToPopUp=top.display.document.createElement("DIV");
			with(divToPopUp)
			{
				id="ezPageHelp";
				style.position="absolute";
				innerHTML="EzCommerce";
				style.visibility="hidden";
				style.backgroundColor="#155293"
			}
			top.display.document.body.appendChild(divToPopUp);
		}
		myUrl=top.display.document.location.href;
		myUrl=myUrl.substring(myUrl.lastIndexOf("/",myUrl.indexOf(".",myUrl.indexOf("EzCommerce")))+1,myUrl.length);
		myURL1=myUrl.substring(myUrl.lastIndexOf("/",myUrl.indexOf("."))+1,myUrl.indexOf("."));
		if(top.display.document.all.tags("DIV").InnerBox1Div!=null)
		{
			var myTabWidth = top.display.document.all.tags("DIV").InnerBox1Div.style.width
			top.display.document.all.tags("DIV").InnerBox1Div.style.height="100%"
			top.display.document.all.tags("DIV").InnerBox1Div.style.width="90%"
			top.display.document.all.tags("DIV").InnerBox1Div.style.overflow = "visible";
			top.display.document.all.tags("DIV").ButtonDiv.style.visibility="hidden";

			window.parent.display.focus();
			window.print()

			top.display.document.all.tags("DIV").InnerBox1Div.style.height = "40%";
			if(myTabWidth=='92%')
				top.display.document.all.tags("DIV").InnerBox1Div.style.width="92%"
			top.display.document.all.tags("DIV").InnerBox1Div.style.overflow = "auto";
			top.display.document.all.tags("DIV").ButtonDiv.style.visibility="visible";
		}
		else
		{
			alert("You Cannot Print this Page.")
		}
	}
	catch(myerror)
	{
	}
}