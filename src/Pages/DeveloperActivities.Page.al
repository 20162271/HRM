page 55005 "MAR Developer Activities"
{
    Caption = 'Self-Service';
    PageType = CardPart;
    RefreshOnActivate = true;
    ShowFilter = false;
    SourceTable = "MAR Developer Cue";

    layout
    {
        area(content)
        {
            cuegroup("Time Sheets")
            {
                Caption = 'Time Sheets';
                field("Time This Week"; "Time This Week")
                {
                    ApplicationArea = All;
                    Caption = 'Time This Week';
                    Image = Time;
                    ToolTip = 'Specifies the number of hours worked this week';

                    trigger OnDrillDown()
                    var
                        HumanResourceManagement: Codeunit "MAR Human Resource Management";
                    begin
                        HumanResourceManagement.OpenThisWeekTimeSheet(false);
                    end;
                }
                field("Time Yesterday"; "Time Yesterday")
                {
                    ApplicationArea = All;
                    Caption = 'Time Yesterday';
                    Image = Time;
                    ToolTip = 'Specifies the number of hours worked Yesterday';

                    trigger OnDrillDown()
                    var
                        HumanResourceManagement: Codeunit "MAR Human Resource Management";
                    begin
                        HumanResourceManagement.OpenThisWeekTimeSheet(false);
                    end;
                }
                field("Time Today"; "Time Today")
                {
                    ApplicationArea = All;
                    Caption = 'Time Today';
                    Image = Time;
                    ToolTip = 'Specifies the number of hours worked Today';

                    trigger OnDrillDown()
                    var
                        HumanResourceManagement: Codeunit "MAR Human Resource Management";
                    begin
                        HumanResourceManagement.OpenThisWeekTimeSheet(false);
                    end;
                }
            }
            cuegroup("Time Sheet Actions")
            {
                ShowCaption = false;

                actions
                {
                    action("This Week Time Sheet")
                    {
                        ApplicationArea = All;
                        Caption = 'This Week Time Sheet';
                        Image = TileReport;
                        ToolTip = 'This action allows to view this week time sheet';

                        trigger OnAction()
                        var
                            HumanResourceManagement: Codeunit "MAR Human Resource Management";
                        begin
                            HumanResourceManagement.OpenThisWeekTimeSheet(true);
                        end;
                    }
                }
            }
            cuegroup(Approvals)
            {
                Caption = 'Approvals';
                field("Requests to Approve"; "Requests to Approve")
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Requests to Approve";
                    ToolTip = 'Specifies requests for certain documents, cards, or journal lines that you must approve for other users before they can proceed.';
                }
            }
            cuegroup("My Tasks")
            {
                Caption = 'My Tasks';
                field("Pending Tasks"; UserTaskManagement.GetMyPendingUserTasksCount())
                {
                    ApplicationArea = All;
                    Caption = 'Pending Tasks';
                    Image = Checklist;
                    ToolTip = 'Specifies the number of pending tasks that are assigned to you or to a group that you are a member of.';

                    trigger OnDrillDown()
                    var
                        UserTaskList: Page "User Task List";
                    begin
                        UserTaskList.SetPageToShowMyPendingUserTasks();
                        UserTaskList.Run();
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        Resource: Record Resource;
        TimeSheetHeader: Record "Time Sheet Header";
    begin
        Reset();
        if not Get() then begin
            Init();
            Insert();
        end;

        SetRange("User ID Filter", UserId);

        Resource.SetRange("MAR User ID", UserId);
        if Resource.FindSet() then begin
            TimeSheetHeader.SetRange("Resource No.", Resource."No.");
            TimeSheetHeader.SetFilter("Starting Date", '..%1', WorkDate());
            TimeSheetHeader.SetFilter("Ending Date", '%1..', WorkDate());
            if not TimeSheetHeader.FindSet() then
                TimeSheetHeader.Init();
            SetRange("Time Sheet No. Filter", TimeSheetHeader."No.");
            SetRange("Yesterday Date Filter", WorkDate() - 1);
            SetRange("Today Date Filter", WorkDate());
        end;
    end;

    var
        UserTaskManagement: Codeunit "User Task Management";
}
