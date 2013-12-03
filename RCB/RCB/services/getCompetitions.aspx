<%@ Page Language="VB" AutoEventWireup="false" CodeFile="functions.aspx.vb" Inherits="functions" %>
<%

Dim sSql As String

sSql = "Select eid, [title-fr], [title-en], lastDate, id, [type], [showFinal] From tblComp where eid = " & Request.Params("eid")

Dim sqlDtSet As System.Data.DataSet = fnGetDataSetInDB(sSql, "Comp")
            
If sqlDtSet.Tables("Comp").Rows.Count >= 1 Then

   ' Dim MyDoc as New System.Xml.XmlDocument
   ' MyDoc.LoadXml(sqlDtSet.getxml())
   ' Dim Comps as String = MyDoc.SelectSingleNode("//NewDataSet").InnerXml
Response.ContentType = "application/xml"
    Response.Write(sqlDtSet.getxml())
Else
    Response.Write("")
End If
%>
