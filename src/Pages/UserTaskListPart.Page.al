page 55008 "MAR User Task List Part"
{
    Caption = 'User Task List';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "User Task";

    layout
    {
        area(content)
        {
            repeater(Control12)
            {
                ShowCaption = false;
                field(Title; Title)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the name of the task.';
                }
                field("Due DateTime"; "Due DateTime")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleTxt;
                    ToolTip = 'Specifies when the task must be completed.';
                }
                field(Priority; Priority)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the priority of the task compared to other tasks. Enter any number.';
                }
                field("Percent Complete"; "Percent Complete")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleTxt;
                    ToolTip = 'Specifies how much of the task has been completed.';
                }
                field("Assigned To User Name"; "Assigned To User Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who performs the task.';
                    Visible = false;
                }
                field("Created DateTime"; "Created DateTime")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the task was created.';
                }
                field("User Task Group Assigned To"; "User Task Group Assigned To")
                {
                    ApplicationArea = All;
                    Caption = 'User Task Group';
                    ToolTip = 'Specifies the group that the task belongs to.';
                }
                field("Completed DateTime"; "Completed DateTime")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the task was completed.';
                    Visible = false;
                }
                field("Start DateTime"; "Start DateTime")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the task was started.';
                    Visible = false;
                }
                field("Created By User Name"; "Created By User Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who created the task.';
                }
                field("Completed By User Name"; "Completed By User Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies who completed the task.';
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Open)
            {
                ApplicationArea = All;
                Caption = 'Open';
                Image = ViewDetails;
                RunObject = Page "User Task Card";
                RunPageLink = ID = field(ID);
                RunPageMode = View;
                Scope = Repeater;
                ShortCutKey = 'Return';
                ToolTip = 'Open the card for the selected record.';
            }
            action("Mark Complete")
            {
                ApplicationArea = All;
                Caption = 'Mark as Completed';
                Image = CheckList;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                ToolTip = 'Indicate that the task is completed. The % Complete field is set to 100.';

                trigger OnAction()
                var
                    UserTask: Record "User Task";
                    DoYouWantToCompleteQst: Label 'Do you really want to complete the selected tasks?';
                begin
                    if Confirm(DoYouWantToCompleteQst) then begin
                        CurrPage.SetSelectionFilter(UserTask);
                        if UserTask.FindSet(true) then
                            repeat
                                UserTask.SetCompleted();
                                UserTask.Modify();
                            until UserTask.Next() = 0;
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        StyleTxt := SetStyle();
    end;

    trigger OnFindRecord(Which: Text): Boolean
    var
        UserTaskManagement: Codeunit "User Task Management";
    begin
        UserTaskManagement.SetFiltersToShowMyUserTasks(Rec, 0);
        exit(Find(Which));
    end;

    var
        StyleTxt: Text;
}
