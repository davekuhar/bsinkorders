<%@ Page Title="" Language="VB" MasterPageFile="~/MasterPage_BSInk.master" AutoEventWireup="false" CodeFile="ForgotLogin.aspx.vb" Inherits="ForgotLogin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:PasswordRecovery ID="PasswordRecovery1" runat="server" SuccessPageUrl="~/Login.aspx">
</asp:PasswordRecovery>
<p>
</p>
</asp:Content>

