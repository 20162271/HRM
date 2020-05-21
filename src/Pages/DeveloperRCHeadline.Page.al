page 55004 "MAR Developer RC Headline"
{
    Caption = 'Headline';
    PageType = HeadlinePart;
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            group(Control1)
            {
                ShowCaption = false;
                field(HeadlineText; StrSubstNo(GreetingTxt, Employee."First Name"))
                {
                    ApplicationArea = All;
                    Caption = 'Headline';
                    Editable = false;
                    ToolTip = 'This field contains the Headline Text';
                }
            }
            group(Control2)
            {
                ShowCaption = false;
                field(HeadlineText2; StrSubstNo(GreetingTxt, Employee."First Name"))
                {
                    ApplicationArea = All;
                    Caption = 'Headline';
                    Editable = false;
                    ToolTip = 'This field contains the Headline Text';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Employee.SetRange("MAR User ID", UserId);
        if not Employee.FindSet() then
            Employee.Init();
    end;

    var
        Employee: Record Employee;
        GreetingTxt: Label '<qualifier></qualifier><payload>Welcome <emphasize>%1</emphasize> to the <emphasize>HRM</emphasize> implementation for D365BC</payload>', Comment = '%1 is used for Employee Name';
}
