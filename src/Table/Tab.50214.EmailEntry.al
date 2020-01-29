table 50214 "Email Entry"
{
    Caption = 'Email Entry';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
            AutoIncrement = true;
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
        field(26; "Email Template"; Media)
        {
            Caption = 'Email Template';
            DataClassification = CustomerContent;
        }
        field(27; "Attachment 1"; Media)
        {
            Caption = 'Attachment 1';
            DataClassification = CustomerContent;
        }
        field(28; "Attachment 2"; Media)
        {
            Caption = 'Attachment 2';
            DataClassification = CustomerContent;
        }
        field(29; "Attachment 3"; Media)
        {
            Caption = 'Attachment 3';
            DataClassification = CustomerContent;
        }
        field(30; "Attachment 4"; Media)
        {
            Caption = 'Attachment 4';
            DataClassification = CustomerContent;
        }
        field(31; "Has Error"; Boolean)
        {
            Caption = 'Has Error';
            DataClassification = CustomerContent;
        }
        field(32; "Error Description"; Text[750])
        {
            Caption = 'Error Description';
            DataClassification = CustomerContent;
        }
        field(33; "Last Modified Date"; Date)
        {
            Caption = 'Last Modified Date';
            DataClassification = CustomerContent;
        }
        field(34; "Last Modified Time"; Time)
        {
            Caption = 'Last Modified Date';
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

    trigger OnModify()
    begin
        "Last Modified Date" := Today();
        "Last Modified Time" := Time();
    end;
}
