tableextension 55000 "MAR Employee Ext." extends Employee
{
    fields
    {
        field(55000; "MAR User ID"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'User ID';
            TableRelation = "User Setup";

            trigger OnValidate()
            var
                Employee: Record Employee;
                EmployeeWithUserIDExistsErr: Label 'Employee with this User ID already exists';
            begin
                if "MAR User ID" <> '' then begin
                    Employee.SetRange("MAR User ID", "MAR User ID");
                    if Employee.FindSet() and (Employee.Count() > 1) then
                        Error(EmployeeWithUserIDExistsErr);
                end;
            end;
        }
    }
}