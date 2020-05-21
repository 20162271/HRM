pageextension 55000 "MAR Employee Card Ext." extends "Employee Card"
{
    layout
    {
        addlast(General)
        {
            field("MAR User ID"; "MAR User ID")
            {
                ApplicationArea = All;
                ToolTip = 'This field contains the User ID';
                ShowMandatory = true;
            }
        }
    }
}