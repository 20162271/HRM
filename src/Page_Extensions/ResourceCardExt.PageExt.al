pageextension 55002 "MAR Resource Card Ext." extends "Resource Card"
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