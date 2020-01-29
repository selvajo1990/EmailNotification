table 50213 "Email Template Setup"
{
    Caption = 'Email Template Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Template Code"; Code[20])
        {
            Caption = 'Template Code';
            DataClassification = CustomerContent;
        }
        field(21; Description; Text[100])
        {
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
            TableRelation = if (Type = const(Group)) "User Task Group";
        }
        field(25; "Email Cc"; Text[500])
        {
            Caption = 'Email Cc';
            DataClassification = CustomerContent;
            TableRelation = if (Type = const(Group)) "User Task Group";
        }
        field(26; "Email Template"; Media)
        {
            Caption = 'Email Template';
            DataClassification = CustomerContent;
        }
        field(27; "Schedule Formula"; DateFormula)
        {
            Caption = 'Schedule Formula';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Template Code")
        {
            Clustered = true;
        }
    }
    procedure ImportTemplate()
    var
        TempBlobL: Codeunit "Temp Blob";
        FileMgtL: Codeunit "File Management";
        InStreamL: InStream;
        ReplaceBodyQst: Label 'Do you want to replace the existing template ?';
        FileFilterTxt: Label 'HTML Files(*.htm;*.html)|*.htm;*.html';
        ImportTxt: Label 'Select a file to import template';
        FileFilterExtensionTxt: Label 'htm,html';
    begin
        if "Email Template".HasValue() then
            if not Confirm(ReplaceBodyQst) then
                exit;

        if FileMgtL.BLOBImportWithFilter(TempBlobL, ImportTxt, '', FileFilterTxt, FileFilterExtensionTxt) = '' then
            exit;

        Clear("Email Template");
        TempBlobL.CreateInStream(InStreamL);
        "Email Template".ImportStream(InStreamL, Rec."Template Code");
        Modify();
    end;

    procedure ExportTemplate(UseDialogP: Boolean): Text
    var
        TempBlobL: Codeunit "Temp Blob";
        FileMgtL: Codeunit "File Management";
        OutStreamL: OutStream;
        NoDataErr: Label '%1 does have template.';
    begin
        TempBlobL.CreateOutStream(OutStreamL);
        "Email Template".ExportStream(OutStreamL);
        if not TempBlobL.HasValue() then
            Error(NoDataErr, Rec."Template Code");
        FileMgtL.BLOBExport(TempBlobL, "Template Code" + '.html', true);
    end;

    procedure DeleteTemplate()
    var
        DeleteBodyQst: Label 'Do you want to delete the template ?';
    begin
        if "Email Template".HasValue() then
            if not Confirm(DeleteBodyQst, false) then
                exit;
        Clear("Email Template");
        Modify();
    end;
}
