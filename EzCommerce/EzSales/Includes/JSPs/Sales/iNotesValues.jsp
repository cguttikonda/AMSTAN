<%@ page import = "ezc.ezbasicutil.*" %>
<%
	String[] HeaderNotesD=new String[]{"generalNotes","packingInstructions","labelInstructions","inspectionClauses","handlingSpecifications","regulatoryRequirements","documentsRequired","others"} ;
	String[] HeaderNotes=new String[8];
	String[] HeaderNotesT=new String[]{"Special Remarks",pacins_L,labins_L,insclas_L,hanspec_L,regreq_L,docreq_L,others_L} ;
	String generalNotes = sdHeader.getFieldValueString(0,"TEXT1");

	if(generalNotes != null)
	{
		EzStringTokenizer st = new EzStringTokenizer(generalNotes,"^^ezc^^");
		try{
			for(int j=0;j <HeaderNotes.length ;j++)
			{
				HeaderNotes[j] = (String)st.getTokens().elementAt(j);
			 	EzStringTokenizer st1 = new EzStringTokenizer(HeaderNotes[j],"@@ezc@@");
				String temp_2 = (String) st1.getTokens().elementAt(1);
				HeaderNotes[j] = ("null".equals(temp_2) || temp_2== null || temp_2.trim().length()==0)?"None":temp_2;
			}
		}catch(Exception e)
		{
		}
	}
%>