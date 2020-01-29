page 50217 "Sent Email Entry"
{

    PageType = List;
    SourceTable = "Sent Email Entry";
    Caption = 'Sent Email Entry';
    ApplicationArea = All;
    UsageCategory = Tasks;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; "Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Template Code"; "Template Code")
                {
                    ApplicationArea = All;
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                }
                field("Email Subject"; "Email Subject")
                {
                    ApplicationArea = All;
                }
                field("Email To"; "Email To")
                {
                    ApplicationArea = All;
                }
                field("Email Cc"; "Email Cc")
                {
                    ApplicationArea = All;
                }
                field("Entry Date"; "Entry Date")
                {
                    ApplicationArea = All;
                }
                field("Entry Time"; "Entry Time")
                {
                    ApplicationArea = All;
                }
                field("Scheduled Date"; "Scheduled Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
