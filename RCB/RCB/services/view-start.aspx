<%@ Page Language="VB" AutoEventWireup="false" CodeFile="functions.aspx.vb" Inherits="functions" %>

<style>

div.biabres {
    width: 545px;
}

div.biabres h1 {
    font-size: 18px;
    color: #FFFFFF;
    padding-bottom: 0px;
    margin-bottom: 0px;
}

div.biabres h3 {
    padding-top: 0px;
    margin-top: 0px;
    font-size: 12px;
    color: #565656;
}

#date {
    position: fixed;
    top: 15px;
    left: 350px;
    font-size: 12px;
    color: #565656;
}

div.biabres table {
    border-collapse:collapse;
    width: 100%;
}

div.biabres table th, 
div.biabres table td {
    border: 1px solid black;
    padding: 2px;
    font-size: 10px;
}

.columns {
    font-size: 10px;
    border: 2px solid black;
    text-align: center;
}

.bibnumber {
    text-align: center;
}

.club {
    text-align: center;
}

.misses {
    text-align: center;
}

.time {
    text-align: center;
}

.rank {
    text-align: center;
    font-weight: bold;
}

.row-odd {
    background-color :#FEE5E5;
}

.shootclass {
    background-color: #E0E0E0;
    font-size: 10px;
    text-align: center;
    font-weight: bold;
}

.teamclass td {
    background-color: #E0E0E0;
    font-size: 11px;
    padding: 5px;
    text-align: left;
    font-weight: bold;
}

.unitclass td {
    background-color: #f0f0f0;
    font-size: 11px;
    padding: 7px;
    text-align: center;
    font-weight: bold;
}


.title td {
    font-weight: bold;
    font-size: 14px; 
    border: none;
}

.rank1 {
    background-color: #DDAA30 !important;
}

.rank2 {
    background-color: #B2B2B4 !important;
}

.rank3 {
    background-color: #86551A !important;
}

.bibr {
    color: red;
}

.bibg {
    color: green;
}

.biby {
    color: #FFCC00;
}

.time {
    width: 50px;
}

</style>

<%

' Output variable  
Dim s As String

' Competition info
Dim sSqlComp As String
sSqlComp = "Select * From tblComp where id = " & Request.Params("cid")
Dim sqlDtSetComp As System.Data.DataSet = fnGetDataSetInDB(sSqlComp, "Comp")

' Switch competition type
' 1 = relay
' 2 = mass start
' 3 = pursuit
' 4 = patrol 
If sqlDtSetComp.Tables("Comp").Rows.Count >= 1 Then
    If sqlDtSetComp.Tables("Comp").Rows(0)("type") = 1 Then
         %><!--#include file="relay-start.aspx"--><%
    Else If sqlDtSetComp.Tables("Comp").Rows(0)("type") = 2 Then
         %><!--#include file="massStart-start.aspx"--><%
    Else If sqlDtSetComp.Tables("Comp").Rows(0)("type") = 3 Then
         %><!--#include file="pursuit-start.aspx"--><%
    Else If sqlDtSetComp.Tables("Comp").Rows(0)("type") = 4 Then
         %><!--#include file="patrol-start.aspx"--><%
    End If
End If

Response.write( s )

%>
