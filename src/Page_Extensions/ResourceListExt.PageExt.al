pageextension 55003 "MAR Resource List Ext." extends "Resource List"
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