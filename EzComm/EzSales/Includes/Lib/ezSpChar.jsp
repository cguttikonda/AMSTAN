<%@ page import="java.util.*" %>
<%!
	public static String replaceSp(String theString,String from,String to) 
	{ 
		String ret=theString; 
		int go=0; 
		if(ret!=null)
		{
			while (ret.indexOf(from,go)>=0) 
			{ 
				go=ret.indexOf(from,go); 
				ret=ret.substring(0,go)+to+ret.substring(go+from.length()); 
				go=go+to.length(); 
			} 
		}
		return ret; 

	} 
	public static String enSp(String input)
	{
		String output = input;
		if(input!=null)
		{
			/*		
				< --- &lt;
				> --- &gt;
				& --- &amp;
				" --- &quot;
				' --- &#39;
				( --- &#40;
				) --- &#41;
				# --- &#35;
				% --- &#37;
				; --- &#59;
				+ --- &#43;
				- --- &#45;
			*/
			input = deSp(input);
			output = replaceSp(output,"&","&amp;");
			output = replaceSp(output,"#","&#35;");
			output = replaceSp(output,";","&#59;");
			output = replaceSp(input,"<","&lt;");
			output = replaceSp(output,">","&gt;");
			output = replaceSp(output,"\"","&quot;");
			output = replaceSp(output,"'","&#39;");
			output = replaceSp(output,"(","&#40;");
			output = replaceSp(output,")","&#41;");
			output = replaceSp(output,"%","&#37;");
			output = replaceSp(output,"+","&#43;");
			output = replaceSp(output,"-","&#45;");
		}
		return output;
	}
	public static String deSp(String input)
	{
		String output = input;
		if(input!=null)
		{
		
			/*		
				< --- &lt;
				> --- &gt;
				& --- &amp;
				" --- &quot;
				' --- &#39;
				( --- &#40;
				) --- &#41;
				# --- &#35;
				% --- &#37;
				; --- &#59;
				+ --- &#43;
				- --- &#45;
			*/

			output = replaceSp(input,"&lt;","<");
			output = replaceSp(output,"&gt;",">");
			output = replaceSp(output,"&amp;","&");
			output = replaceSp(output,"&quot;","\"");
			output = replaceSp(output,"&#39;","'");
			output = replaceSp(output,"&#40;","(");
			output = replaceSp(output,"&#41;",")");
			output = replaceSp(output,"&#35;","#");
			output = replaceSp(output,"&#37;","%");
			output = replaceSp(output,"&#59;",";");
			output = replaceSp(output,"&#43;","+");
			output = replaceSp(output,"&#45;","-");
		}
		return output;
	}
	
%>
<Script>
	function isSplChar(str)
	{
		var spchar, getChar, SpecialChar;
		spchar="`()(\\~!@^&*+\"|%:=,<>";

		getChar='Empty';
		SpecialChar='No';

		var spchars =" ` ( )  \\ ~ ! @ ^ & * + \" | % : =  , < > ";
		//var dbEle = new Array("SELECT","DELETE","UPDATE","INSERT","ALTER","DROP");
		var dbElement='No';

		for(var i=0;i<str.length;i++)
		{
			for(var j=0;j<spchar.length;j++)
			{
				if(str.charAt(i)== spchar.charAt(j))
				{
					SpecialChar='Yes';
					break;
				}
				else
				{
					if(str.charAt(i)!=' ')
					getChar='Normal';
				}
			}
		}
		if(SpecialChar == 'Yes')
		{
			alert("Please do not enter any of the following characters: \n " + spchars);
			return false;
		}
		else if(SpecialChar == 'No')
		{
			/*str = str.toUpperCase();
			
			for(var i=0;i<dbEle.length;i++)
			{
				var chkDbEle = dbEle[i];
				
				if(str.indexOf(chkDbEle)!=-1)
				{
					dbElement='Yes';
					break;
				}
			}
			if(dbElement == 'Yes')
			{
				alert("Please do not enter the word: "+chkDbEle);
				return false;
			}
			else if(dbElement == 'No')
			{*/
				return true;
			//}
		}
	}
</Script>
 