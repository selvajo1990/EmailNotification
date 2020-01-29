page 50216 "Email Entry"
{

    PageType = List;
    SourceTable = "Email Entry";
    Caption = 'Email Entry';
    ApplicationArea = All;
    UsageCategory = Tasks;
    //Editable = false; 
    // INFO Uncomment before releasing for test

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
                field("Has Error"; "Has Error")
                {
                    ApplicationArea = All;
                }
                field("Error Description"; "Error Description")
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
