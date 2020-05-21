page 55002 "MAR Project Manager RC"
{
    Caption = 'Project Manager Role Center';
    PageType = RoleCenter;
    
    actions
    {
        area(Creation)
        {
            action(CreationAreaAction)
            {
                ApplicationArea = All;
                Caption = 'Creation';
                RunObject = Page "Employee List";
                ToolTip = 'This action allows to view Employee List';
            }
        }
        area(Embedding)
        {
            action(EmbeddingAreaAction)
            {
                ApplicationArea = All;
                Caption = 'Embedding';
                RunObject = Page "Employee List";
                ToolTip = 'This action allows to view Employee List';
            }
        }
        area(Processing)
        {
            action(ProcessingAreaAction)
            {
                ApplicationArea = All;
                Caption = 'Processing';
                RunObject = Page "Employee List";
                ToolTip = 'This action allows to view Employee List';
            }
        }
        area(Reporting)
        {
            action(ReportingAreaAction)
            {
                ApplicationArea = All;
                Caption = 'Reporting';
                RunObject = Page "Employee List";
                ToolTip = 'This action allows to view Employee List';
            }
        }
        area(Sections)
        {
            group("Group")
            {
                Caption = 'Employees';
                action("Employees")
                {
                    ApplicationArea = BasicHR;
                    Caption = 'Employees';
                    RunObject = page "Employee List";
                    ToolTip = 'Employees';
                }
            }
        }
    }
}