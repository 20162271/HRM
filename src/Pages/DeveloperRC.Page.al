page 55000 "MAR Developer RC"
{
    Caption = 'Developer Role Center';
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part("Developer RC Headline"; "MAR Developer RC Headline")
            {
                ApplicationArea = All;
            }
            part("Developer Activities"; "MAR Developer Activities")
            {
                ApplicationArea = All;
            }
            part("User Task List Part"; "MAR User Task List Part")
            {
                ApplicationArea = All;
            }
        }
    }
    
    actions
    {
        area(Creation)
        {
            action("Absence Registration")
            {
                ApplicationArea = All;
                Caption = 'Absence Registration';
                RunObject = Page "MAR Specific Employee Absences";
                ToolTip = 'This action allows to register an absence';
            }
            action("Time Registration")
            {
                ApplicationArea = All;
                Caption = 'Time Registration';
                RunObject = Page "MAR Simple Time Sheet List";
                ToolTip = 'This action allows to register work time';
            }
        }
        area(Processing)
        {
            action("My Team")
            {
                ApplicationArea = All;
                Caption = 'My Team';
                RunObject = Page "Employee List";
                ToolTip = 'This action allows to view My Team';
            }
        }
        area(Reporting)
        {
            action("My Information")
            {
                ApplicationArea = All;
                Caption = 'My Information';
                RunObject = Page "MAR Specific Employee Card";
                RunPageMode = View;
                ToolTip = 'This action allows to view My Information';
            }
        }
    }

    var
        EmployeeAbsence: Record "Employee Absence";
        TeamMemberCue: Record "Team Member Cue";
        TimeSheetHeader: Record "Time Sheet Header";
        TimeSheetLine: Record "Time Sheet Line";
        TimeSheetDetail: Record "Time Sheet Detail";
        TimeSheetManagement: Codeunit "Time Sheet Management";
        OrderProcessorRoleCenter: Page "Order Processor Role Center";
        HeadlineRCOrderProcessor: Page "Headline RC Order Processor";
        TeamMemberRoleCenter: Page "Team Member Role Center";
        TeamMemberActivities: Page "Team Member Activities";
        UserTasksActivities: Page "User Tasks Activities";
        TimeSheet: Page "Time Sheet";
        ActualSchedSummaryFactBox: Page "Actual/Sched. Summary FactBox";
        SpinnerPart: Page "Power BI Report Spinner Part";
        SalesRelationshipMgrRC: Page "Sales & Relationship Mgr. RC";
        SalesRelationshipMgrAct: Page "Sales & Relationship Mgr. Act.";
        EmployeeAbsences: Page "Employee Absences";
        TimeSheetStatus: Enum "Time Sheet Status";
}