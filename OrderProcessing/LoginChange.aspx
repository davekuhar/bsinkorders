<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage_BSInk.master" AutoEventWireup="false" CodeFile="LoginChange.aspx.vb" Inherits="OrderProcessing_LoginChange" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <asp:ChangePassword ID="ChangePassword1" runat="server" ContinueDestinationPageUrl="~/OrderProcessing/Order_Entry.aspx" CancelDestinationPageUrl="~/OrderProcessing/Order_Entry.aspx"></asp:ChangePassword>
</asp:Content>

