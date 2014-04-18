<%@ page import="javax.xml.parsers.*,
		 org.w3c.dom.*,
		 javax.xml.transform.*,
		 javax.xml.transform.dom.DOMSource,
		 java.io.FileOutputStream,
		 javax.xml.transform.stream.StreamResult"
%>
<%
	String flag = request.getParameter("flag");
	String MenuKey = request.getParameter("MenuKey");
	String Mfile ="";
%>
<Html>
<Head>
<link rel="stylesheet" href="../../Library/Styles/Theme1.css">
<script>
var tabHeadWidth=80
var flag = "<%=flag%>";

	
function chk()
{
	var aDom	= new ActiveXObject("MSXML.DOMDocument");
	aDom.async	= false;
	var file;
	var userroles = "<%=MenuKey%>";
	if(userroles=="null")
	{
		alert(document.myForm.MenuKey.value)
	}
		
		if("CU" == userroles)
		{
			file = "ezSalesCUMenu.xml"
		}
		else if("LF" == userroles)
		{
			file = "ezSalesLFMenu.xml"
		}
		else if("CM" == userroles)
		{
			file = "ezSalesCMMenu.xml"
		}
		else if("RM" == userroles)
		{
			file = "ezSalesRMMenu.xml"
		}
		else
		{
			file = "ezSalesCUMenu.xml"
		}
	aDom.load("../../../../../EzAdmin/EzAdmin4/Admin1/JSPs/Config/"+file);
	var h		= aDom.documentElement;

	if(document.myForm.rdo!=null)
	{
		for(var i=0;i<document.myForm.rdo.length;i++) //document.myForm.rdo.length
		{
			var str		= document.myForm.rdo[i].value;
			var str1	= str.split('#');
			var id		= str1[0];
			var childs	= str1[2];
			
			var nodeName	= str1[1];
			var nodeNameArray= nodeName.split('$');

		
			if(nodeNameArray!=null)
				nodeName			= nodeNameArray[0];
				
			var currentArray = h.getElementsByTagName(nodeName);
			var currenArr;
			for(var k=0; k<currentArray.length; k++)
			{
				currenArr	= currentArray.item(k);
				
				if(currenArr.getAttribute("status")=='Y' && currenArr.getAttribute("id")==id)
				{
					document.myForm.rdo[i].checked=true;
				}
				else if(currenArr.getAttribute("status")=='N' && currenArr.getAttribute("id")==id)
				{
					for(var j=0;j<childs;j++)
					{
						document.myForm.rdo[i].checked=false;
						i++;
					}
				}
			}
		}
	}
	if(flag =="true")
		alert("Updated Successfully");
}
function update()
{
	if(document.myForm.rdo!=null)
	{
		var str1="";
		for(var i=0;i<document.myForm.rdo.length;i++) //document.myForm.rdo.length
		{
			if(!document.myForm.rdo[i].checked)
			{
				var str	= document.myForm.rdo[i].value;
				str1	= str1+str+"*";
			}
		}
	}
	document.myForm.updtvls.value	= str1;
	document.myForm.action		= "ezAddSBUOption.jsp";
	document.myForm.submit();
}
function back()
{
	document.myForm.action	= "ezCustomMenu.jsp";
	document.myForm.submit();
}
function chkChilds(obj)
{

	var str 	= obj.value;
	var str1	= str.split('#');

	if(str1[2]!=null)
	{
		var index	= str1[3]
		for(var i=1;i<=str1[2];i++)
		{
			var index1	= parseInt(index)+parseInt(i);
			if(document.myForm.rdo[index].checked==false)
			{
				document.myForm.rdo[index1].checked=false;
			}
			else
			{
				document.myForm.rdo[index1].checked=true;
			}
		}
	}
	else
	{
		var parentIndexArray	= str1[1].split('$');

		if(parentIndexArray!=null)
		{
			parentIndex	=parentIndexArray[1];
			if(parentIndex!=null)
			{
				if(obj.checked && document.myForm.rdo[parentIndex].checked==false)
				{
					document.myForm.rdo[parentIndex].checked=true;
				}
			}
		}
	}

}
</Script>
<Script src="../../Library/JavaScript/ezTabScroll.js"></script>

</Head>
<Body scroll=no onLoad="chk();scrollInit()" onResize = 'scrollInit()' >

<Form name="myForm" method="POST">
<Input type="hidden" name="updtvls" value="">
<input type="hidden" name="MenuKey" value="<%=MenuKey%>">
<div id="theads">
<Table id="tabHead" border=1 align='center' borderColorDark="#ffffff" borderColorLight="#000000" cellPadding=2 cellSpacing=0>
	<Tr align="center">
    		<Td class="displayheader" width="70%" ><B>Sales Menu</B></Td>
	</Tr>
