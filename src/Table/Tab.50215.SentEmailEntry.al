table 50215 "Sent Email Entry"
{
    Caption = 'Sent Email Entry';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
        }
        field(21; "Template Code"; Code[20])
        {
            Caption = 'Template Code';
            DataClassification = CustomerContent;
        }
        field(22; Type; Option)
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
            OptionMembers = Single,Group;
            OptionCaption = 'Single,Group';
        }
        field(23; "Email Subject"; Text[100])
        {
            Caption = 'Email Subject';
            DataClassification = CustomerContent;
        }
        field(24; "Email To"; Text[500])
        {
            Caption = 'Email To';
            DataClassification = CustomerContent;
        }
        field(25; "Email Cc"; Text[500])
        {
            Caption = 'Email Cc';
            DataClassification = CustomerContent;
        }
        field(35; "Entry Date"; Date)
        {
            Caption = 'Entry Date';
            DataClassification = CustomerContent;
        }
        field(36; "Entry Time"; Time)
        {
            Caption = 'Entry Time';
            DataClassification = CustomerContent;
        }
        field(37; "Scheduled Date"; Date)
        {
            Caption = 'Scheduled Date';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin
        "Entry Date" := Today();
        "Entry Time" := Time();
    end;
}
