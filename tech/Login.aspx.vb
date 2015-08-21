
Partial Class Login
    Inherits System.Web.UI.Page



    Protected Sub Login1_LoggedIn(sender As Object, e As EventArgs) Handles Login1.LoggedIn
        Session("CUST_CODE") = Login1.UserName
    End Sub

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

    End Sub
End Class