</Table>
</Div>
<DIV id="InnerBox1Div">
<Table  id="InnerBox1Tab" align=center border=1 borderColorDark=#ffffff borderColorLight=#000000 cellPadding=2 cellSpacing=0 >
<%	
	
	if("CU".equals(MenuKey))
	{
		Mfile = "ezSalesCUMenu.xml";
	}
	else if("LF".equals(MenuKey))
	{
		Mfile = "ezSalesLFMenu.xml";
	}
	else if("CM".equals(MenuKey))
	{
		Mfile = "ezSalesCMMenu.xml";
	}
	else if("RM".equals(MenuKey))
	{
		Mfile = "ezSalesRMMenu.xml";
	}
	else
	{
		Mfile = "ezSalesCUMenu.xml";
	}
	
	
%>
	<input type="hidden" name="MfileName" value="<%=Mfile%>">
<%	
	String fileName 	= "D:\\jboss-4.0.3SP1\\server\\default\\deploy\\EzCommerce.war\\EzCommerce\\EzAdmin\\EzAdmin4\\Admin1\\JSPs\\Config\\"+Mfile;
		
	java.io.File file	= new java.io.File(fileName); 
	try
	{
		DocumentBuilderFactory docFactory	= javax.xml.parsers.DocumentBuilderFactory.newInstance();
		DocumentBuilder docBuilder 		= docFactory.newDocumentBuilder();
		Document doc	= docBuilder.parse(file);
		Element root	= doc.getDocumentElement();

		NodeList level1List 	= null;
		NodeList level2List 	= null;
		Node node 		= null; 
		Node node1 		= null; 
		Element	level1Ele 	= null;
		Element	level2Ele 	= null;
		String level1Str	= "";
		String level2Str	= "";
		int count		= 0;
		int level1childs	= 0;
		int level2childs	= 0;
		int parentIndex		= 0;
		int level1Len		= 0;
		int level2Len		= 0;
		String[] mainArr 	= {"Orders","Web Stats","Self Services","Shipments","Physician","Mail","Catalog"};
		level1List		= root.getChildNodes();
		level1Len		= level1List.getLength();
		String tagName1		= "";
		int tagCount 		= 0;
		for(int i=0;i<level1Len;i++)
		{
			
				node 	= level1List.item(i);
				if((node.getNodeName().trim())!="#text" )
				{
				
					String tagName2	= node.getNodeName();					
					
					if(tagName1 != tagName2 && !tagName1.equals(tagName2))
					{
%>						
						<tr>
							<td width="33%"><%=mainArr[tagCount]%></td>
							<td width="33%">&nbsp;</Td>
							<td width="33%">&nbsp;</td>
						</tr>
<%
						tagCount++;
					}
					
					
					level1Ele	= (Element)level1List.item(i);	
					level1childs 	= level1Ele.getChildNodes().getLength()-5;
					//out.println("level1childs  "+level1childs);
					level1childs 	= level1childs/2;
					level1Str 	= level1Ele.getAttribute("id")+"#"+level1Ele.getTagName()+"#"+level1childs+"#"+count;	
								
%>
					<tr>
						<td width="33%">&nbsp;</td>
						<td width="33%"><Input type=checkbox name="rdo" value="<%=level1Str%>" onClick="chkChilds(this)"><%=level1Ele.getAttribute("id")%></Td>
						<td width="33%">&nbsp;</td>
					</tr>	
<%		
					parentIndex = count;
					count++;
					if(node.hasChildNodes())
					{
						level2List 	= node.getChildNodes();
						level2Len 	= level2List.getLength();

						for(int j=0;j<level2Len;j++)
						{
							node1 = level2List.item(j);
							
							if((node1.getNodeName().trim())!="#text" )
							{
								level2Ele	= (Element)level2List.item(j);	
								level2childs 	= level2Ele.getChildNodes().getLength()-5;
								level2childs 	= level2childs/2;
								level2Str = level2Ele.getAttribute("id")+"#"+level2Ele.getTagName();

								if(j>5 && j<=level2Len)
								{
									level2Str = level2Ele.getAttribute("id")+"#"+level2Ele.getTagName()+"$"+parentIndex;
	%>
									<tr>
										<td width="33%">&nbsp;</td>
										<td width="33%">&nbsp;</td>
										<td width="33%"><Input type=checkbox name="rdo" value="<%=level2Str%>" onClick="chkChilds(this)"><%=level2Ele.getAttribute("id")%></Td>
									</tr>
	<%	
									count++;		
								}
							}	
						}
					}
					tagName1 = tagName2;
						

				}
		}
	}				
	catch(Exception e)
	{
		out.println(e);
	}
%>
</table>
</div>
	<Div  style="position:absolute;overflow:auto;top:90%;width:100%" align="center">
		<Table>
			<Tr>
				<Td>
					<a href="JavaScript:update()"><img src="../../Images/Buttons/LAVENDER/update.gif" border=none></img></a>
					<a href="JavaScript:back()"><img src="../../Images/Buttons/LAVENDER/back.gif" border=none></img></a>

				</Td>
			</Tr>
		</Table>
	</Div>
</form>
</body>
</html>