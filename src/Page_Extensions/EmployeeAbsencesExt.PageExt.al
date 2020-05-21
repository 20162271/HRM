pageextension 55004 "MAR Employee Absences Ext." extends "Employee Absences"
{
    layout
    {
        addbefore(Comment)
        {
            field("MAR Status"; "MAR Status")
            {
                ApplicationArea = All;
                ToolTip = 'This field contains absence status';
            }
        }
    }
}