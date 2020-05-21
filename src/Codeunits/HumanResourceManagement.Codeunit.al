codeunit 55000 "MAR Human Resource Management"
{
    trigger OnRun()
    begin
        Message('Human Resource Management');
    end;

    [EventSubscriber(ObjectType::Table, Database::Employee, 'OnBeforeInsertEvent', '', false, false)]
    local procedure SetEmploymentDateIfEmptyOnBeforeInsertEmployee(var Rec: Record Employee; RunTrigger: Boolean)
    begin
        if Rec."Employment Date" = 0D then
            Rec."Employment Date" := WorkDate();
    end;

    [EventSubscriber(ObjectType::Page, Page::"Employee Card", 'OnQueryClosePageEvent', '', false, false)]
    local procedure CheckUserIDOnQueryCloseEmployeeCardPage(var Rec: Record Employee; var AllowClose: Boolean)
    var
        ContinueWithEmptyUserIDQst: Label 'User ID field value should not be empty. Do you want to continue without filling in this field?';
    begin
        if Rec."MAR User ID" = '' then
            AllowClose := Confirm(ContinueWithEmptyUserIDQst);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Resource Card", 'OnQueryClosePageEvent', '', false, false)]
    local procedure CheckUserIDOnQueryCloseResourceCardPage(var Rec: Record Resource; var AllowClose: Boolean)
    var
        ContinueWithEmptyUserIDQst: Label 'User ID field value should not be empty. Do you want to continue without filling in this field?';
    begin
        if Rec."MAR User ID" = '' then
            AllowClose := Confirm(ContinueWithEmptyUserIDQst);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Employee Absence", 'OnAfterValidateEvent', 'From Date', false, false)]
    local procedure CheckDatesAndCalculateQuantityOnAfterValidateFromDate(var xRec: Record "Employee Absence"; var Rec: Record "Employee Absence"; CurrFieldNo: Integer)
    begin
        if (Rec."From Date" <> 0D) and (Rec."To Date" <> 0D) then begin
            CheckFromAndToDate(Rec."From Date", Rec."To Date");
            CalculateAbsenceTimeQuantity(Rec);
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Employee Absence", 'OnAfterValidateEvent', 'To Date', false, false)]
    local procedure CheckDatesAndCalculateQuantityOnAfterValidateToDate(var xRec: Record "Employee Absence"; var Rec: Record "Employee Absence"; CurrFieldNo: Integer)
    begin
        if (Rec."From Date" <> 0D) and (Rec."To Date" <> 0D) then begin
            CheckFromAndToDate(Rec."From Date", Rec."To Date");
            CalculateAbsenceTimeQuantity(Rec);
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Employee Absence", 'OnAfterValidateEvent', 'Cause of Absence Code', false, false)]
    local procedure CheckDatesAndCalculateQuantityOnAfterValidateCauseOfAbsenceCode(var xRec: Record "Employee Absence"; var Rec: Record "Employee Absence"; CurrFieldNo: Integer)
    begin
        if (Rec."From Date" <> 0D) and (Rec."To Date" <> 0D) then
            CalculateAbsenceTimeQuantity(Rec);
    end;

    procedure OpenThisWeekTimeSheet(RunFromAction: Boolean)
    var
        Resource: Record Resource;
        TimeSheetHeader: Record "Time Sheet Header";
        TimeSheetLine: Record "Time Sheet Line";
        TimeSheetMgt: Codeunit "Time Sheet Management";
    begin
        Resource.SetRange("MAR User ID", UserId);
        if Resource.FindSet() then begin
            TimeSheetHeader.SetRange("Resource No.", Resource."No.");
            TimeSheetHeader.SetFilter("Starting Date", '..%1', WorkDate());
            TimeSheetHeader.SetFilter("Ending Date", '%1..', WorkDate());
            if TimeSheetHeader.FindSet() then begin
                if RunFromAction then
                    TimeSheetMgt.SetTimeSheetNo(TimeSheetHeader."No.", TimeSheetLine)
                else
                    TimeSheetLine.SetRange("Time Sheet No.", TimeSheetHeader."No.");
                if TimeSheetLine.FindSet() or RunFromAction then
                    Page.Run(Page::"Time Sheet", TimeSheetLine);
            end;
        end;
    end;

    procedure SubmitEmployeeAbsence(EmployeeAbsence: Record "Employee Absence")
    begin
        CheckEmployeeAbsenceValues(EmployeeAbsence);
    end;

    local procedure CheckEmployeeAbsenceValues(EmployeeAbsence: Record "Employee Absence")
    begin
        EmployeeAbsence.TestField("MAR Status", EmployeeAbsence."MAR Status"::Open.AsInteger());
        EmployeeAbsence.TestField("From Date");
        EmployeeAbsence.TestField("To Date");
        CheckFromAndToDate(EmployeeAbsence."From Date", EmployeeAbsence."To Date");
        EmployeeAbsence.TestField("Cause of Absence Code");
        EmployeeAbsence.TestField(Quantity);
        EmployeeAbsence.TestField("Unit of Measure Code");
    end;

    local procedure CheckFromAndToDate(FromDate: Date; ToDate: Date)
    var
        ToDateEarlierThanFromDateErr: Label 'From Date can not be earlier that To Date';
    begin
        if FromDate > ToDate then
            Error(ToDateEarlierThanFromDateErr);
    end;

    local procedure CalculateAbsenceTimeQuantity(var EmployeeAbsence: Record "Employee Absence")
    var
        HumanResourcesSetup: Record "Human Resources Setup";
        Resource: Record Resource;
        ResCapacityEntry: Record "Res. Capacity Entry";
        Capacity: Decimal;
    begin
        HumanResourcesSetup.Get();
        HumanResourcesSetup.TestField("MAR Hour Unit of Measure");
        HumanResourcesSetup.TestField("MAR Day Unit of Measure");

        EmployeeAbsence.Validate(Quantity, 0);

        case EmployeeAbsence."Unit of Measure Code" of
            HumanResourcesSetup."MAR Hour Unit of Measure":
                begin
                    Resource.SetRange("MAR User ID", UserId);
                    if Resource.FindSet() then begin
                        ResCapacityEntry.SetRange("Resource No.", Resource."No.");
                        ResCapacityEntry.SetRange(Date, EmployeeAbsence."From Date", EmployeeAbsence."To Date");
                        if ResCapacityEntry.FindSet() then begin
                            repeat
                                Capacity += ResCapacityEntry.Capacity;
                            until ResCapacityEntry.Next() = 0;
                            EmployeeAbsence.Validate(Quantity, Capacity);
                        end;
                    end;
                end;
            HumanResourcesSetup."MAR Day Unit of Measure":
                if EmployeeAbsence."Unit of Measure Code" = HumanResourcesSetup."MAR Day Unit of Measure" then
                    EmployeeAbsence.Validate(Quantity, EmployeeAbsence."To Date" - EmployeeAbsence."From Date" + 1);
        end;
    end;
}