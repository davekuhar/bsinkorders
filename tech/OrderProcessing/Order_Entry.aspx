<%@ Page Title="Order Entry" Language="VB" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeFile="Order_Entry.aspx.vb" Inherits="OrderProcessing_Order_Entry" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxtoolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


    &nbsp;<asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
                <table style="width: 100%" id="tableMenu">
                    <tr>
                        <td style="width: 100px">
                            <asp:LinkButton ID="lbCopyOrder" runat="server" ToolTip="Select an order from the list and copy it's contents to a new order" CommandArgument="1">Order History</asp:LinkButton></td>
                        <td style="width: 100px">
                <asp:LinkButton ID="lbNewPMS" runat="server" ToolTip="Select items to order by selecting the Pantone Number" CommandArgument="3">New Colors</asp:LinkButton></td>
                        <td style="width: 100px">
                <asp:LinkButton ID="lbAddlItems" runat="server" ToolTip="Review a list of all my items" CommandArgument="2">All My Items</asp:LinkButton></td>
                        <td style="width: 100px">
                <asp:LinkButton ID="lbOpenOrders" runat="server" CommandArgument="4">Open Orders</asp:LinkButton></td>
                        <td style="width: 100px">
                        </td>
                        <td style="width: 100px">
                        </td>
                        <td style="width: 100px">
                        </td>
                        <td style="width: 100px">
                <asp:LinkButton ID="lblCart" runat="server" CommandArgument="0">View Cart</asp:LinkButton>
                        </td>
                        <td style="width: 100px">
                        </td>
                        <td style="width: 100px">
                            <asp:LoginName ID="LoginName1" runat="server" />
                        </td>
                        <td style="width: 100px">
                            <asp:LoginView ID="LoginView1" runat="server">
                                <LoggedInTemplate>
                                    <asp:LoginStatus ID="LoginStatus1" runat="server" />
                                </LoggedInTemplate>
                            </asp:LoginView>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100px">
                        </td>
                        <td style="width: 100px">
                        </td>
                        <td style="width: 100px">
                        </td>
                        <td style="width: 100px">
                        </td>
                        <td style="width: 100px">
                        </td>
                        <td style="width: 100px">
                        </td>
                        <td style="width: 100px">
                        </td>
                        <td style="width: 100px">
                        </td>
                        <td style="width: 100px">
                        </td>
                        <td style="width: 100px">
                            <asp:FormView ID="fvCartCount" runat="server" DataKeyNames="ORDER_CUST_CODE" DataSourceID="odsOrderCount">
                                <EditItemTemplate>
                                    ORDER_CUST_CODE:
                                    <asp:Label ID="ORDER_CUST_CODELabel1" runat="server" Text='<%# Eval("ORDER_CUST_CODE") %>'>
                                    </asp:Label><br />
                                    Expr1:
                                    <asp:TextBox ID="Expr1TextBox" runat="server" Text='<%# Bind("Expr1") %>'>
                                    </asp:TextBox><br />
                                    <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                                        Text="Update">
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                        Text="Cancel">
                                    </asp:LinkButton>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    ORDER_CUST_CODE:
                                    <asp:TextBox ID="ORDER_CUST_CODETextBox" runat="server" Text='<%# Bind("ORDER_CUST_CODE") %>'>
                                    </asp:TextBox><br />
                                    Expr1:
                                    <asp:TextBox ID="Expr1TextBox" runat="server" Text='<%# Bind("Expr1") %>'>
                                    </asp:TextBox><br />
                                    <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
                                        Text="Insert">
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                        Text="Cancel">
                                    </asp:LinkButton>
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    Line Items:
                                    <asp:Label ID="Expr1Label" runat="server" Text='<%# Bind("Expr1") %>'></asp:Label><br />
                                </ItemTemplate>
                            </asp:FormView>
                            <asp:ObjectDataSource ID="odsOrderCount" runat="server" OldValuesParameterFormatString="original_{0}"
                                SelectMethod="GetDataCount" TypeName="OrderProcessingTableAdapters.DetailsCountTableAdapter">
                                <SelectParameters>
                                    <asp:SessionParameter Name="ORDER_CUST_CODE" SessionField="CUST_CODE" Type="String" />
                                </SelectParameters>
                            </asp:ObjectDataSource>
                        </td>
                        <td style="width: 100px">
                        </td>
                    </tr>
                </table>
                <asp:MultiView ID="MultiView1" runat="server" >
                    <asp:View ID="View_Current_Order" runat="server">
                        <table width:"99%" style="border-right: black thin solid; border-top: black thin solid; border-left: black thin solid; border-bottom: black thin solid">
                            <tr>
                                <td colspan="2" style="text-align: center" vertical-align:"top">
                                    <h2>
                                        Cart
                                    </h2>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 65%; text-align: center; border-right: black thin solid; border-top: black thin solid; border-left: black thin solid; border-bottom: black thin solid; height: 221px;" vertical-align:"top">
                                    &nbsp;Ship to:&nbsp;
                                    <asp:DropDownList ID="ddlShipTo" runat="server" AutoPostBack="True" DataSourceID="SqlShipTo"
                                        DataTextField="SHIPTO_DISPLAY" DataValueField="CUST_SHIPTO_CODE" width="352px">
                                    </asp:DropDownList><asp:SqlDataSource ID="SqlShipTo" runat="server" ConnectionString="<%$ ConnectionStrings:CIMPRO_LIVEConnectionString %>"
                                        SelectCommand="SELECT CUST_SHIPTO_CODE, CUST_SHIPTO_NAME + N' -  ' + CUST_SHIPTO_ADDR_L3 AS SHIPTO_DISPLAY FROM OPCSHTO WHERE (CUST_CODE = @CUST_CODE)">
                                        <SelectParameters>
                                            <asp:SessionParameter Name="CUST_CODE" SessionField="CUST_CODE" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    &nbsp;
                                    <asp:FormView ID="fvShipTo" runat="server" DataSourceID="SqlShipToInfo" width="99%" DataKeyNames="CUST_CODE,CUST_SHIPTO_CODE">
                                        <EditItemTemplate>
                                            CUST_SHIPTO_NAME:
                                            <asp:TextBox ID="CUST_SHIPTO_NAMETextBox" runat="server" Text='<%# Bind("CUST_SHIPTO_NAME") %>'>
                                            </asp:TextBox><br />
                                            CUST_SHIPTO_ADDR_L1:
                                            <asp:TextBox ID="CUST_SHIPTO_ADDR_L1TextBox" runat="server" Text='<%# Bind("CUST_SHIPTO_ADDR_L1") %>'>
                                            </asp:TextBox><br />
                                            CUST_SHIPTO_ADDR_L2:
                                            <asp:TextBox ID="CUST_SHIPTO_ADDR_L2TextBox" runat="server" Text='<%# Bind("CUST_SHIPTO_ADDR_L2") %>'>
                                            </asp:TextBox><br />
                                            CITY:
                                            <asp:TextBox ID="CITYTextBox" runat="server" Text='<%# Bind("CITY") %>'>
                                            </asp:TextBox><br />
                                            STATE:
                                            <asp:TextBox ID="STATETextBox" runat="server" Text='<%# Bind("STATE") %>'>
                                            </asp:TextBox><br />
                                            ZIP:
                                            <asp:TextBox ID="ZIPTextBox" runat="server" Text='<%# Bind("ZIP") %>'>
                                            </asp:TextBox><br />
                                            CUST_SHIPTO_ADDR_L4:
                                            <asp:TextBox ID="CUST_SHIPTO_ADDR_L4TextBox" runat="server" Text='<%# Bind("CUST_SHIPTO_ADDR_L4") %>'>
                                            </asp:TextBox><br />
                                            CUST_SHIPTO_ADDR_L5:
                                            <asp:TextBox ID="CUST_SHIPTO_ADDR_L5TextBox" runat="server" Text='<%# Bind("CUST_SHIPTO_ADDR_L5") %>'>
                                            </asp:TextBox><br />
                                            CUST_CODE:
                                            <asp:Label ID="CUST_CODELabel1" runat="server" Text='<%# Eval("CUST_CODE") %>'></asp:Label><br />
                                            CUST_SHIPTO_CODE:
                                            <asp:Label ID="CUST_SHIPTO_CODELabel1" runat="server" Text='<%# Eval("CUST_SHIPTO_CODE") %>'>
                                            </asp:Label><br />
                                            <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                                                Text="Update">
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                                Text="Cancel">
                                            </asp:LinkButton>
                                        </EditItemTemplate>
                                        <InsertItemTemplate>
                                            CUST_SHIPTO_NAME:
                                            <asp:TextBox ID="CUST_SHIPTO_NAMETextBox" runat="server" Text='<%# Bind("CUST_SHIPTO_NAME") %>'>
                                            </asp:TextBox><br />
                                            CUST_SHIPTO_ADDR_L1:
                                            <asp:TextBox ID="CUST_SHIPTO_ADDR_L1TextBox" runat="server" Text='<%# Bind("CUST_SHIPTO_ADDR_L1") %>'>
                                            </asp:TextBox><br />
                                            CUST_SHIPTO_ADDR_L2:
                                            <asp:TextBox ID="CUST_SHIPTO_ADDR_L2TextBox" runat="server" Text='<%# Bind("CUST_SHIPTO_ADDR_L2") %>'>
                                            </asp:TextBox><br />
                                            CITY:
                                            <asp:TextBox ID="CITYTextBox" runat="server" Text='<%# Bind("CITY") %>'>
                                            </asp:TextBox><br />
                                            STATE:
                                            <asp:TextBox ID="STATETextBox" runat="server" Text='<%# Bind("STATE") %>'>
                                            </asp:TextBox><br />
                                            ZIP:
                                            <asp:TextBox ID="ZIPTextBox" runat="server" Text='<%# Bind("ZIP") %>'>
                                            </asp:TextBox><br />
                                            CUST_SHIPTO_ADDR_L4:
                                            <asp:TextBox ID="CUST_SHIPTO_ADDR_L4TextBox" runat="server" Text='<%# Bind("CUST_SHIPTO_ADDR_L4") %>'>
                                            </asp:TextBox><br />
                                            CUST_SHIPTO_ADDR_L5:
                                            <asp:TextBox ID="CUST_SHIPTO_ADDR_L5TextBox" runat="server" Text='<%# Bind("CUST_SHIPTO_ADDR_L5") %>'>
                                            </asp:TextBox><br />
                                            CUST_CODE:
                                            <asp:TextBox ID="CUST_CODETextBox" runat="server" Text='<%# Bind("CUST_CODE") %>'>
                                            </asp:TextBox><br />
                                            CUST_SHIPTO_CODE:
                                            <asp:TextBox ID="CUST_SHIPTO_CODETextBox" runat="server" Text='<%# Bind("CUST_SHIPTO_CODE") %>'>
                                            </asp:TextBox><br />
                                            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
                                                Text="Insert">
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                                Text="Cancel">
                                            </asp:LinkButton>
                                        </InsertItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="CUST_SHIPTO_NAMELabel" runat="server" Text='<%# Bind("CUST_SHIPTO_NAME") %>'></asp:Label><br />
                                            <asp:Label ID="CUST_SHIPTO_ADDR_L1Label" runat="server" Text='<%# Bind("CUST_SHIPTO_ADDR_L1") %>'></asp:Label><br />
                                            <asp:Label ID="CUST_SHIPTO_ADDR_L2Label" runat="server" Text='<%# Bind("CUST_SHIPTO_ADDR_L2") %>'></asp:Label><br />
                                            <asp:Label ID="CITYLabel" runat="server" Text='<%# Bind("CITY") %>'></asp:Label> &nbsp;
                                            <asp:Label ID="STATELabel" runat="server" Text='<%# Bind("STATE") %>'></asp:Label> &nbsp;&nbsp;
                                            <asp:Label ID="ZIPLabel" runat="server" Text='<%# Bind("ZIP") %>'></asp:Label><br />
                                            <asp:Label ID="CUST_SHIPTO_ADDR_L4Label" runat="server" Text='<%# Bind("CUST_SHIPTO_ADDR_L4") %>'></asp:Label><br />
                                            <asp:Label ID="CUST_SHIPTO_ADDR_L5Label" runat="server" Text='<%# Bind("CUST_SHIPTO_ADDR_L5") %>'></asp:Label><br />
                                            <asp:Label ID="CUST_CODELabel" runat="server" Text='<%# Eval("CUST_CODE") %>' Visible="False"></asp:Label><br />
                                            <asp:Label ID="CUST_SHIPTO_CODELabel" runat="server" Text='<%# Eval("CUST_SHIPTO_CODE") %>'
                                                Visible="False"></asp:Label><br />
                                            <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit"
                                                Text="Edit" Visible="False"></asp:LinkButton>
                                            <asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New"
                                                Text="New" Visible="False"></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:FormView>
                                    &nbsp;
                                    <asp:SqlDataSource ID="SqlShipToInfo" runat="server" ConnectionString="<%$ ConnectionStrings:CIMPRO_LIVEConnectionString %>"
                                        SelectCommand="SELECT CUST_SHIPTO_NAME, CUST_SHIPTO_ADDR_L1, CUST_SHIPTO_ADDR_L2, SUBSTRING(CUST_SHIPTO_ADDR_L3, 1, 19) AS CITY, SUBSTRING(CUST_SHIPTO_ADDR_L3, 20, 2) AS STATE, SUBSTRING(CUST_SHIPTO_ADDR_L3, 22, 10) AS ZIP, CUST_SHIPTO_ADDR_L4, CUST_SHIPTO_ADDR_L5, CUST_CODE, CUST_SHIPTO_CODE FROM OPCSHTO WHERE (CUST_CODE = @CUST_CODE) AND (CUST_SHIPTO_CODE = @CUST_SHIPTO_CODE)" InsertCommand="INSERT INTO OPCSHTO(CUST_CODE, CUST_SHIPTO_CODE, CUST_SHIPTO_NAME, CUST_SHIPTO_ADDR_L1, CUST_SHIPTO_ADDR_L2, CUST_SHIPTO_ADDR_L3, CUST_SHIPTO_ADDR_L4, CUST_SHIPTO_ADDR_L5) VALUES (@CUST_CODE, @CUST_SHIPTO_CODE, @CUST_SHIPTO_NAME, @CUST_SHIPTO_ADDR_L1, @CUST_SHIPTO_ADDR_L2, CAST(@CITY AS NCHAR(19)) + CAST(@STATE AS NCHAR(2)) + CAST(@ZIP AS NCHAR(10)), @CUST_SHIPTO_ADDR_L4, @CUST_SHIPTO_ADDR_L5)" UpdateCommand="UPDATE OPCSHTO SET CUST_SHIPTO_NAME = @CUST_SHIPTO_NAME, CUST_SHIPTO_ADDR_L1 = @CUST_SHIPTO_ADDR_L1, CUST_SHIPTO_ADDR_L2 = @CUST_SHIPTO_ADDR_L2, CUST_SHIPTO_ADDR_L3 = CAST(@CITY AS NCHAR(19)) + CAST(@STATE AS NCHAR(2)) + CAST(@ZIP AS NCHAR(10)), CUST_SHIPTO_ADDR_L4 = @CUST_SHIPTO_ADDR_L4, CUST_SHIPTO_ADDR_L5 = @CUST_SHIPTO_ADDR_L5 WHERE (CUST_CODE = @CUST_CODE) AND (CUST_SHIPTO_CODE = @CUST_SHIPTO_CODE)">
                                        <SelectParameters>
                                            <asp:SessionParameter Name="CUST_CODE" SessionField="CUST_CODE" Type="String" />
                                            <asp:ControlParameter ControlID="ddlShipTo" Name="CUST_SHIPTO_CODE" PropertyName="SelectedValue"
                                                Type="String" />
                                        </SelectParameters>
                                        <UpdateParameters>
                                            <asp:Parameter Name="CUST_SHIPTO_NAME" />
                                            <asp:Parameter Name="CUST_SHIPTO_ADDR_L1" />
                                            <asp:Parameter Name="CUST_SHIPTO_ADDR_L2" />
                                            <asp:Parameter Name="CITY" />
                                            <asp:Parameter Name="STATE" />
                                            <asp:Parameter Name="ZIP" />
                                            <asp:Parameter Name="CUST_SHIPTO_ADDR_L4" />
                                            <asp:Parameter Name="CUST_SHIPTO_ADDR_L5" />
                                            <asp:Parameter Name="CUST_CODE" />
                                            <asp:Parameter Name="CUST_SHIPTO_CODE" />
                                        </UpdateParameters>
                                        <InsertParameters>
                                            <asp:Parameter Name="CUST_CODE" />
                                            <asp:Parameter Name="CUST_SHIPTO_CODE" />
                                            <asp:Parameter Name="CUST_SHIPTO_NAME" />
                                            <asp:Parameter Name="CUST_SHIPTO_ADDR_L1" />
                                            <asp:Parameter Name="CUST_SHIPTO_ADDR_L2" />
                                            <asp:Parameter Name="CITY" />
                                            <asp:Parameter Name="STATE" />
                                            <asp:Parameter Name="ZIP" />
                                            <asp:Parameter Name="CUST_SHIPTO_ADDR_L4" />
                                            <asp:Parameter Name="CUST_SHIPTO_ADDR_L5" />
                                        </InsertParameters>
                                    </asp:SqlDataSource>
                                </td>
                                <td style="border: thin solid black; width: 35%; text-align: left; height: 221px; font-weight: 700;" vertical-align:"top">
                                    <asp:Button ID="btnPlaceOrder" runat="server" Text="Place Order" ToolTip="Click here to place this order with Braden Sutphin"
                                        width="98%" BackColor="#00C000" Font-Size="Larger" ForeColor="White" /><br />
                                    <br />
                                    <asp:Button ID="btnClearOrder" runat="server" OnClientClick="if(!confirm('Delete this order?'))return false;"
                                        Text="Clear Order" ToolTip="Click Here to Clear this order and start over" width="98%" BackColor="#FF8080" Font-Size="Larger" ForeColor="White" /><br />
                                    <br />
                                    <asp:Button ID="btnContinue" runat="server" Text="Continue Shopping" width="98%" BackColor="White" />
                                    <br />
                                    <br />
                                    <asp:Button ID="btnSignOut0" runat="server" BackColor="#C0C000" Height="24px" Text="Sign Out - Save Order for Later"
                                        width="98%" /></td>
                            </tr>
                            <tr>
                            <td style="width: 65%; text-align: center; border-right: black thin solid; border-top: black thin solid; border-left: black thin solid; border-bottom: black thin solid" vertical-align:"top">
                                <div style="width: 712px; height: 400px; overflow: auto">
                                    <asp:GridView ID="gvCart" runat="server" AutoGenerateColumns="False" DataKeyNames="ORDER_CUST_CODE,ORDER_LINE_NUMB" 
                                        DataSourceID="sqlWOODT">
                                        <Columns>
                                            <asp:CommandField ShowEditButton="True" />                                        
                                            <asp:TemplateField>
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="LinkButton1" Runat="server" OnClientClick="return confirm('Are you sure you want to delete this record?');" CommandName="Delete">Delete</asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="ORDER_LINE_NUMB" HeaderText="LINE" ReadOnly="True" SortExpression="ORDER_LINE_NUMB" />
                                            <asp:BoundField DataField="ITEM_CODE" HeaderText="BSI - ITEM" SortExpression="ITEM_CODE" />
                                            <asp:BoundField DataField="ITEM_DESC" HeaderText="DESCRIPTION" SortExpression="ITEM_DESC" />
                                            <asp:BoundField DataField="ITEM_UOM" HeaderText="UOM" SortExpression="ITEM_UOM" />
                                            <asp:BoundField DataField="QTY_ORD" HeaderText="QUANTITY" SortExpression="QTY_ORD" />
                                            <asp:BoundField DataField="ITEM_PRICE_HOME" HeaderText="PRICE" SortExpression="ITEM_PRICE_HOME" />
                                        </Columns>
                                    </asp:GridView>
                                    <asp:SqlDataSource ID="sqlWOODT" runat="server" ConflictDetection="CompareAllValues"
                                        ConnectionString="<%$ ConnectionStrings:CIMPRO_LIVEConnectionString %>" DeleteCommand="DELETE FROM [WOODT] WHERE [ORDER_CUST_CODE] = @original_ORDER_CUST_CODE AND [ORDER_LINE_NUMB] = @original_ORDER_LINE_NUMB AND (([ITEM_CODE] = @original_ITEM_CODE) OR ([ITEM_CODE] IS NULL AND @original_ITEM_CODE IS NULL)) AND (([PANTONE_COLOR] = @original_PANTONE_COLOR) OR ([PANTONE_COLOR] IS NULL AND @original_PANTONE_COLOR IS NULL)) AND (([ITEM_DESC] = @original_ITEM_DESC) OR ([ITEM_DESC] IS NULL AND @original_ITEM_DESC IS NULL)) AND (([ITEM_UOM] = @original_ITEM_UOM) OR ([ITEM_UOM] IS NULL AND @original_ITEM_UOM IS NULL)) AND (([QTY_ORD] = @original_QTY_ORD) OR ([QTY_ORD] IS NULL AND @original_QTY_ORD IS NULL)) AND (([ITEM_PRICE_HOME] = @original_ITEM_PRICE_HOME) OR ([ITEM_PRICE_HOME] IS NULL AND @original_ITEM_PRICE_HOME IS NULL))"
                                        InsertCommand="INSERT INTO [WOODT] ([ORDER_CUST_CODE], [ORDER_LINE_NUMB], [ITEM_CODE], [PANTONE_COLOR], [ITEM_DESC], [ITEM_UOM], [QTY_ORD], [ITEM_PRICE_HOME]) VALUES (@ORDER_CUST_CODE, @ORDER_LINE_NUMB, @ITEM_CODE, @PANTONE_COLOR, @ITEM_DESC, @ITEM_UOM, @QTY_ORD, @ITEM_PRICE_HOME)"
                                        OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT [ORDER_CUST_CODE], [ORDER_LINE_NUMB], [ITEM_CODE], [PANTONE_COLOR], [ITEM_DESC], [ITEM_UOM], [QTY_ORD], [ITEM_PRICE_HOME] FROM [WOODT] WHERE ([ORDER_CUST_CODE] = @ORDER_CUST_CODE) ORDER BY [ORDER_LINE_NUMB]"
                                        UpdateCommand="UPDATE [WOODT] SET [ITEM_CODE] = @ITEM_CODE, [PANTONE_COLOR] = @PANTONE_COLOR, [ITEM_DESC] = @ITEM_DESC, [ITEM_UOM] = @ITEM_UOM, [QTY_ORD] = @QTY_ORD, [ITEM_PRICE_HOME] = @ITEM_PRICE_HOME WHERE [ORDER_CUST_CODE] = @original_ORDER_CUST_CODE AND [ORDER_LINE_NUMB] = @original_ORDER_LINE_NUMB AND (([ITEM_CODE] = @original_ITEM_CODE) OR ([ITEM_CODE] IS NULL AND @original_ITEM_CODE IS NULL)) AND (([PANTONE_COLOR] = @original_PANTONE_COLOR) OR ([PANTONE_COLOR] IS NULL AND @original_PANTONE_COLOR IS NULL)) AND (([ITEM_DESC] = @original_ITEM_DESC) OR ([ITEM_DESC] IS NULL AND @original_ITEM_DESC IS NULL)) AND (([ITEM_UOM] = @original_ITEM_UOM) OR ([ITEM_UOM] IS NULL AND @original_ITEM_UOM IS NULL)) AND (([QTY_ORD] = @original_QTY_ORD) OR ([QTY_ORD] IS NULL AND @original_QTY_ORD IS NULL)) AND (([ITEM_PRICE_HOME] = @original_ITEM_PRICE_HOME) OR ([ITEM_PRICE_HOME] IS NULL AND @original_ITEM_PRICE_HOME IS NULL))">
                                        <SelectParameters>
                                             <asp:SessionParameter Name="ORDER_CUST_CODE" SessionField="CUST_CODE" Type="String" />
                                        </SelectParameters>
                                        <DeleteParameters>
                                            <asp:Parameter Name="original_ORDER_CUST_CODE" Type="String" />
                                            <asp:Parameter Name="original_ORDER_LINE_NUMB" Type="Int32" />
                                            <asp:Parameter Name="original_ITEM_CODE" Type="String" />
                                            <asp:Parameter Name="original_PANTONE_COLOR" Type="String" />
                                            <asp:Parameter Name="original_ITEM_DESC" Type="String" />
                                            <asp:Parameter Name="original_ITEM_UOM" Type="String" />
                                            <asp:Parameter Name="original_QTY_ORD" Type="Decimal" />
                                            <asp:Parameter Name="original_ITEM_PRICE_HOME" Type="Decimal" />
                                        </DeleteParameters>
                                        <UpdateParameters>
                                            <asp:Parameter Name="ITEM_CODE" Type="String" />
                                            <asp:Parameter Name="PANTONE_COLOR" Type="String" />
                                            <asp:Parameter Name="ITEM_DESC" Type="String" />
                                            <asp:Parameter Name="ITEM_UOM" Type="String" />
                                            <asp:Parameter Name="QTY_ORD" Type="Decimal" />
                                            <asp:Parameter Name="ITEM_PRICE_HOME" Type="Decimal" />
                                            <asp:Parameter Name="original_ORDER_CUST_CODE" Type="String" />
                                            <asp:Parameter Name="original_ORDER_LINE_NUMB" Type="Int32" />
                                            <asp:Parameter Name="original_ITEM_CODE" Type="String" />
                                            <asp:Parameter Name="original_PANTONE_COLOR" Type="String" />
                                            <asp:Parameter Name="original_ITEM_DESC" Type="String" />
                                            <asp:Parameter Name="original_ITEM_UOM" Type="String" />
                                            <asp:Parameter Name="original_QTY_ORD" Type="Decimal" />
                                            <asp:Parameter Name="original_ITEM_PRICE_HOME" Type="Decimal" />
                                        </UpdateParameters>
                                        <InsertParameters>
                                            <asp:Parameter Name="ORDER_CUST_CODE" Type="String" />
                                            <asp:Parameter Name="ORDER_LINE_NUMB" Type="Int32" />
                                            <asp:Parameter Name="ITEM_CODE" Type="String" />
                                            <asp:Parameter Name="PANTONE_COLOR" Type="String" />
                                            <asp:Parameter Name="ITEM_DESC" Type="String" />
                                            <asp:Parameter Name="ITEM_UOM" Type="String" />
                                            <asp:Parameter Name="QTY_ORD" Type="Decimal" />
                                            <asp:Parameter Name="ITEM_PRICE_HOME" Type="Decimal" />
                                        </InsertParameters>
                                    </asp:SqlDataSource>
                                    &nbsp;&nbsp;
                        </div>
                                &nbsp;&nbsp;
                                <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" OldValuesParameterFormatString="original_{0}"
                                    SelectMethod="GetDataCount" TypeName="OrderProcessingTableAdapters.DetailsCountTableAdapter">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="ORDER_CUST_CODE" SessionField="CUST_CODE" Type="String" />                                    
                                    </SelectParameters>
                                </asp:ObjectDataSource>
                                </td>
                                <td style="width: 35%; text-align: left" vertical-align:"top">
                                    <span style="font-size: 10pt"><strong>Customer Information:</strong></span><br />
                                    <asp:FormView ID="fvCustomer" runat="server" DataSourceID="sqlCustAddress"
                                        width="99%" >
                                        <EditItemTemplate>
                                        </EditItemTemplate>
                                        <InsertItemTemplate>
                                        </InsertItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="CUST_NAMELabel" runat="server" Text='<%# Bind("CUST_NAME") %>'></asp:Label><asp:Label
                                                ID="CUST_ADDR_L1Label" runat="server" Text='<%# Bind("CUST_ADDR_L1") %>'></asp:Label><br />
                                            <asp:Label ID="CUST_ADDR_L2Label" runat="server" Text='<%# Bind("CUST_ADDR_L2") %>'></asp:Label><br />
                                            <asp:Label ID="CUST_ADDR_L3Label" runat="server" Text='<%# Bind("CUST_ADDR_L3") %>'></asp:Label><br />
                                            <asp:Label ID="CITY_STATE_ZIPLabel" runat="server" Text='<%# Eval("CITY_STATE_ZIP") %>'></asp:Label><br />
                                        </ItemTemplate>
                                    </asp:FormView>
                                    <asp:SqlDataSource ID="sqlCustAddress" runat="server" ConnectionString="<%$ ConnectionStrings:CIMPRO_LIVEConnectionString %>"
                                        SelectCommand="SELECT CUST_NAME, CUST_ADDR_L1, CUST_ADDR_L2, CUST_ADDR_L3, CUST_CITY + N', ' + CUST_STATE + N'  ' + CUST_ZIP AS CITY_STATE_ZIP FROM WOOHD WHERE (ORDER_CUST_CODE = @ORDER_CUST_CODE)">
                                        <SelectParameters>
                                            <asp:SessionParameter Name="ORDER_CUST_CODE" SessionField="CUST_CODE" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                    <asp:FormView ID="fvOrderInfo" runat="server" DataKeyNames="ORDER_CUST_CODE" DataSourceID="sqlOrderInfo">
                                        <EditItemTemplate>
                                            <asp:Label ID="ORDER_CUST_CODELabel1" runat="server" Text='<%# Bind("ORDER_CUST_CODE") %>'></asp:Label><br />
                                            <table>
                                                <tr>
                                                    <td style="width: 100px">
                                                        PO</td>
                                                    <td style="width: 100px">
                                                        <asp:TextBox ID="CUST_PO_NUMBTextBox" runat="server" Text='<%# Bind("CUST_PO_NUMB") %>'></asp:TextBox></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 100px">
                                                        DATE WANTED</td>
                                                    <td style="width: 100px">
                                                        <asp:TextBox ID="DATE_WANTEDTextBox" runat="server" Text='<%# Bind("DATE_WANTED") %>'></asp:TextBox></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 100px">
                                                        CONTACT</td>
                                                    <td style="width: 100px">
                                                        <asp:TextBox ID="ORDER_CONTACTTextBox" runat="server" Text='<%# Bind("ORDER_CONTACT") %>'></asp:TextBox></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 100px">
                                                        PHONE</td>
                                                    <td style="width: 100px">
                                                        <asp:TextBox ID="ORDER_CONTACT_PHONETextBox" runat="server" Text='<%# Bind("ORDER_CONTACT_PHONE") %>'></asp:TextBox></td>
                                                </tr>
                                                <tr>
                                                    <td style="vertical-align: top; text-align: left;">
                                                        NOTES</td>
                                                    <td style="vertical-align: top; text-align: left;">
                                                        <asp:TextBox ID="ORDER_NOTESTextBox" runat="server" Text='<%# Bind("ORDER_NOTES") %>' Height="128px" TextMode="MultiLine" width="440px"></asp:TextBox></td>
                                                </tr>
                                            </table>
                                            <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                                                Text="Update"></asp:LinkButton>
                                            <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                                Text="Cancel"></asp:LinkButton>
                                            <ajaxToolkit:CalendarExtender ID="calextOrderDateWanted" runat="server" TargetControlID="DATE_WANTEDTextBox">
                                            </ajaxtoolkit:CalendarExtender>
                                        </EditItemTemplate>
                                        <InsertItemTemplate>
                                            ORDER_CUST_CODE:
                                            <asp:TextBox ID="ORDER_CUST_CODETextBox" runat="server" Text='<%# Bind("ORDER_CUST_CODE") %>'>
                                            </asp:TextBox><br />
                                            CUST_PO_NUMB:
                                            <asp:TextBox ID="CUST_PO_NUMBTextBox" runat="server" Text='<%# Bind("CUST_PO_NUMB") %>'>
                                            </asp:TextBox><br />
                                            DATE_WANTED:
                                            <asp:TextBox ID="DATE_WANTEDTextBox" runat="server" Text='<%# Bind("DATE_WANTED") %>'>
                                            </asp:TextBox><br />
                                            ORDER_CONTACT:
                                            <asp:TextBox ID="ORDER_CONTACTTextBox" runat="server" Text='<%# Bind("ORDER_CONTACT") %>'>
                                            </asp:TextBox><br />
                                            ORDER_CONTACT_PHONE:
                                            <asp:TextBox ID="ORDER_CONTACT_PHONETextBox" runat="server" Text='<%# Bind("ORDER_CONTACT_PHONE") %>'>
                                            </asp:TextBox><br />
                                            ORDER_NOTES:
                                            <asp:TextBox ID="ORDER_NOTESTextBox" runat="server" Text='<%# Bind("ORDER_NOTES") %>'>
                                            </asp:TextBox><br />
                                            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
                                                Text="Insert">
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                                Text="Cancel">
                                            </asp:LinkButton>
                                        </InsertItemTemplate>
                                        <ItemTemplate>
                                            <br />
                                            <table>
                                                <tr>
                                                    <td>
                                                    </td>
                                                    <td style="width: 100px">
                                            <asp:Label ID="ORDER_CUST_CODELabel" runat="server" Text='<%# Bind("ORDER_CUST_CODE") %>'
                                                Visible="False"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        PO:</td>
                                                    <td style="width: 100px">
                                                        <asp:Label ID="CUST_PO_NUMBLabel" runat="server" Text='<%# Bind("CUST_PO_NUMB") %>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        DATE WANTED:</td>
                                                    <td style="width: 100px">
                                                        <asp:Label ID="DATE_WANTEDLabel" runat="server" Text='<%# Bind("DATE_WANTED") %>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        CONTACT:</td>
                                                    <td style="width: 100px">
                                                        <asp:Label ID="ORDER_CONTACTLabel" runat="server" Text='<%# Bind("ORDER_CONTACT") %>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        PHONE:</td>
                                                    <td style="width: 100px">
                                                        <asp:Label ID="ORDER_CONTACT_PHONELabel" runat="server" Text='<%# Bind("ORDER_CONTACT_PHONE") %>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td style="vertical-align: top; text-align: left;">
                                                        NOTES:</td>
                                                    <td style="vertical-align: top; text-align: left;">
                                                        <asp:Label ID="ORDER_NOTESLabel" runat="server" Height="112px" Text='<%# Bind("ORDER_NOTES") %>'
                                                            width="99%"></asp:Label></td>
                                                </tr>
                                            </table>
                                            <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit"
                                                Text="Edit"></asp:LinkButton>
                                            <asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New"
                                                Text="New"></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:FormView>
                                    <asp:SqlDataSource ID="sqlOrderInfo" runat="server" ConnectionString="<%$ ConnectionStrings:CIMPRO_LIVEConnectionString %>"
                                        InsertCommand="INSERT INTO WOOHD(ORDER_CUST_CODE, CUST_PO_NUMB, DATE_WANTED, ORDER_CONTACT, ORDER_CONTACT_PHONE, ORDER_NOTES) VALUES (N'ORDER_CUST_CODE', N'CUST_PO_NUMB', @DATE_WANTED, @ORDER_CONTACT, @ORDER_CONTACT_PHONE, @ORDER_NOTES)"
                                        SelectCommand="SELECT ORDER_CUST_CODE, CUST_PO_NUMB, CONVERT (VARCHAR, DATE_WANTED, 101) AS DATE_WANTED, ORDER_CONTACT, ORDER_CONTACT_PHONE, ORDER_NOTES FROM WOOHD WHERE (ORDER_CUST_CODE = @ORDER_CUST_CODE)"
                                        UpdateCommand="UPDATE WOOHD SET CUST_PO_NUMB = @CUST_PO_NUMB, DATE_WANTED = @DATE_WANTED, ORDER_CONTACT = @ORDER_CONTACT, ORDER_CONTACT_PHONE = @ORDER_CONTACT_PHONE, ORDER_NOTES = @ORDER_NOTES WHERE (ORDER_CUST_CODE = @ORDER_CUST_CODE)">
                                        <SelectParameters>
                                             <asp:SessionParameter Name="ORDER_CUST_CODE" SessionField="CUST_CODE" Type="String" />
                                        </SelectParameters>
                                        <UpdateParameters>
                                            <asp:Parameter Name="CUST_PO_NUMB" />
                                            <asp:Parameter Name="DATE_WANTED" />
                                            <asp:Parameter Name="ORDER_CONTACT" />
                                            <asp:Parameter Name="ORDER_CONTACT_PHONE" />
                                            <asp:Parameter Name="ORDER_NOTES" />
                                             <asp:SessionParameter Name="ORDER_CUST_CODE" SessionField="CUST_CODE" Type="String" />
                                        </UpdateParameters>
                                        <InsertParameters>
                                            <asp:Parameter Name="DATE_WANTED" />
                                            <asp:Parameter Name="ORDER_CONTACT" />
                                            <asp:Parameter Name="ORDER_CONTACT_PHONE" />
                                            <asp:Parameter Name="ORDER_NOTES" />
                                        </InsertParameters>
                                    </asp:SqlDataSource>
                                    &nbsp; &nbsp;&nbsp;
                                </td>
                            </tr>
                        </table>
                        &nbsp; &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;<br />
                        &nbsp;
                    
                    </asp:View>
                    
                    <asp:View ID="View_Copy_Previous" runat="server">
                        <table  width:"99%" style="border-right: black thin solid; border-top: black thin solid; border-left: black thin solid; border-bottom: black thin solid" id="tblOrderHistory" >
                            <tr>
                                <td colspan="2" style="text-align: center" vertical-align:"top">
                                    <h2>
                                       Order History
                                    </h2>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: center; border-right: black thin solid; border-top: black thin solid; border-left: black thin solid; width: 97px; border-bottom: black thin solid; height: 21px;">
                                <div style="width: 512px; height: 24px">
                                    <h3>Order Header - Most Recent First</h3>
                                </div>
                                </td>
                                <td style="text-align: center; border-right: black thin solid; border-top: black thin solid; border-left: black thin solid; width: 100px; border-bottom: black thin solid; height: 21px;">
                                <div style="width: 640px; height: 24px">
                                   <h3>Order Detail for Selected Order</h3></div>                                
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: left; border-right: black thin solid; border-top: black thin solid; border-left: black thin solid; width: 97px; border-bottom: black thin solid; height: 21px;" align="left" vertical-align:"top">
                                    <div style="overflow: auto; width: 422px; height: 520px; text-align: left; position: static;">
                                    <asp:GridView ID="gvCSAHH" runat="server" AllowSorting="True" 
                                        AutoGenerateColumns="False" DataKeyNames="INV_NUMB,CUST_INV_DATE_YYMM" DataSourceID="odOrderDropDown"
                                        PageSize="15">
                                        <Columns>
                                            <asp:CommandField ShowSelectButton="True" SelectText="Detail" >
                                                <ItemStyle Wrap="False" />
                                            </asp:CommandField>
                                            <asp:BoundField DataField="DATE_ORD" DataFormatString="{0:d}" HeaderText="Order Date"
                                                SortExpression="DATE_ORD" />
                                            <asp:BoundField DataField="CUST_PO_NUMB" HeaderText="PO NUMBER" SortExpression="CUST_PO_NUMB" />
                                            <asp:BoundField DataField="ORDER_NUMB" HeaderText="ORDER #" SortExpression="ORDER_NUMB" />
                                            <asp:BoundField DataField="NUM_LINES" HeaderText="# ITEMS" ReadOnly="True" SortExpression="NUM_LINES" >
                                                <ItemStyle HorizontalAlign="Center" />
                                            </asp:BoundField>
                                        </Columns>
                                    </asp:GridView>
                                    </div>
                                    <asp:ObjectDataSource ID="odOrderDropDown" runat="server" OldValuesParameterFormatString="original_{0}"
                            SelectMethod="GetData_Order_DropDown" TypeName="OrderProcessingTableAdapters.OPCSAHHTableAdapter">
                            <SelectParameters>
                                <asp:SessionParameter Name="CUST_CODE" SessionField="CUST_CODE" Type="String" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                                </td>
                                <td style="text-align: center; border-right: black thin solid; border-top: black thin solid; border-left: black thin solid; width: 100px; border-bottom: black thin solid; height: 21px;" align="left" vertical-align:"top">
                                <div style="overflow: auto; width: 520px; height: 520px; text-align: center">
                        <asp:GridView ID="gvOrderHist" runat="server" AutoGenerateColumns="False" DataKeyNames="ITEM_CODE,QTY_SALES,CUST_ITEM_CODE" 
                            DataSourceID="odOrderLines" AllowPaging="True" PageSize="15" width="528px" >
                            <Columns>
                                <asp:CommandField SelectText="View Item" ShowSelectButton="True"  >
                                    <ItemStyle Wrap="False" />
                                </asp:CommandField>
                                <asp:BoundField DataField="INV_LINE_NUMB" HeaderText="LINE" ReadOnly="True" SortExpression="INV_LINE_NUMB" Visible="False" />
                                <asp:BoundField DataField="ITEM_CODE" HeaderText="ITEM" SortExpression="ITEM_CODE">
                                    <ItemStyle Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ITEM_DESC" HeaderText="DESCRIPTION" SortExpression="ITEM_DESC">
                                    <ItemStyle Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="CUST_ITEM_CODE" HeaderText="YOUR ITEM" SortExpression="CUST_ITEM_CODE" >
                                    <ItemStyle Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="QTY_SALES" DataFormatString="{0:N0}" HeaderText="QTY"
                                    SortExpression="QTY_SALES" />
                                <asp:BoundField DataField="ITEM_UOM" HeaderText="UOM" SortExpression="ITEM_UOM" />
                            </Columns>
                        </asp:GridView>
                                </div>
                        <asp:ObjectDataSource ID="odOrderLines" runat="server" OldValuesParameterFormatString="original_{0}"
                            SelectMethod="GetData" TypeName="OrderProcessingTableAdapters.OPCSAHFTableAdapter">
                            <SelectParameters>
                                <asp:SessionParameter Name="CUST_INV_DATE_YYMM" SessionField="COPY_DATE" Type="DateTime" />
                                <asp:SessionParameter Name="INV_NUMB" SessionField="COPY_INV" Type="String" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                                </td>
                            </tr>
                        </table>
                    </asp:View>
                    <asp:View ID="View_Add_Items" runat="server">
                        <table width:"99%">
                            <tr>
                                <td style="text-align: center" >
                                    <h2>Items Ordered Previously</h2></td>
                            </tr>
                            <tr>
                                <td align="left" >
                                    <p>Search as far back as: <asp:TextBox ID="txtOrderStartDate" runat="server" width="328px"></asp:TextBox></p></td>
                            </tr>
                            <tr>
                                <td style="width: 100px; height: 36px;" align:"left">
                                    <div style="overflow: auto; width: 912px; height: 456px; text-align: right">
                        <asp:GridView ID="gvAllItemsOrdered" runat="server" AutoGenerateColumns="False" DataKeyNames="ITEM_ID,MOST_ORDERED,YOUR_ITEM" 
                            DataSourceID="odAllItemsOrdered" AllowSorting="True">
                            <Columns>
                                <asp:CommandField ShowSelectButton="True" SelectText="View Item" />
                                <asp:BoundField DataField="ITEM_ID" HeaderText="BSI ITEM" SortExpression="ITEM_ID" />
                                <asp:BoundField DataField="ITEM_DESC" HeaderText="DESCRIPTION" SortExpression="ITEM_DESC" />
                                <asp:BoundField DataField="YOUR_ITEM" HeaderText="YOUR ITEM" ReadOnly="True" SortExpression="YOUR_ITEM" />
                                <asp:BoundField DataField="MOST_ORDERED" HeaderText="MAX ORDERED" SortExpression="MOST_ORDERED" />
                                <asp:BoundField DataField="ITEM_UOM" HeaderText="UOM" SortExpression="ITEM_UOM" />
                                <asp:BoundField DataField="TIMES_ORDERED" HeaderText="TIMES ORDERED" ReadOnly="True"
                                    SortExpression="TIMES_ORDERED" DataFormatString="{0:d0}" />
                            </Columns>
                        </asp:GridView>
                                    </div>
                                </td>
                            </tr>
                        </table>
                        <br />
                        <ajaxToolkit:CalendarExtender ID="calextOrderStartDate" runat="server" TargetControlID="txtOrderStartDate"> </ajaxToolkit:CalendarExtender>
                        &nbsp;
                        <asp:ObjectDataSource ID="odAllItemsOrdered" runat="server" OldValuesParameterFormatString="original_{0}"
                            SelectMethod="GetData" TypeName="OrderProcessingTableAdapters.Items_Ordered_BeforeTableAdapter">
                            <SelectParameters>
                                <asp:SessionParameter Name="CUST_CODE" SessionField="CUST_CODE" Type="String" />
                                <asp:ControlParameter ControlID="txtOrderStartDate" Name="DATE_LIMIT" PropertyName="Text"
                                    Type="DateTime" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                         
                    </asp:View>
                    <asp:View ID="View_New_PMS" runat="server">
                        <table>
                            <tr>
                                <td align="right">
                                    Product Line:</td>
                                <td style="text-align: left;">
                                    <asp:DropDownList ID="ddlProductLine" runat="server" DataSourceID="SqlDSProductLine"
                                        DataTextField="PRODUCT_LINE_DESC" DataValueField="PRODUCT_LINE_CODE" width="272px" AutoPostBack="True">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    Pantone Number:</td>
                                <td style="text-align: left;">
                                    <asp:DropDownList ID="ddlPantone" runat="server" DataSourceID="dataPantoneColors"
                                        DataTextField="PANTONE_COLOR" DataValueField="PANTONE_COLOR" ToolTip="Enter the pantone number for this color i.e. 204"
                                        width="352px" AutoPostBack="True">
                                    </asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="overflow: auto; text-align: left">
                                    &nbsp;
                                    <asp:GridView ID="gvPMS_Items" runat="server" AutoGenerateColumns="False" DataKeyNames="ITEM_CODE" 
                                        DataSourceID="dataPMS_INFO">
                                        <Columns>
                                            <asp:CommandField ShowSelectButton="True" />
                                            <asp:BoundField DataField="PANTONE_COLOR" HeaderText="PANTONE_COLOR" SortExpression="PANTONE_COLOR" />
                                            <asp:BoundField DataField="ITEM_CODE" HeaderText="ITEM_CODE" SortExpression="ITEM_CODE" />
                                            <asp:BoundField DataField="ITEM_DESCRIPTION" HeaderText="ITEM_DESCRIPTION" SortExpression="ITEM_DESCRIPTION" />
                                            <asp:BoundField DataField="CUST_ITEM_CODE" HeaderText="CUST_ITEM_CODE" SortExpression="CUST_ITEM_CODE" />
                                            <asp:BoundField DataField="CUST_ITEM_DESC" HeaderText="CUST_ITEM_DESC" SortExpression="CUST_ITEM_DESC" />
                                            <asp:BoundField DataField="ITEM_LINE" HeaderText="ITEM_LINE" SortExpression="ITEM_LINE" />
                                        </Columns>
                                    </asp:GridView>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" style="overflow: auto; text-align: left">
                                    <asp:ObjectDataSource ID="dataPMS_INFO" runat="server" OldValuesParameterFormatString="original_{0}"
                                        SelectMethod="GetData" TypeName="OrderProcessingTableAdapters.PMS_ITEM_INFOTableAdapter">
                                        <SelectParameters>
                                            <asp:SessionParameter Name="CUST_CODE" SessionField="CUST_CODE" Type="String" />
                                            <asp:ControlParameter ControlID="ddlPantone" Name="PANTONE_COLOR" PropertyName="SelectedValue"
                                                Type="String" />
                                            <asp:ControlParameter ControlID="ddlProductLine" Name="ITEM_LINE" PropertyName="SelectedValue"
                                                Type="String" />
                                        </SelectParameters>
                                    </asp:ObjectDataSource>
                                    <asp:ObjectDataSource ID="dataPantoneColors" runat="server" OldValuesParameterFormatString="original_{0}"
                                        SelectMethod="GetPantoneColorsDataBy" TypeName="OrderProcessingTableAdapters.PANTONE_FORMULA_HEADERTableAdapter">
                                    </asp:ObjectDataSource>
                        <asp:SqlDataSource ID="SqlDSProductLine" runat="server" ConnectionString="<%$ ConnectionStrings:CIMPRO_LIVEConnectionString %>"
                            SelectCommand="SELECT viewInventory_Product_Lines.PRODUCT_LINE_DESC, viewInventory_Product_Lines.PRODUCT_LINE_CODE FROM OPCSAHF INNER JOIN viewInventory_Items ON OPCSAHF.ITEM_CODE = viewInventory_Items.ITEM_CODE INNER JOIN viewInventory_Product_Lines ON viewInventory_Items.ITEM_LINE = viewInventory_Product_Lines.PRODUCT_LINE_CODE WHERE (OPCSAHF.CUST_CODE = @CUST_CODE) GROUP BY viewInventory_Product_Lines.PRODUCT_LINE_DESC, viewInventory_Product_Lines.PRODUCT_LINE_CODE">
                            <SelectParameters>
                                <asp:SessionParameter Name="CUST_CODE" SessionField="CUST_CODE" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                                </td>
                            </tr>
                        </table>
                    </asp:View>
                    <asp:View ID="view_Current_Orders" runat="server">
                        &nbsp;&nbsp;&nbsp;
                        <table width:"99%" style="border-right: black thin solid; border-top: black thin solid; border-left: black thin solid; border-bottom: black thin solid" id="tblOpenOrders">
                            <tr>
                                <td colspan="2" style="text-align: center" vertical-align:"top">
                                    <h2>
                                        Open Orders
                                    </h2>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" style="border-right: black thin solid; border-top: black thin solid; border-left: black thin solid; width: 100px; border-bottom: black thin solid; height: 21px; text-align: center">
                                    <div style="width: 376px; height: 24px">
                                        <h3>Order Header</h3></div>
                                </td>
                                <td style="border-right: black thin solid; border-top: black thin solid; border-left: black thin solid; border-bottom: black thin solid">
                                    <div style="width: 570px; height: 24px">
                                        <h3>Items On Order</h3></div>
                                </td>
                            </tr>
                            <tr>
                                <td align="center" style="width: 100px; border-right: black thin solid; border-top: black thin solid; border-left: black thin solid; border-bottom: black thin solid; height: 21px; text-align: right;" vertical-align:"top">
                                    <asp:GridView ID="gvOpenOrders" runat="server" AutoGenerateColumns="False" DataKeyNames="ORDER_NUMB"
                                        DataSourceID="odORDER_HEADER" width="99%" >
                                        <Columns>
                                            <asp:CommandField ShowSelectButton="True" />
                                            <asp:BoundField DataField="ORDER_NUMB" HeaderText="ORDER #" SortExpression="ORDER_NUMB" >
                                                <ItemStyle HorizontalAlign="Left" Wrap="False" width="100px" />
                                                <HeaderStyle Wrap="False" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="DATE_ORD" DataFormatString="{0:d}" HeaderText="ORDER DATE"
                                                SortExpression="DATE_ORD" >
                                                <ItemStyle HorizontalAlign="Right" Wrap="False" width="300px" />
                                                <HeaderStyle Wrap="True" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="DATE_WANTED" DataFormatString="{0:d}" HeaderText="DATE WANTED"
                                                SortExpression="DATE_WANTED" >
                                                <ItemStyle HorizontalAlign="Right" Wrap="False" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="SHIP_VIA_SHORT_DESC" HeaderText="SHIP VIA" SortExpression="SHIP_VIA_SHORT_DESC" >
                                                <ItemStyle HorizontalAlign="Right" Wrap="False" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="CUST_SHIPTO_CODE" HeaderText="SHIP TO" SortExpression="CUST_SHIPTO_CODE" >
                                                <ItemStyle HorizontalAlign="Right" Wrap="False" />
                                            </asp:BoundField>
                                        </Columns>
                                    </asp:GridView>
                                    <asp:ObjectDataSource ID="odORDER_HEADER" runat="server" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}"
                                        SelectMethod="GetData" TypeName="OrderProcessingTableAdapters.OPCOOHDTableAdapter">
                                        <SelectParameters>
                                            <asp:SessionParameter Name="CUST_CODE" SessionField="CUST_CODE" Type="String" />
                                        </SelectParameters>
                                        <InsertParameters>
                                            <asp:Parameter Name="ORDER_NUMB" Type="String" />
                                            <asp:Parameter Name="CUST_CODE" Type="String" />
                                            <asp:Parameter Name="CUST_NAME" Type="String" />
                                            <asp:Parameter Name="CUST_ADDR_L1" Type="String" />
                                            <asp:Parameter Name="CUST_ADDR_L2" Type="String" />
                                            <asp:Parameter Name="CUST_ADDR_L3" Type="String" />
                                            <asp:Parameter Name="CUST_SHIPTO_NAME" Type="String" />
                                            <asp:Parameter Name="CUST_SHIPTO_ADDR_L1" Type="String" />
                                            <asp:Parameter Name="CUST_SHIPTO_ADDR_L2" Type="String" />
                                            <asp:Parameter Name="CUST_SHIPTO_ADDR_L3" Type="String" />
                                            <asp:Parameter Name="REGISTER_IND" Type="String" />
                                            <asp:Parameter Name="INV_OPEN_IND" Type="String" />
                                            <asp:Parameter Name="PRINT_FLAG" Type="String" />
                                            <asp:Parameter Name="INV_POSTED_IND" Type="String" />
                                            <asp:Parameter Name="CREDIT_LIMIT_FLAG" Type="String" />
                                            <asp:Parameter Name="WHSE_IND" Type="String" />
                                            <asp:Parameter Name="BACK_ORDER_IND" Type="String" />
                                            <asp:Parameter Name="SHIPMENT_IND" Type="String" />
                                            <asp:Parameter Name="BLANKET_IND" Type="String" />
                                            <asp:Parameter Name="CUST_PO_NUMB" Type="String" />
                                            <asp:Parameter Name="DATE_ORD" Type="DateTime" />
                                            <asp:Parameter Name="DATE_WANTED" Type="DateTime" />
                                            <asp:Parameter Name="SHIP_VIA_SHORT_DESC" Type="String" />
                                            <asp:Parameter Name="PREPAID_COLLECT_FLAG" Type="String" />
                                            <asp:Parameter Name="SALESREP_CODE" Type="String" />
                                            <asp:Parameter Name="COMPANY_CODE" Type="String" />
                                            <asp:Parameter Name="SALES_TAX_CODE" Type="String" />
                                            <asp:Parameter Name="ORDER_VAL" Type="Decimal" />
                                            <asp:Parameter Name="PAYMENT_TERMS_CODE" Type="String" />
                                            <asp:Parameter Name="SHIP_VIA_CODE" Type="String" />
                                            <asp:Parameter Name="CUST_SHIPTO_CODE" Type="String" />
                                            <asp:Parameter Name="SALESREP_CODE_2" Type="String" />
                                            <asp:Parameter Name="SALESREP_CODE_3" Type="String" />
                                            <asp:Parameter Name="SALESREP_CODE_4" Type="String" />
                                            <asp:Parameter Name="SALES_TAX_CODE_2" Type="String" />
                                            <asp:Parameter Name="SALES_TAX_CODE_3" Type="String" />
                                            <asp:Parameter Name="SALES_TAX_CODE_4" Type="String" />
                                            <asp:Parameter Name="SALES_TAX_CODE_5" Type="String" />
                                            <asp:Parameter Name="COMMISSION_TYPE_CODE" Type="String" />
                                            <asp:Parameter Name="COMMISSION_IND" Type="String" />
                                            <asp:Parameter Name="WHSE_EXT" Type="String" />
                                            <asp:Parameter Name="SHIPMENT_NUMB" Type="String" />
                                            <asp:Parameter Name="SALES_TAX_EXEMPT_IND" Type="String" />
                                            <asp:Parameter Name="FOB_CODE" Type="String" />
                                            <asp:Parameter Name="FOB_DESC" Type="String" />
                                            <asp:Parameter Name="OPER_CODE" Type="String" />
                                            <asp:Parameter Name="SALESREP_PERCENT_1" Type="Decimal" />
                                            <asp:Parameter Name="SALESREP_PERCENT_2" Type="Decimal" />
                                            <asp:Parameter Name="SALESREP_PERCENT_3" Type="Decimal" />
                                            <asp:Parameter Name="SALESREP_PERCENT_4" Type="Decimal" />
                                            <asp:Parameter Name="COMMISSION_PERCENT" Type="Decimal" />
                                            <asp:Parameter Name="CONSIGN_WHSE_CODE" Type="String" />
                                            <asp:Parameter Name="ORDER_FLAGS" Type="String" />
                                        </InsertParameters>
                                    </asp:ObjectDataSource>
                                </td>
                                <td style="border-right: black thin solid; border-top: black thin solid; border-left: black thin solid; border-bottom: black thin solid; text-align: left;" vertical-align:"top">
                                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="odORDER_DETAILS" width="99%" >
                                        <Columns>
                                            <asp:BoundField DataField="ORDER_LINE_NUMB" HeaderText="LINE" SortExpression="ORDER_LINE_NUMB" />
                                            <asp:BoundField DataField="ITEM_CODE" HeaderText="ITEM" SortExpression="ITEM_CODE" >
                                                <ItemStyle Wrap="False" HorizontalAlign="Left" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="ITEM_DESC" HeaderText="DESCRIPTION" SortExpression="ITEM_DESC" >
                                                <ItemStyle Wrap="True" HorizontalAlign="Left" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="ITEM_UOM" HeaderText="UOM" SortExpression="ITEM_UOM" >
                                                <ItemStyle Wrap="True" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="QTY_ORD" HeaderText="QTY" SortExpression="QTY_ORD" DataFormatString="N2" >
                                                <ItemStyle Wrap="False" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="ITEM_PRICE_DISCOUNT" HeaderText="PRICE" SortExpression="ITEM_PRICE_DISCOUNT" >
                                                <ItemStyle Wrap="False" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="CUST_ITEM_CODE" HeaderText="YOUR ITEM" SortExpression="CUST_ITEM_CODE" >
                                                <ItemStyle Wrap="False" />
                                            </asp:BoundField>
                                        </Columns>
                                    </asp:GridView>
                                    <asp:ObjectDataSource ID="odORDER_DETAILS" runat="server" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}"
                                        SelectMethod="GetData" TypeName="OrderProcessingTableAdapters.OPCOODTTableAdapter">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="gvOpenOrders" Name="ORDER_NUMB" PropertyName="SelectedValue"
                                                Type="String" />
                                        </SelectParameters>
                                        <InsertParameters>
                                            <asp:Parameter Name="ORDER_NUMB" Type="String" />
                                            <asp:Parameter Name="ORDER_LINE_NUMB" Type="String" />
                                            <asp:Parameter Name="ITEM_CODE" Type="String" />
                                            <asp:Parameter Name="ITEM_DESC" Type="String" />
                                            <asp:Parameter Name="ITEM_UOM" Type="String" />
                                            <asp:Parameter Name="QTY_ORD" Type="Decimal" />
                                            <asp:Parameter Name="ITEM_PRICE_DISCOUNT" Type="Decimal" />
                                            <asp:Parameter Name="ITEM_PRICE_HOME" Type="Decimal" />
                                            <asp:Parameter Name="LOC_CODE" Type="String" />
                                            <asp:Parameter Name="COMMISSION_PERCENT" Type="Decimal" />
                                            <asp:Parameter Name="SALES_TAX_EXEMPT_IND" Type="String" />
                                            <asp:Parameter Name="ITEM_CLASS_CODE" Type="String" />
                                            <asp:Parameter Name="PRICE_CLASS_CODE" Type="String" />
                                            <asp:Parameter Name="CONTRACT_NUMB" Type="String" />
                                            <asp:Parameter Name="CUST_ITEM_CODE" Type="String" />
                                            <asp:Parameter Name="PKGS_TYPE_CODE" Type="String" />
                                            <asp:Parameter Name="PKGS_ORD" Type="Decimal" />
                                            <asp:Parameter Name="ORDER_MSG_L1" Type="String" />
                                            <asp:Parameter Name="ORDER_MSG_L2" Type="String" />
                                            <asp:Parameter Name="DATE_WANTED" Type="DateTime" />
                                            <asp:Parameter Name="DATE_PROMISED" Type="DateTime" />
                                            <asp:Parameter Name="LOT_ALLOC_FLAG" Type="String" />
                                            <asp:Parameter Name="SHIP_FLAG" Type="String" />
                                            <asp:Parameter Name="ORDER_LINE_FLAGS" Type="String" />
                                            <asp:Parameter Name="WHSE_CODE" Type="String" />
                                            <asp:Parameter Name="GENERIC_ITEM_CODE" Type="String" />
                                            <asp:Parameter Name="UNUSED1" Type="Decimal" />
                                            <asp:Parameter Name="UNUSEDA" Type="String" />
                                            <asp:Parameter Name="VAT_CODE" Type="String" />
                                            <asp:Parameter Name="VAT_RATE" Type="Decimal" />
                                            <asp:Parameter Name="UNUSEDB" Type="String" />
                                        </InsertParameters>
                                    </asp:ObjectDataSource>
                                </td>
                            </tr>
                        </table>
                    </asp:View>
                    <asp:View ID="view_ItemOrder" runat="server">
                        <table width:"60%">
                            <tr>
                                <td align:"right" colspan="3" style="text-align: center">
                                    <strong><span style="font-size: 16pt; color: #3300ff">Item Information</span></strong></td>
                            </tr>
                            <tr>
                                <td align:"right">
                                    <asp:TextBox ID="txtItemSelected" runat="server" BorderStyle="None"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtItemSelected"
                                        ErrorMessage="Item Required"></asp:RequiredFieldValidator></td>
                                <td align:"center" rowspan="3">
                                    <asp:FormView ID="fvItemInfo" runat="server" DataKeyNames="ITEM_CODE" DataSourceID="ObjectDataSource1"
                                        width="67%" Font-Size="X-Large">
                                        <EditItemTemplate>
                                            ITEM_CODE:
                                            <asp:Label ID="ITEM_CODELabel1" runat="server" Text='<%# Eval("ITEM_CODE") %>'></asp:Label><br />
                                            ITEM_DESCRIPTION:
                                            <asp:TextBox ID="ITEM_DESCRIPTIONTextBox" runat="server" Text='<%# Bind("ITEM_DESCRIPTION") %>'></asp:TextBox><br />
                                            ITEM_PACKAGE_CODE:
                                            <asp:TextBox ID="ITEM_PACKAGE_CODETextBox" runat="server" Text='<%# Bind("ITEM_PACKAGE_CODE") %>'></asp:TextBox><br />
                                            ITEM_CATEGORY:
                                            <asp:TextBox ID="ITEM_CATEGORYTextBox" runat="server" Text='<%# Bind("ITEM_CATEGORY") %>'></asp:TextBox><br />
                                            ITEM_TYPE:
                                            <asp:TextBox ID="ITEM_TYPETextBox" runat="server" Text='<%# Bind("ITEM_TYPE") %>'></asp:TextBox><br />
                                            ITEM_LINE:
                                            <asp:TextBox ID="ITEM_LINETextBox" runat="server" Text='<%# Bind("ITEM_LINE") %>'></asp:TextBox><br />
                                            ITEM_RESALE:
                                            <asp:CheckBox ID="ITEM_RESALECheckBox" runat="server" Checked='<%# Bind("ITEM_RESALE") %>' /><br />
                                            ITEM_CLASS_CODE:
                                            <asp:TextBox ID="ITEM_CLASS_CODETextBox" runat="server" Text='<%# Bind("ITEM_CLASS_CODE") %>'></asp:TextBox><br />
                                            ITEM_BASE:
                                            <asp:CheckBox ID="ITEM_BASECheckBox" runat="server" Checked='<%# Bind("ITEM_BASE") %>' /><br />
                                            PANTONE_COLOR:
                                            <asp:TextBox ID="PANTONE_COLORTextBox" runat="server" Text='<%# Bind("PANTONE_COLOR") %>'></asp:TextBox><br />
                                            PRODUCT_LINE_DESC:
                                            <asp:TextBox ID="PRODUCT_LINE_DESCTextBox" runat="server" Text='<%# Bind("PRODUCT_LINE_DESC") %>'></asp:TextBox><br />
                                            <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                                                Text="Update"></asp:LinkButton>
                                            <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                                Text="Cancel"></asp:LinkButton>
                                        </EditItemTemplate>
                                        <InsertItemTemplate>
                                            ITEM_CODE:
                                            <asp:TextBox ID="ITEM_CODETextBox" runat="server" Text='<%# Bind("ITEM_CODE") %>'></asp:TextBox><br />
                                            ITEM_DESCRIPTION:
                                            <asp:TextBox ID="ITEM_DESCRIPTIONTextBox" runat="server" Text='<%# Bind("ITEM_DESCRIPTION") %>'></asp:TextBox><br />
                                            ITEM_PACKAGE_CODE:
                                            <asp:TextBox ID="ITEM_PACKAGE_CODETextBox" runat="server" Text='<%# Bind("ITEM_PACKAGE_CODE") %>'></asp:TextBox><br />
                                            ITEM_CATEGORY:
                                            <asp:TextBox ID="ITEM_CATEGORYTextBox" runat="server" Text='<%# Bind("ITEM_CATEGORY") %>'></asp:TextBox><br />
                                            ITEM_TYPE:
                                            <asp:TextBox ID="ITEM_TYPETextBox" runat="server" Text='<%# Bind("ITEM_TYPE") %>'></asp:TextBox><br />
                                            ITEM_LINE:
                                            <asp:TextBox ID="ITEM_LINETextBox" runat="server" Text='<%# Bind("ITEM_LINE") %>'></asp:TextBox><br />
                                            ITEM_RESALE:
                                            <asp:CheckBox ID="ITEM_RESALECheckBox" runat="server" Checked='<%# Bind("ITEM_RESALE") %>' /><br />
                                            ITEM_CLASS_CODE:
                                            <asp:TextBox ID="ITEM_CLASS_CODETextBox" runat="server" Text='<%# Bind("ITEM_CLASS_CODE") %>'></asp:TextBox><br />
                                            ITEM_BASE:
                                            <asp:CheckBox ID="ITEM_BASECheckBox" runat="server" Checked='<%# Bind("ITEM_BASE") %>' /><br />
                                            PANTONE_COLOR:
                                            <asp:TextBox ID="PANTONE_COLORTextBox" runat="server" Text='<%# Bind("PANTONE_COLOR") %>'></asp:TextBox><br />
                                            PRODUCT_LINE_DESC:
                                            <asp:TextBox ID="PRODUCT_LINE_DESCTextBox" runat="server" Text='<%# Bind("PRODUCT_LINE_DESC") %>'></asp:TextBox><br />
                                            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
                                                Text="Insert"></asp:LinkButton>
                                            <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                                Text="Cancel"></asp:LinkButton>
                                        </InsertItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="ITEM_DESCRIPTIONLabel" runat="server" Text='<%# Bind("ITEM_DESCRIPTION") %>'
                                                width="736px"></asp:Label><br />
                                            <asp:Label ID="PRODUCT_LINE_DESCLabel" runat="server" Text='<%# Bind("PRODUCT_LINE_DESC") %>'
                                                width="736px"></asp:Label><br />
                                            <asp:Label ID="PANTONE_COLORLabel" runat="server" Text='<%# Bind("PANTONE_COLOR") %>'
                                                width="736px"></asp:Label><br />
                                        </ItemTemplate>
                                    </asp:FormView>
                                    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
                                        SelectMethod="GetData" TypeName="ItemInformationTableAdapters.INVENTORY_INFOTableAdapter">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="txtItemSelected" Name="ITEM_CODE" PropertyName="Text"
                                                Type="String" />
                                        </SelectParameters>
                                    </asp:ObjectDataSource>
                                </td>
                                <td align:"center" style="width: 166px">
                                    &nbsp;
                                    <asp:TextBox ID="txtQty" runat="server" width="56px"></asp:TextBox>&nbsp;
                                    <asp:Label ID="lblUOM" runat="server" Text="Pieces Ordered"></asp:Label><br />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtQty"
                                        ErrorMessage="Please Enter Quantity"></asp:RequiredFieldValidator><br />
                                    <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="txtQty"
                                        ErrorMessage="Please Enter the Quantity to Order" MaximumValue="10000" MinimumValue="1" Display="Dynamic" Type="Integer" width="152px">Order Quantity Invalid</asp:RangeValidator></td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td align="center" style="width: 166px">
                                    <asp:Button ID="btnAddToCart" runat="server" Text="Add to Cart" /><br />
                                    &nbsp;
                                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True" />
                                </td>
                            </tr>
                            <tr>
                                <td align="right">
                                    &nbsp;</td>
                                <td align="center" style="width: 166px">
                                    <br />
                                    <asp:Button ID="btnContinueShopping" runat="server" Text="Continue Shopping" /></td>
                            </tr>
                        </table>
                    </asp:View>
                </asp:MultiView>
</asp:Content>