tableextension 55002 "MAR Employee Absence Ext." extends "Employee Absence"
{
    fields
    {
        field(55000; "MAR Status"; Enum "MAR Absence Status")
        {
            DataClassification = CustomerContent;
            Caption = 'Status';
            Editable = false;
        }
        field(55001; "MAR Team Lead Approval"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Team Lead Approval';
            Editable = false;
        }
        field(55002; "MAR HR Approval"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'HR Manager Approval';
            Editable = false;
        }
    }
}