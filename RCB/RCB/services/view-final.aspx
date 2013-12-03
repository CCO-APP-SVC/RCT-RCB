<%@ Page Language="VB" AutoEventWireup="false" CodeFile="functions.aspx.vb" Inherits="functions" %>
<meta http-equiv="refresh" content="60">
<style>

.body {
    width: 1000px;
    text-align: center;
    margin-left : auto; margin-right : auto;
    margin-top: 5px;
}

#headerRight {
    background-image:url('../images/CadetsCanada.jpg');
    background-repeat:no-repeat;
    height: 50px;
    width: 100px;
    float: right;
} 

h1 {
    font-size: 18px;
    color: #565656;
    padding-bottom: 0px;
    margin-bottom: 0px;
}

h3 {
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

table {
    border-collapse:collapse;
    width: 1000px;
    margin-left : auto; margin-right : auto;
}

table,th, td {
    border: 1px solid black;
    padding: 2px;
    font-size: 12px;
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

.row-odd {
    background-color :#FEE5E5;
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
    color: red !important;
}

.bibg {
    color: green !important;
}

.biby {
    color: #FFCC00 !important;
}

</style>
<%

' Output variable  
Dim s As String
s = "<h2>Aucun r&eacutesultat pour le moment</h2><h2>No result for the moment</h2></div>"
Response.write( s )

%>
