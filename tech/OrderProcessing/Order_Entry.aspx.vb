
Partial Class OrderProcessing_Order_Entry

    Inherits System.Web.UI.Page

    Public IsEditMode As Boolean = True

    Dim intViewCurrentOrder As Integer = 0
    Dim intViewCopyOrder As Integer = 1
    Dim intViewAddItems As Integer = 2
    Dim intViewNewPMS As Integer = 3
    Dim intViewOpenOrders As Integer = 4
    Dim intViewSelectedItem As Integer = 5


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            '    Session("CUST_CODE") = ""
            Session("COPY_INV") = ""
            Session("COPY_DATE") = "01/01/1997"
            MultiView1.ActiveViewIndex = intViewOpenOrders
            Me.txtOrderStartDate.Text = DateTime.Today.ToShortDateString
        End If

    End Sub

    Protected Sub linkMenu_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lbAddlItems.Click, lbCopyOrder.Click, lblCart.Click, lbNewPMS.Click, lbOpenOrders.Click
        Dim lbSent As LinkButton
        lbSent = sender
        MultiView1.ActiveViewIndex = lbSent.CommandArgument
    End Sub


    Protected Sub GridView2_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles gvOrderHist.SelectedIndexChanged

        Session("CallingView") = MultiView1.ActiveViewIndex
        Me.txtItemSelected.Text = gvOrderHist.SelectedDataKey(0).ToString
        Me.fvItemInfo.DataBind()

        MultiView1.ActiveViewIndex = intViewSelectedItem

    End Sub


    Protected Sub GridView1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles gvAllItemsOrdered.SelectedIndexChanged

        Session("CallingView") = MultiView1.ActiveViewIndex
        Me.txtItemSelected.Text = Me.gvAllItemsOrdered.SelectedDataKey(0).ToString
        Me.fvItemInfo.DataBind()

        MultiView1.ActiveViewIndex = intViewSelectedItem

    End Sub



    Protected Property IsInEditMode() As Boolean
        Get
            Return IsEditMode
        End Get

        Set(ByVal value As Boolean)
            IsEditMode = value
        End Set

    End Property



    Protected Sub gvCSAHH_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles gvCSAHH.SelectedIndexChanged
        Try
            Session("COPY_INV") = gvCSAHH.SelectedDataKey(0).ToString
            Session("COPY_DATE") = gvCSAHH.SelectedDataKey(1).ToString
            gvOrderHist.DataBind()
        Catch ex As Exception

        End Try

    End Sub





    Protected Sub btnAddToCart_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAddToCart.Click
        Dim taOrderLine As New OrderProcessingTableAdapters.Order_DetailsTableAdapter
        Try
            taOrderLine.AddOrderDetail(Me.txtItemSelected.Text, Me.txtQty.Text, "", Session("CUST_CODE"))
            gvCart.DataBind()

            MultiView1.ActiveViewIndex = Session("CallingView")
            Me.txtQty.Text = 0
            Me.fvCartCount.DataBind()
        Catch ex As Exception

        End Try

    End Sub

    Protected Sub btnContinueShopping_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnContinueShopping.Click
        MultiView1.ActiveViewIndex = Session("CallingView")
    End Sub
    

    Protected Sub btnPlaceOrder_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnPlaceOrder.Click
        Dim taSaveOrder As New OrderProcessingTableAdapters.Order_DetailsTableAdapter

        IsEditMode = False
        Email_Order()
        'Update_Current_Order()
        taSaveOrder.SaveWorkOrder(Session("CUST_CODE"))

        '        Dim taOrderDelete As New OrderProcessingTableAdapters.Order_DetailsTableAdapter
        '        taOrderDelete.DeleteQuery_AllLines(Session("CUST_CODE"))
        gvCart.DataBind()

    End Sub

    Private Sub Email_Order()

        Email_Class.SendMailMessage("btrader@bsink.com", "rloomis@bsink.com", "btrader@bsink.com", "dansmith@pioneersolutions.com", "this is an order test", GenerateInvoice())
        'Email_Class.SendMailMessage("dsmith@pioneersolutions.com", "dansmith@pioneersolutions.com", "", "", "this is an order test", GenerateInvoice())
    End Sub

    Public Function GenerateInvoice() As String
        Dim invoiceHtml As New StringBuilder()
        Dim taOrderDetail As New OrderProcessingTableAdapters.Order_DetailsTableAdapter
        Dim dtOrderDetail As New OrderProcessing.Order_DetailsDataTable
        Dim row As Data.DataRow
        Dim lblData As Label
        Dim strCityStateZip As String
        Dim intColor As Int16
        Dim strColor As String


        taOrderDetail.Fill(dtOrderDetail, Session("CUST_CODE"))

        'invoiceHtml.Append("<b>Order : ").Append(invoiceToGenerate.InvoiceId.ToString()).Append("</b><br />")
        invoiceHtml.Append("<b>DATE : </b>").Append(DateTime.Now.ToShortDateString()).Append("<br />")

        'CREATE ADDRESS TABLE AND POPULATE
        invoiceHtml.Append("<table>")
        invoiceHtml.Append("<tr>")
        'row 1 - title
        invoiceHtml.Append("<td style=""width: 3.9in"">").Append("<br /><b>CUSTOMER CONTACT INFO:</b><br />").Append("</td>")
        invoiceHtml.Append("<td style=""width: 3.9in"">").Append("<br /><b>SHIP TO:</b><br />").Append("</td>")
        invoiceHtml.Append("</tr>")

        'row 2 names
        invoiceHtml.Append("<tr>")
        lblData = Me.fvCustomer.FindControl("CUST_NAMELabel")
        invoiceHtml.Append("<td style=""width: 3.9in"">").Append(lblData.Text).Append("<br />").Append("</td>")
        lblData = Me.fvShipTo.FindControl("CUST_SHIPTO_NAMELabel")
        invoiceHtml.Append("<td style=""width: 3.9in"">").Append(lblData.Text).Append("<br />").Append("</td>")
        invoiceHtml.Append("</tr>")

        'row 3 address line 1
        invoiceHtml.Append("<tr>")
        lblData = Me.fvCustomer.FindControl("CUST_ADDR_L1Label")
        invoiceHtml.Append("<td style=""width: 3.9in"">").Append(lblData.Text).Append("<br />").Append("</td>")
        lblData = Me.fvShipTo.FindControl("CUST_SHIPTO_ADDR_L1Label")
        invoiceHtml.Append("<td style=""width: 3.9in"">").Append(lblData.Text).Append("<br />").Append("</td>")
        invoiceHtml.Append("</tr>")

        'row 3 address line 2
        invoiceHtml.Append("<tr>")
        invoiceHtml.Append("<td style=""width: 3.9in"">")
        lblData = Me.fvCustomer.FindControl("CUST_ADDR_L2Label")
        If lblData.Text <> "" Then
            invoiceHtml.Append(lblData.Text).Append("</td>")
        Else
            invoiceHtml.Append("</td>")
        End If
        invoiceHtml.Append("<td style=""width: 3.9in"">")
        lblData = Me.fvShipTo.FindControl("CUST_SHIPTO_ADDR_L2Label")
        If lblData.Text <> "" Then
            invoiceHtml.Append(lblData.Text).Append("</td>")
        Else
            invoiceHtml.Append("</td>")
        End If
        invoiceHtml.Append("</tr>")


        'row 4 address line 3
        invoiceHtml.Append("<td style=""width: 3.9in"">")
        lblData = Me.fvCustomer.FindControl("CUST_ADDR_L3Label")
        If lblData.Text <> "" Then
            invoiceHtml.Append(lblData.Text).Append("</td>")
        Else
            invoiceHtml.Append("</td>")
        End If
        invoiceHtml.Append("<td style=""width: 3.9in"">")
        lblData = Me.fvShipTo.FindControl("CITYLabel")
        strCityStateZip = lblData.Text
        lblData = Me.fvShipTo.FindControl("STATELabel")
        strCityStateZip = strCityStateZip + ", " + lblData.Text
        lblData = Me.fvShipTo.FindControl("ZIPLabel")
        strCityStateZip = strCityStateZip + "  " + lblData.Text
        invoiceHtml.Append(strCityStateZip).Append("</td>")
        invoiceHtml.Append("</tr>")

        'row 5 address line 4
        invoiceHtml.Append("<tr>")
        invoiceHtml.Append("<td style=""width: 3.9in"">")
        lblData = Me.fvCustomer.FindControl("CITY_STATE_ZIPLabel")
        If lblData.Text <> "" Then
            invoiceHtml.Append(lblData.Text).Append("</td>")
        Else
            invoiceHtml.Append("</td>")
        End If
        invoiceHtml.Append("<td style=""width: 3.9in"">")
        lblData = Me.fvShipTo.FindControl("CUST_SHIPTO_ADDR_L4Label")
        If lblData.Text <> "" Then
            invoiceHtml.Append(lblData.Text).Append("</td>")
        Else
            invoiceHtml.Append("</td>")
        End If
        invoiceHtml.Append("</tr>")
        invoiceHtml.Append("</table>")


        'ORDER INFO LINE (PO DATE WANTED ETC...)
        invoiceHtml.Append("<table border=""1"">")
        strColor = "#E0E0E0"
        'row 1 - title
        invoiceHtml.Append("<tr bgcolor=""").Append(strColor).Append("""").Append(">")
        invoiceHtml.Append("<td style=""width: 1.5in"">").Append("<br /><b>PO Number</b><br />").Append("</td>")
        invoiceHtml.Append("<td style=""width: 1.5in"">").Append("<br /><b>DATE WANTED</b><br />").Append("</td>")
        invoiceHtml.Append("<td style=""width: 3.5in"">").Append("<br /><b>CONTACT NAME</b><br />").Append("</td>")
        invoiceHtml.Append("<td style=""width: 1.5in"">").Append("<br /><b>PHONE</b><br />").Append("</td>")
        invoiceHtml.Append("</tr>")
        strColor = "White"
        'row 2 - title info
        invoiceHtml.Append("<tr bgcolor=""").Append(strColor).Append("""").Append(">")
        invoiceHtml.Append("<td style=""width: 1.5in"">")
        lblData = Me.fvOrderInfo.FindControl("CUST_PO_NUMBLabel")
        If lblData.Text <> "" Then
            invoiceHtml.Append(lblData.Text).Append("</td>")
        Else
            invoiceHtml.Append("</td>")
        End If
        invoiceHtml.Append("<td style=""width: 1.5in"">")
        lblData = Me.fvOrderInfo.FindControl("DATE_WANTEDLabel")
        If lblData.Text <> "" Then
            invoiceHtml.Append(lblData.Text).Append("</td>")
        Else
            invoiceHtml.Append("</td>")
        End If
        invoiceHtml.Append("<td style=""width: 3.5in"">")
        lblData = Me.fvOrderInfo.FindControl("ORDER_CONTACTLabel")
        If lblData.Text <> "" Then
            invoiceHtml.Append(lblData.Text).Append("</td>")
        Else
            invoiceHtml.Append("</td>")
        End If
        invoiceHtml.Append("<td style=""width: 1.5in"">")
        lblData = Me.fvOrderInfo.FindControl("ORDER_CONTACT_PHONELabel")
        If lblData.Text <> "" Then
            invoiceHtml.Append(lblData.Text).Append("</td>")
        Else
            invoiceHtml.Append("</td>")
        End If
        invoiceHtml.Append("</tr>")

        invoiceHtml.Append("<br /><b>PRODUCTS:</b><br /><table><tr><th>Line</th><th>Item</th><th>Description</th><th>Qty</th></tr>")
        ' InvoiceItem should be a collection property which contains list of invoice lines
        intColor = 2
        For Each row In dtOrderDetail
            If intColor = 2 Then
                strColor = "#E0E0E0"
                intColor = 0
            Else
                strColor = "White"
            End If
            invoiceHtml.Append("<tr bgcolor=""").Append(strColor).Append("""").Append("><td>").Append(row("ORDER_LINE_NUMB")).Append("</td><td>").Append(row("ITEM_CODE")).Append("</td><td>").Append(row("DESCRIPTION")).Append("</td><td>").Append(row("QTY_ORD")).Append("</td></tr>")
            intColor = intColor + 1
        Next
        invoiceHtml.Append("</table>")

        invoiceHtml.Append("<table>")
        invoiceHtml.Append("<tr>")
        invoiceHtml.Append("<td style=""width: 8.0in"">")
        invoiceHtml.Append("<b>CUSTOMER COMMENTS : </b>").Append("</td>")
        invoiceHtml.Append("</tr>")
        invoiceHtml.Append("<tr>")
        lblData = Me.fvOrderInfo.FindControl("ORDER_NOTESLabel")
        invoiceHtml.Append("<td style=""width: 8.0in"">")
        If lblData.Text <> "" Then
            invoiceHtml.Append(lblData.Text).Append("</td>")
        Else
            invoiceHtml.Append("</td>")
        End If
        invoiceHtml.Append("</tr>")
        invoiceHtml.Append("</table>")

        Return invoiceHtml.ToString()
    End Function

    Protected Sub btnClearOrder_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnClearOrder.Click
        Dim taOrderDelete As New OrderProcessingTableAdapters.Order_DetailsTableAdapter
        taOrderDelete.DeleteQuery_AllLines(Session("CUST_CODE"))
        gvCart.DataBind()

    End Sub

    Protected Sub btnContinue_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnContinue.Click
        If Session("CallingView") = 0 Then
            Session("CallingView") = intViewCopyOrder
        End If
        MultiView1.ActiveViewIndex = Session("CallingView")
    End Sub


    Protected Sub gvPMS_Items_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles gvPMS_Items.SelectedIndexChanged

        Session("CallingView") = MultiView1.ActiveViewIndex
        Me.txtItemSelected.Text = Me.gvPMS_Items.SelectedDataKey(0).ToString
        Me.fvItemInfo.DataBind()

        MultiView1.ActiveViewIndex = intViewSelectedItem

    End Sub



        Protected Sub fvShipTo_ItemUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.FormViewUpdateEventArgs)
        'Dim txtBoxCity As TextBox
        'Dim txtBoxState As TextBox
        'Dim txtBoxZip As TextBox



        ' Dim strCity As String
        ' Dim strState As String
        ' Dim strZip As String
        '  txtBoxCity = Me.fvShipTo.FindControl("CITYtextbox")
        '  txtBoxState = Me.fvShipTo.FindControl("STATEtextbox")
        '  txtBoxZip = Me.fvShipTo.FindControl("ZIPtextbox")
        '  strCity = txtBoxCity.Text
        '  strState = txtBoxState.Text
        '  strZip = txtBoxZip.Text


    End Sub


    Protected Sub ddlShipTo_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles ddlShipTo.SelectedIndexChanged
        Dim taShipTo As New OrderProcessingTableAdapters.WOOHDTableAdapter
        Try
            taShipTo.UpdateShipToQuery(Session("CUST_CODE"), Me.ddlShipTo.SelectedValue)
        Catch ex As Exception

        End Try
    End Sub
End Class

