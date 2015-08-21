Public Class class_ItemInformation

    Public strITEM_CODE As String
    Public blnNOF As Boolean

    Dim strITEM_DESCRIPTION As String
    Dim strITEM_PACKAGE_CODE As String
    Dim strITEM_CATEGORY As String
    Dim strITEM_TYPE As String
    Dim strITEM_LINE As String
    Dim strITEM_RESALE As String
    Dim strITEM_CLASS_CODE As String
    Dim strITEM_BASE As String
    Dim strPANTONE_COLOR As String
    Dim strPRODUCT_LINE_DESC As String

    Public Property ITEM_CODE() As String
        Get
            ITEM_CODE = strITEM_CODE
        End Get
        Set(ByVal value As String)
            strITEM_CODE = value
            ReadItemCode()
        End Set
    End Property

    Private Sub ReadItemCode()

        Dim taItem As New ItemInformationTableAdapters.INVENTORY_INFOTableAdapter
        Dim dtItem As New ItemInformation.INVENTORY_INFODataTable
        Dim rowInfo As Data.DataRow

        taItem.Fill(dtItem, strITEM_CODE)
        Try
            rowInfo = dtItem.Rows(0)

            strITEM_DESCRIPTION = rowInfo("ITEM_DESCRIPTION").ToString
            strITEM_PACKAGE_CODE = rowInfo("ITEM_PACKAGE_CODE").ToString
            strITEM_CATEGORY = rowInfo("ITEM_CATEGORY").ToString
            strITEM_TYPE = rowInfo("ITEM_TYPE").ToString
            strITEM_LINE = rowInfo("ITEM_LINE").ToString
            strITEM_RESALE = rowInfo("ITEM_RESALE").ToString
            strITEM_CLASS_CODE = rowInfo("ITEM_CLASS_CODE").ToString
            strITEM_BASE = rowInfo("ITEM_BASE").ToString
            strPANTONE_COLOR = rowInfo("PANTONE_COLOR").ToString
            strPRODUCT_LINE_DESC = rowInfo("PRODUCT_LINE_DESC").ToString

        Catch ex As Exception
            blnNOF = True
        End Try

    End Sub
    Public ReadOnly Property ITEM_DESCRIPTION() As String
        Get
            ITEM_DESCRIPTION = strITEM_DESCRIPTION
        End Get
    End Property
    Public ReadOnly Property ITEM_PACKAGE_CODE() As String
        Get
            ITEM_PACKAGE_CODE = strITEM_PACKAGE_CODE
        End Get
    End Property
    Public ReadOnly Property ITEM_CATEGORY() As String
        Get
            ITEM_CATEGORY = strITEM_CATEGORY
        End Get
    End Property
    Public ReadOnly Property ITEM_TYPE() As String
        Get
            ITEM_TYPE = strITEM_TYPE
        End Get
    End Property
    Public ReadOnly Property ITEM_LINE() As String
        Get
            ITEM_LINE = strITEM_LINE
        End Get
    End Property
    Public ReadOnly Property ITEM_RESALE() As String
        Get
            ITEM_RESALE = strITEM_RESALE
        End Get
    End Property
    Public ReadOnly Property ITEM_CLASS_CODE() As String
        Get
            ITEM_CLASS_CODE = strITEM_CLASS_CODE
        End Get
    End Property
    Public ReadOnly Property ITEM_BASE() As String
        Get
            ITEM_BASE = strITEM_BASE
        End Get
    End Property
    Public ReadOnly Property PANTONE_COLOR() As String
        Get
            PANTONE_COLOR = strPANTONE_COLOR
        End Get
    End Property
    Public ReadOnly Property PRODUCT_LINE_DESC() As String
        Get
            PRODUCT_LINE_DESC = strPRODUCT_LINE_DESC
        End Get
    End Property


End Class
