table 55000 "MAR Developer Cue"
{
    DataClassification = CustomerContent;
    Caption = 'Developer Cue';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Primary Key';
        }
        field(20; "Time This Week"; Decimal)
        {
            CalcFormula = sum ("Time Sheet Detail".Quantity where("Time Sheet No." = field("Time Sheet No. Filter")));
            Caption = 'Time This Week';
            FieldClass = FlowField;
            DecimalPlaces = 0 : 2;
        }
        field(21; "Time Yesterday"; Decimal)
        {
            CalcFormula = sum ("Time Sheet Detail".Quantity where("Time Sheet No." = field("Time Sheet No. Filter"),
                                                        Date = field("Yesterday Date Filter")));
            Caption = 'Time Yesterday';
            FieldClass = FlowField;
            DecimalPlaces = 0 : 2;
        }
        field(22; "Time Today"; Decimal)
        {
            CalcFormula = sum ("Time Sheet Detail".Quantity where("Time Sheet No." = field("Time Sheet No. Filter"),
                                                        Date = field("Today Date Filter")));
            Caption = 'Time Today';
            FieldClass = FlowField;
            DecimalPlaces = 0 : 2;
        }
        field(30; "Requests to Approve"; Integer)
        {
            CalcFormula = count ("Approval Entry" where("Approver ID" = field("User ID Filter"),
                                                        Status = filter(Open)));
            Caption = 'Requests to Approve';
            FieldClass = FlowField;
        }
        field(100; "User ID Filter"; Code[50])
        {
            Caption = 'User ID Filter';
            FieldClass = FlowFilter;
        }
        field(101; "Time Sheet No. Filter"; Code[20])
        {
            Caption = 'Time Sheet No. Filter';
            FieldClass = FlowFilter;
        }
        field(102; "This Week Date Filter"; Date)
        {
            Caption = 'This Week Date Filter';
            FieldClass = FlowFilter;
        }
        field(103; "Yesterday Date Filter"; Date)
        {
            Caption = 'Yesterday Date Filter';
            FieldClass = FlowFilter;
        }
        field(104; "Today Date Filter"; Date)
        {
            Caption = 'Today Date Filter';
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}