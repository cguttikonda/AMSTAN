<%@ page import="java.util.*,ezc.ezbasicutil.*,ezc.ezparam.*" %>
<%@ page import= "java.sql.*" %>
<jsp:useBean id="Session" class="ezc.session.EzSession" scope="session" />
<%
	
	java.util.Vector userVect=new java.util.Vector();
	
	userVect.add("BRIANT");
	userVect.add("SUNILA");
	userVect.add("PANKAJT");
	userVect.add("RRAMESH");
	userVect.add("VINODP");
	userVect.add("INDERJITB");
	userVect.add("KOHLISK");
	userVect.add("SANDEEPS");
	userVect.add("SREEPATHIG");
	userVect.add("VIKRAMP");
	userVect.add("MALVINDERS");
	userVect.add("KULDEEPS");
	userVect.add("SACHINSETH");
	userVect.add("NETRAVERMA");
	userVect.add("MURALEEP");
	userVect.add("MUKESHV");
	userVect.add("PARTHAS");
	userVect.add("RAHULG");
	
	java.util.Vector reportVect =  new java.util.Vector();
	boolean addRow = false;
	ReturnObjFromRetrieve reportRet = new ReturnObjFromRetrieve(new String[]{"USER_ID","QCF_NO","PRG_GRP","MATERIAL","MAT_DESC","RECEIVED_ON","SUBMITTED_ON"});
	String userId = Session.getUserId();
	Class.forName("com.microsoft.jdbc.sqlserver.SQLServerDriver");
	Connection connection = DriverManager.getConnection("jdbc:microsoft:sqlserver://10.6.4.106:1433;DatabaseName=ezranbaxypartners;SelectMethod=cursor","ezranbaxypartner","test");
	ResultSet rs = null;
	PreparedStatement stmt = connection.prepareStatement("select a.ewat_audit_no,a.ewat_doc_id,erd_material,erd_material_desc,ecad_value,a.ewat_date,a.ewat_comments from  EZC_WF_AUDIT_TRAIL a,ezc_rfq_header,ezc_rfq_details,EZC_CAT_AREA_DEFAULTS where erh_rfq_no=erd_rfq_no and erh_colletive_rfq_no=a.ewat_doc_id and erh_sys_key=ecad_sys_key and ecad_key='PURGROUP' and (ewat_audit_no in(select max(cast(b.ewat_audit_no as numeric)) from EZC_WF_AUDIT_TRAIL b where  b.ewat_source_participant = ? and a.ewat_doc_id=b.ewat_doc_id) or ewat_audit_no in(select max(cast(b.ewat_audit_no as numeric))-1 from EZC_WF_AUDIT_TRAIL b where  b.ewat_source_participant = ? and a.ewat_doc_id=b.ewat_doc_id) ) group by a.ewat_audit_no,a.ewat_doc_id,erd_material,erd_material_desc,ecad_value,a.ewat_date,ewat_comments order by ewat_doc_id,a.ewat_date;");
	
	
	for(int u=0;u<userVect.size();u++)
	{
		
		String preDocNo="";
		String currDocNo="";
		userId=(String)userVect.get(u);
		stmt.setString(1,userId);
		stmt.setString(2,userId);
		rs = stmt.executeQuery();
		
		while(rs.next())
		{
			currDocNo = rs.getString(2);

			if(!preDocNo.equals(currDocNo))
			{
				
				reportRet.setFieldValue("USER_ID",userId);
				reportRet.setFieldValue("QCF_NO",currDocNo);
				reportRet.setFieldValue("PRG_GRP",rs.getString(3));
				reportRet.setFieldValue("MATERIAL",rs.getString(4));
				reportRet.setFieldValue("MAT_DESC",rs.getString(5));
				reportRet.setFieldValue("RECEIVED_ON",rs.getString(6));
			}	
			else if(preDocNo.equals(currDocNo))
			{

				reportRet.setFieldValue("SUBMITTED_ON",rs.getString(6));


			}

			if(!"".equals(preDocNo) && !preDocNo.equals(currDocNo))
			{
				reportRet.addRow();
			}



			preDocNo=currDocNo;	


		}
	}
	
	for(int i=0;i<reportRet.getRowCount();i++){
		out.println(reportRet.getFieldValueString(i,"USER_ID")+"\t\t\t\t"+reportRet.getFieldValueString(i,"QCF_NO")+"\t\t\t\t"+reportRet.getFieldValueString(i,"PRG_GRP")+"\t\t\t\t"+reportRet.getFieldValueString(i,"MATERIAL")+"\t\t\t\t"+reportRet.getFieldValueString(i,"MAT_DESC")+"\t\t\t\t"+reportRet.getFieldValueString(i,"RECEIVED_ON")+"\t\t\t\t"+reportRet.getFieldValueString(i,"SUBMITTED_ON"));
	}
%>