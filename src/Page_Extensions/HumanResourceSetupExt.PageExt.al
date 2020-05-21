pageextension 55005 "MAR Human Resource Setup Ext." extends "Human Resources Setup"
{
    layout
    {
        addlast(content)
        {
            group("MAR HR Units of Measure")
            {
                Caption = 'Human Resource Units of Measure';

                field("MAR Hour Unit of Measure"; "MAR Hour Unit of Measure")
                {
                    ApplicationArea = All;
                    ToolTip = 'This field specifies Human Resource Hour Unit of Measure';
                }
                field("MAR Day Unit of Measure"; "MAR Day Unit of Measure")
                {
                    ApplicationArea = All;
                    ToolTip = 'This field specifies Human Resource Day Unit of Measure';
                }
            }
        }
    }
}