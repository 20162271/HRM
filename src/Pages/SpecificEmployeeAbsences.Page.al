page 55009 "MAR Specific Employee Absences"
{
    Caption = 'Employee Absences';
    DataCaptionFields = "Employee No.";
    DelayedInsert = true;
    PageType = List;
    PopulateAllFields = true;
    SourceTable = "Employee Absence";
    SourceTableView = SORTING("Employee No.", "From Date");

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Employee No."; "Employee No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a number for the employee.';
                    Visible = false;
                }
                field("From Date"; "From Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the first day of the employee''s absence registered on this line.';
                }
                field("To Date"; "To Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the last day of the employee''s absence registered on this line.';
                }
                field("Cause of Absence Code"; "Cause of Absence Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a cause of absence code to define the type of absence.';
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies a description of the absence.';
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the quantity associated with absences, in hours or days.';
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies how each unit of the item or resource is measured, such as in pieces or hours. By default, the value in the Base Unit of Measure field on the item or resource card is inserted.';
                }
                field("Quantity (Base)"; "Quantity (Base)")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the quantity associated with absences, in hours or days.';
                    Visible = false;
                }
                field("MAR Status"; "MAR Status")
                {
                    ApplicationArea = All;
                    ToolTip = 'This field contains absence status';
                }
                field(Comment; Comment)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if a comment is associated with this entry.';
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = true;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Submit for approval")
            {
                ApplicationArea = All;
                Caption = 'Submit for approval';
                Image = ReleaseDoc;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ShortCutKey = 'F9';
                ToolTip = 'Submit selected line for approval';

                trigger OnAction()
                var
                    HumanResourceManagement: Codeunit "MAR Human Resource Management";
                begin
                    HumanResourceManagement.SubmitEmployeeAbsence(Rec);
                end;
            }
            action("Co&mments")
            {
                ApplicationArea = Comments;
                Caption = 'Co&mments';
                Image = ViewComments;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "Human Resource Comment Sheet";
                RunPageLink = "Table Name" = const("Employee Absence"),
                                "Table Line No." = field("Entry No.");
                ToolTip = 'View or add comments for the record.';
            }
        }
    }

    trigger OnOpenPage()
    var
        Employee: Record Employee;
    begin
        Employee.SetRange("MAR User ID", UserId);
        if not Employee.FindSet() then
            CurrPage.Editable := false;
        // TODO: Request HRM to create Employee Card
        SetRange("Employee No.", Employee."No.");
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    var
        Employee: Record Employee;
    begin
        Employee.SetRange("MAR User ID", UserId);
        if Employee.FindSet() then
            "Employee No." := Employee."No.";
    end;
}
