page 55006 "MAR Simple Time Sheet List"
{
    Caption = 'Time Sheets';
    PageType = List;
    SourceTable = "Time Sheet Header";
    SourceTableView = sorting("Resource No.", "Starting Date");
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                }
                field("Starting Date"; "Starting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the starting date for a time sheet.';
                }
                field("Ending Date"; "Ending Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the ending date for a time sheet.';
                }
                field(Comment; Comment)
                {
                    ApplicationArea = Comments;
                    ToolTip = 'Specifies that a comment about this document has been entered.';
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(EditTimeSheet)
            {
                ApplicationArea = All;
                Caption = '&Edit Time Sheet';
                Image = OpenJournal;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ShortCutKey = 'Return';
                ToolTip = 'Open the time sheet in edit mode.';

                trigger OnAction()
                begin
                    OpenTimeSheetPage();
                end;
            }
            action(Comments)
            {
                ApplicationArea = All;
                Caption = 'Co&mments';
                Image = ViewComments;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                RunObject = Page "Time Sheet Comment Sheet";
                RunPageLink = "No." = FIELD("No."),
                                  "Time Sheet Line No." = CONST(0);
                ToolTip = 'View or add comments for the record.';
            }
        }
    }

    trigger OnOpenPage()
    var
        TimeSheetMgt: Codeunit "Time Sheet Management";
    begin
        TimeSheetMgt.FilterTimeSheets(Rec, FieldNo("Owner User ID"));
    end;

    local procedure OpenTimeSheetPage()
    var
        TimeSheetLine: Record "Time Sheet Line";
        TimeSheetMgt: Codeunit "Time Sheet Management";
    begin
        TimeSheetMgt.SetTimeSheetNo("No.", TimeSheetLine);
        PAGE.Run(PAGE::"Time Sheet", TimeSheetLine);
    end;
}
