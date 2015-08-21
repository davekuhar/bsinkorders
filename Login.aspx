<%@ Page Title="Braden Sutphin Order Login" Language="VB" MasterPageFile="~/MasterPage_BSInk.master" AutoEventWireup="false" CodeFile="Login.aspx.vb" Inherits="Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Login ID="Login1" runat="server" DestinationPageUrl="~/OrderProcessing/Order_Entry.aspx">
</asp:Login>
<asp:HyperLink ID="hypeForgotPassword" runat="server" NavigateUrl="~/ForgotLogin.aspx">Forgot Password</asp:HyperLink>
&nbsp;
</asp:Content>

