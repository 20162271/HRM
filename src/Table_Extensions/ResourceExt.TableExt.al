tableextension 55001 "MAR Resource Ext." extends Resource
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
                Resource: Record Resource;
                ResourceWithUserIDExistsErr: Label 'Resource with this User ID already exists';
            begin
                if "MAR User ID" <> '' then begin
                    Resource.SetRange("MAR User ID", "MAR User ID");
                    if Resource.FindSet() and (Resource.Count() > 1) then
                        Error(ResourceWithUserIDExistsErr);
                end;
            end;
        }
    }
}