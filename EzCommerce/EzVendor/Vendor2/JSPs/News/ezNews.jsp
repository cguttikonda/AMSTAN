<%@ include file="../../../Includes/JSPs/News/iNews.jsp"%>
<%
	if(newsCount > 0)
	{
%>
		<Div id='newsDiv' style='position:absolute;background-color:#FFFFFF;top:75%;width:100%;height:20%;align:center' align=center>
		<center>
		<Table width="60%" height="60%" border="0" cellspacing="0" cellpadding="0" align=center valign=center>
		<Tr>
			<Td height="5" style="background-color:'#F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c1.gif"></Td>
			<Td height="5" style="background-color:'#F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e1.gif"></Td>
			<Td height="5" style="background-color:'#F3F3F3'" width="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"><img height="5" width="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c2.gif"></Td>
		</Tr>
		<Tr >
			<Td width="5" style="background-color:'#F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"><img width="5" height="1" src="../../../../EzCommon/Images/Table_Corners/Cb_e2.gif"></Td>
			<Td style="background-color:'#F3F3F3'" valign=middle>
				<Table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" valign=center>
				<TR height=10%><TD align=left style="background-color:'#F3F3F3'"><B>News</B></TD></TR>
				<TR><TD style="background-color:'#F3F3F3'">

					<style type="text/css">
						#pscroller1
						{
							width			: '100%';
							height			: '100%';
							border			: 0px solid black;
							padding			: 5px;
							background-color	: #F3F3F3;
						}
						#pscroller2
						{
							width	: 350px;
							height	: 20px;
							border	: 1px solid black;
							padding	: 3px;
						}

						#pscroller2 a
						{
							text-decoration: none;
						}

						.someclass
						{
							//class to apply to your scroller(s) if desired
						}
						a:hover
						{
							color:red;
							text-decoration:none;
						}
					</style>
					<script type="text/javascript">
					var newsData=new Array()
<%
					String newsText = "";
					newsId 		= "";
					newsRet.toEzcString();
					for(int i=0;i<newsCount;i++)
					{
						newsId 	 = newsRet.getFieldValueString(i,"EZN_ID").trim();
						newsText = newsRet.getFieldValueString(i,"EZN_TEXT").trim();
						if(newsText.length() > 200)
						{
							newsText = newsText.substring(0,200);
							newsText = newsText.substring(0,newsText.lastIndexOf(" "))+"..........";
						}	
						else	
							newsText += "..........";
%>
						newsData[<%=i%>]="<a href ='#' onClick='news(<%=newsId%>)' style='cursor:hand;'><%=replaceStr(newsText,"<BR>"," ")%></a>";
<%
					}
%>
					function pausescroller(content, divId, divClass, delay)
					{
						this.content=content
						this.tickerid=divId
						this.delay=delay
						this.mouseoverBol=0
						this.hiddendivpointer=1
						document.write('<div id="'+divId+'" class="'+divClass+'" style="position: relative; overflow: hidden"><div class="innerDiv" style="position: absolute; width: 100%" id="'+divId+'1">'+content[0]+'</div><div class="innerDiv" style="position: absolute; width: 100%; visibility: hidden" id="'+divId+'2">'+content[1]+'</div></div>')
						var scrollerinstance=this
						if (window.addEventListener)
							window.addEventListener("load", function(){scrollerinstance.initialize()}, false)
						else if (window.attachEvent)
							window.attachEvent("onload",function(){scrollerinstance.initialize()})
						else if (document.getElementById) //if legacy DOM browsers, just start scroller after 0.5 sec
							setTimeout(function(){scrollerinstance.initialize()}, 500)
					}

					pausescroller.prototype.initialize=function()
					{
						this.tickerdiv		=document.getElementById(this.tickerid)
						this.visiblediv		=document.getElementById(this.tickerid+"1")
						this.hiddendiv		=document.getElementById(this.tickerid+"2")
						this.visibledivtop	=parseInt(pausescroller.getCSSpadding(this.tickerdiv))
						this.visiblediv.style.width		=this.hiddendiv.style.width=this.tickerdiv.offsetWidth-(this.visibledivtop*2)+"px"
						this.getinline(this.visiblediv, this.hiddendiv)
						this.hiddendiv.style.visibility	= "visible"
						var scrollerinstance=this
						document.getElementById(this.tickerid).onmouseover=function(){scrollerinstance.mouseoverBol=1}
						document.getElementById(this.tickerid).onmouseout=function(){scrollerinstance.mouseoverBol=0}
						if (window.attachEvent)
							window.attachEvent("onunload", function(){scrollerinstance.tickerdiv.onmouseover=scrollerinstance.tickerdiv.onmouseout=null})
						setTimeout(function(){scrollerinstance.animateup()}, this.delay)
					}


					pausescroller.prototype.animateup=function()
					{
						var scrollerinstance=this
						if (parseInt(this.hiddendiv.style.top)>(this.visibledivtop+5))
						{
							this.visiblediv.style.top=parseInt(this.visiblediv.style.top)-5+"px"
							this.hiddendiv.style.top=parseInt(this.hiddendiv.style.top)-5+"px"
							setTimeout(function(){scrollerinstance.animateup()}, 50)
						}
						else
						{
							this.getinline(this.hiddendiv, this.visiblediv)
							this.swapdivs()
							setTimeout(function(){scrollerinstance.setmessage()}, this.delay)
						}
					}

					pausescroller.prototype.swapdivs=function()
					{
						var tempcontainer=this.visiblediv
						this.visiblediv=this.hiddendiv
						this.hiddendiv=tempcontainer
					}

					pausescroller.prototype.getinline=function(div1, div2)
					{
						div1.style.top=this.visibledivtop+"px"
						div2.style.top=Math.max(div1.parentNode.offsetHeight, div1.offsetHeight)+"px"
					}

					pausescroller.prototype.setmessage=function()
					{
						var scrollerinstance=this
						if (this.mouseoverBol==1) //if mouse is currently over scoller, do nothing (pause it)
							setTimeout(function(){scrollerinstance.setmessage()}, 100)
						else
						{
							var i=this.hiddendivpointer
							var ceiling=this.content.length
							this.hiddendivpointer=(i+1>ceiling-1)? 0 : i+1
							this.hiddendiv.innerHTML=this.content[this.hiddendivpointer]
							this.animateup()
						}
					}

					pausescroller.getCSSpadding=function(tickerobj)
					{
						if (tickerobj.currentStyle)
							return tickerobj.currentStyle["paddingTop"]
						else if (window.getComputedStyle) //if DOM2
							return window.getComputedStyle(tickerobj, "").getPropertyValue("padding-top")
						else
							return 0
					}
					new pausescroller(newsData, "pscroller1", "someclass", 2000)
					</script>
				</TD></TR>
				</Table>
			</Td>
			<Td width="5" style="background-color:'#F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e3.gif"><img width="5" height="1" src="Cb_e3.gif"></Td>
		</Tr>
		<Tr>
			<Td width="5" style="background-color:'#F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c3.gif"></Td>
			<Td height="5" style="background-color:'#F3F3F3'" background="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"><img width="1" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_e4.gif"></Td>
			<Td width="5" style="background-color:'#F3F3F3'" height="5" background="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"><img width="5" height="5" src="../../../../EzCommon/Images/Table_Corners/Cb_c4.gif"></Td>
		</Tr>
		</Table>
		</center>
		</Div>		
<%
	}
%>