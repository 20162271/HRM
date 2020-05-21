pageextension 55001 "MAR Employee List Ext." extends "Employee List"
{
    layout
    {
        addlast(Control1)
        {
            field("MAR User ID"; "MAR User ID")
            {
                ApplicationArea = All;
                ToolTip = 'This field contains the User ID';
            }
        }
    }
}