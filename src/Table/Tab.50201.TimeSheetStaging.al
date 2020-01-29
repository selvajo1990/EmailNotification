table 50117 "Time Sheet Staging"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(2; "Employee ID"; text[50])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Client Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(4; "Job Diva Job No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(5; "Job Title"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(6; "Customer Ref No"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(7; "Assignment Division"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(8; "Email"; text[80])
        {
            DataClassification = CustomerContent;
        }
        field(9; "Work Phone"; code[20])
        {
            DataClassification = CustomerContent;
        }
        field(10; "Working City"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(11; "Working State"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(12; "ST Hours"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(13; "OT Hours"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(14; "DT Hours"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(15; "Total Hours"; Decimal)
        {
            DataClassification = CustomerContent;
        }

        // FUNC Need to recheck with JD sample data
        field(16; "Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Approved,"Pending Approval";
            OptionCaption = 'Approved,Pending Approval';
        }
        field(17; "Time Entry Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(18; "Week Ending Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(19; "Primary Sales"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(20; "Secondary Sales"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(21; "Tertiary Sales"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(22; "Primary Recruiter"; text[50])
        {
            DataClassification = CustomerContent;
        }
        field(23; "Secondary Recruiter"; text[50])
        {
            DataClassification = CustomerContent;
        }
        field(24; "Tertiary Recruiter"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(25; "Approver"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(26; "Approver Email"; text[50])
        {
            DataClassification = CustomerContent;
        }
        field(27; "Approver Phone"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(28; "PO Number"; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(29; "Regular Bill Rate"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(30; "Net Bill"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(31; "Regular Pay Rate"; Decimal)
        {
            DataClassification = CustomerContent;

        }
        field(32; "Overtime Bill Rate"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(33; "Overtime Pay Rate"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(34; "Double Time Bill Rate"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(35; "Double Time Pay Rate"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(36; "Bill Rate Per"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(37; "Pay Rate Per"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(38; "Billing Frequency"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        // TODO Verify with JD sample data
        field(39; "Total Reported Hours"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(40; "Payment Frequency"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(41; "Employee Status"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(42; "Approver Comments"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(43; "Employee Comments"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(44; "Uploaded By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(45; "Uploaded Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(46; "Uploaded Time"; Time)
        {
            DataClassification = CustomerContent;
        }
        field(47; "Error Description"; Text[500])
        {
            DataClassification = CustomerContent;
        }
        field(48; "Pay Schedule"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
            Description = 'For dev usage';
        }
        // field(49; "Pay Date"; Date)
        // {
        //     FieldClass = FlowField;
        //     CalcFormula = lookup ("Pay Date Calendar"."Pay Date" where("Payroll Division Code" = field("Pay Schedule"), "Week Ending Date" = field("Week Ending Date")));
        //     Editable = false;
        // }
        field(50; "Employee Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup (Employee."First Name" where("No." = field("Employee ID")));
            Editable = false;
        }
        field(51; "Validated"; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(52; "Holiday Hours"; Decimal)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Entry No")
        {
            Clustered = true;
        }
        key(SK; "Employee ID", "Time Entry Date", "Week Ending Date")
        {

        }
        key(SK2; "Error Description")
        {

        }
    }

    trigger OnInsert()
    begin
        "Uploaded By" := CopyStr(UserId(), 1, 50);
        "Uploaded Date" := Today();
        "Uploaded Time" := Time();
    end;

    trigger OnModify()
    begin
        "Uploaded By" := CopyStr(UserId(), 1, 50);
        "Uploaded Date" := Today();
        "Uploaded Time" := Time();
    end;
}