<%@ page import="jxl.Sheet,jxl.Workbook,jxl.read.biff.BiffException,jxl.write.*,jxl.format.*"%>
<%@ page import="java.awt.image.BufferedImage,java.io.ByteArrayOutputStream,javax.imageio.ImageIO,java.io.*,ezc.ezparam.*,java.util.*,java.io.*"%>

<%
	String fileName = "ItemsNACart.xls";
	WritableWorkbook workbook = null;
	response.setContentType("application/vnd.ms-excel");
	response.setHeader("Content-Disposition", "attachment; filename="+fileName);	
	
	ReturnObjFromRetrieve myRetERRSesGet = (ReturnObjFromRetrieve)session.getValue("myRetERRSes");

	try
	{
		int row=0;

		workbook = Workbook.createWorkbook(response.getOutputStream());
		WritableSheet ws = workbook.createSheet("Sheet0", 0);

		WritableFont custHeadFont = new WritableFont(jxl.write.WritableFont.TIMES, 11 , jxl.write.WritableFont.BOLD);
		WritableCellFormat custHeadCellFormat = new WritableCellFormat(custHeadFont);

		ws.addCell(new Label(0, row, "Product Code", custHeadCellFormat));
		ws.addCell(new Label(1, row, "Quantity", custHeadCellFormat));
		//ws.addCell(new Label(2, row, "Desired Date", custHeadCellFormat));
		//ws.addCell(new Label(3, row, "Program Type", custHeadCellFormat));
		ws.addCell(new Label(2, row, "My PO Line", custHeadCellFormat));
		ws.addCell(new Label(3, row, "My SKU", custHeadCellFormat));
		ws.addCell(new Label(4, row, "Job Quote", custHeadCellFormat));
		ws.addCell(new Label(5, row, "Job Quote Line", custHeadCellFormat));
		ws.addCell(new Label(6, row, "Reason For Not Adding to Cart", custHeadCellFormat));

		WritableFont custDetFont = new WritableFont(jxl.write.WritableFont.TIMES, 10);
		WritableCellFormat custDetCellFormat = new WritableCellFormat(custDetFont);
		//custDetCellFormat.setBackground(jxl.format.Colour.WHITE);
		
		for(int i=0;i<myRetERRSesGet.getRowCount();i++)
		{
			ws.addCell(new Label(0, row+1, myRetERRSesGet.getFieldValueString(i,"MATCODE_ERR"), custDetCellFormat));
			ws.addCell(new Label(1, row+1, myRetERRSesGet.getFieldValueString(i,"QTY_ERR"), custDetCellFormat));
			//ws.addCell(new Label(2, row+1, myRetERRSesGet.getFieldValueString(i,"DESIREDDATE_ERR"), custDetCellFormat));
			//ws.addCell(new Label(3, row+1, myRetERRSesGet.getFieldValueString(i,"PROGRAMTYPE_ERR"), custDetCellFormat));
			ws.addCell(new Label(2, row+1, myRetERRSesGet.getFieldValueString(i,"MYPO_ERR"), custDetCellFormat));
			ws.addCell(new Label(3, row+1, myRetERRSesGet.getFieldValueString(i,"MYSKU_ERR"), custDetCellFormat));
			ws.addCell(new Label(4, row+1, myRetERRSesGet.getFieldValueString(i,"QUOTE_NO"), custDetCellFormat));
			ws.addCell(new Label(5, row+1, myRetERRSesGet.getFieldValueString(i,"QUOTE_LINE"), custDetCellFormat));
			ws.addCell(new Label(6, row+1, myRetERRSesGet.getFieldValueString(i,"REASON"), custDetCellFormat));

			row++;
		}
	}
	catch(Exception e)
	{
		System.out.println("Exception in result set"+e);
	}
	finally
	{
		try{
			workbook.write();
			workbook.close();
		}catch(Exception ex){}
	}

%>

