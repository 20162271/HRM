tableextension 55003 "MAR Human Resource Setup Ext." extends "Human Resources Setup"
{
    fields
    {
        field(55000; "MAR Hour Unit of Measure"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Hour Unit of Measure';
            TableRelation = "Human Resource Unit of Measure";

            trigger OnValidate()
            var
                EmployeeAbsence: Record "Employee Absence";
                EmployeeAbsenceUseThisUoMErr: Label 'You cannot change %1 because there are %2 that use this Unit of Measure', Comment = '%1 - the Hour Unit of Measure field caption. %2 - the Employee Absence Table Caption';
            begin
                if ("MAR Hour Unit of Measure" <> xRec."MAR Hour Unit of Measure") and (xRec."MAR Hour Unit of Measure" <> '') then begin
                    EmployeeAbsence.SetRange("Unit of Measure Code", xRec."MAR Hour Unit of Measure");
                    if not EmployeeAbsence.IsEmpty then
                        Error(EmployeeAbsenceUseThisUoMErr, FieldCaption("MAR Hour Unit of Measure"), EmployeeAbsence.TableCaption);
                end;
            end;
        }
        field(55001; "MAR Day Unit of Measure"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Day Unit of Measure';
            TableRelation = "Human Resource Unit of Measure";

            trigger OnValidate()
            var
                EmployeeAbsence: Record "Employee Absence";
                EmployeeAbsenceUseThisUoMErr: Label 'You cannot change %1 because there are %2 that use this Unit of Measure', Comment = '%1 - the Day Unit of Measure field caption. %2 - the Employee Absence Table Caption';
            begin
                if ("MAR Day Unit of Measure" <> xRec."MAR Day Unit of Measure") and (xRec."MAR Day Unit of Measure" <> '') then begin
                    EmployeeAbsence.SetRange("Unit of Measure Code", xRec."MAR Day Unit of Measure");
                    if not EmployeeAbsence.IsEmpty then
                        Error(EmployeeAbsenceUseThisUoMErr, FieldCaption("MAR Day Unit of Measure"), EmployeeAbsence.TableCaption);
                end;
            end;
        }
    }
}