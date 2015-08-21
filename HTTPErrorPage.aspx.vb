
Partial Class HTTPErrorPage
    Inherits System.Web.UI.Page
    Dim ex As HttpException = Nothing

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        ex = CType(Server.GetLastError, HttpException)
        Dim httpCode As Integer = ex.GetHttpCode

        ' Filter for Error Codes and set text
        If ((httpCode >= 400) AndAlso (httpCode < 500)) Then
            ex = New HttpException(httpCode, _
              "Safe message for 4xx HTTP codes.", ex)
        ElseIf (httpCode > 499) Then
            ex = New HttpException(ex.ErrorCode, _
              "Safe message for 5xx HTTP codes.", ex)
        Else
            ex = New HttpException(httpCode, _
              "Safe message for unexpected HTTP codes.", ex)
        End If

        ' Log the exception and notify system operators
        ExceptionUtility.LogException(ex, "HttpErrorPage")
        ExceptionUtility.NotifySystemOps(ex)

        ' Fill the page fields
        exMessage.Text = ex.Message
        exTrace.Text = ex.StackTrace

        ' Show Inner Exception fields for local access
        If ex.InnerException IsNot Nothing Then
            innerTrace.Text = ex.InnerException.StackTrace
            InnerErrorPanel.Visible = Request.IsLocal
            innerMessage.Text = _
              "HTTP " & httpCode & ": " & ex.InnerException.Message
        End If

        ' Show Trace for local access
        exTrace.Visible = Request.IsLocal
        ' Clear the error from the server
        Server.ClearError()
    End Sub
End Class
