page 50215 "Email Template Setup"
{

    PageType = List;
    SourceTable = "Email Template Setup";
    Caption = 'Email Template Setup';
    ApplicationArea = All;
    UsageCategory = Tasks;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Template Code"; "Template Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
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
                field("Schedule Formula"; "Schedule Formula")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Import Template")
            {
                ApplicationArea = All;
                Image = Import;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    ImportTemplate();
                end;
            }
            action("Export Template")
            {
                ApplicationArea = All;
                Image = Export;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    ExportTemplate(true);
                end;
            }
            action("Delete Template")
            {
                ApplicationArea = All;
                Image = Delete;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    DeleteTemplate();
                end;
            }
            action("Template")
            {
                ApplicationArea = All;
                Image = Template;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    EmailSetupL: Codeunit "Email Mgmt.";
                begin
                    EmailSetupL.Run();
                end;
            }
        }
    }

}
