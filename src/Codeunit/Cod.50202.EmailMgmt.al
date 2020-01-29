codeunit 50202 "Email Mgmt."
{
    trigger OnRun()
    var
        EmailEntryL: Record "Email Entry";
        SentEntryL: Record "Sent Email Entry";
    begin
        EmailEntryL.SetRange("Scheduled Date", 0D, Today());
        if EmailEntryL.FindSet(true, false) then
            repeat
                if not SendEmail(EmailEntryL) then begin
                    EmailEntryL."Error Description" := CopyStr(GetLastErrorText(), 1, 750);
                    EmailEntryL."Has Error" := true;
                    EmailEntryL.Modify(true);
                end else begin
                    SentEntryL.TransferFields(EmailEntryL);
                    SentEntryL.Insert(true);
                    EmailEntryL.Delete();
                end;
            until EmailEntryL.Next() = 0;
    end;

    // To trigger email on validate JD Date from timesheet staging
    procedure AlertOverWorkedHours(var TempTimeSheetStagingP: Record "Time Sheet Staging" temporary; EmailTemplateCodeP: Code[20])
    var
        LineTemplateL: Text;
        AllLineL: Text;
        AlertLinesTxt: Label '<tr><td style="width: 113px;">EmployeeID</td><td style="width: 155px;">Name</td><td style="width: 95px;">STHours</td><td style="width: 97px;">OTHours</td><td style="width: 102px;">PayDate</td></tr>';
    begin
        OriginalTemplateG := GetTemplateAsText(EmailTemplateCodeP, EmailSubjectG);
        TempTimeSheetStagingP.SetAutoCalcFields("Employee Name");
        if TempTimeSheetStagingP.FindSet() then
            repeat
                LineTemplateL := AlertLinesTxt;
                LineTemplateL := LineTemplateL.Replace('EmployeeID', TempTimeSheetStagingP."Employee ID");
                LineTemplateL := LineTemplateL.Replace('Name', TempTimeSheetStagingP."Employee Name");
                LineTemplateL := LineTemplateL.Replace('STHours', Format(TempTimeSheetStagingP."ST Hours"));
                LineTemplateL := LineTemplateL.Replace('OTHours', Format(TempTimeSheetStagingP."OT Hours"));
                LineTemplateL := LineTemplateL.Replace('PayDate', Format(TempTimeSheetStagingP."Time Entry Date"));
                AllLineL += LineTemplateL
            until TempTimeSheetStagingP.Next() = 0;
        OriginalTemplateG := OriginalTemplateG.Replace('LineLoop', AllLineL);
        InsertEmailEntry(EmailTemplateCodeP, EmailSubjectG, OriginalTemplateG);
    end;

    procedure GetTemplateAsText(EmailTemplateCodeP: Code[20]; var EmailSubjectP: Text[100]): Text
    var
        EmailTemplateSetupL: Record "Email Template Setup";
        TempBlobL: Codeunit "Temp Blob";
        TypeHelperL: Codeunit "Type Helper";
        OutStreamL: OutStream;
        InStreamL: InStream;
    begin
        EmailTemplateSetupL.Get(EmailTemplateCodeP);
        EmailSubjectP := EmailTemplateSetupL."Email Subject";
        TempBlobL.CreateOutStream(OutStreamL);
        EmailTemplateSetupL."Email Template".ExportStream(OutStreamL);
        TempBlobL.CreateInStream(InStreamL);
        exit(TypeHelperL.ReadAsTextWithSeparator(InStreamL, TypeHelperL.CRLFSeparator()));
    end;

    procedure InsertEmailEntry(EmailTemplateCodeP: Code[20]; EmailSubjectP: Text[100]; OriginalTemplateP: Text)
    var
        EmailEntryL: Record "Email Entry";
        EmailTemplateSetupL: Record "Email Template Setup";
        TempBlobL: Codeunit "Temp Blob";
        InStreamL: InStream;
        OutStreamL: OutStream;
        ScheduledTxt: Label '<%1>';

    begin
        with EmailTemplateSetupL do begin
            Get(EmailTemplateCodeP);
            TestField("Email To");
            EmailEntryL.Init();
            EmailEntryL."Entry No." := 0;
            EmailEntryL."Template Code" := "Template Code";
            EmailEntryL.Type := Type;
            EmailEntryL."Email Subject" := EmailSubjectP;
            EmailEntryL."Email To" := "Email To";
            EmailEntryL."Email Cc" := "Email Cc";
            TempBlobL.CreateOutStream(OutStreamL);
            OutStreamL.WriteText(OriginalTemplateP);
            TempBlobL.CreateInStream(InStreamL);
            EmailEntryL."Email Template".ImportStream(InStreamL, "Template Code", 'html');
            EmailEntryL."Scheduled Date" := Today();
            if Format("Schedule Formula") > '' then
                EmailEntryL."Scheduled Date" := CalcDate(StrSubstNo(ScheduledTxt, "Schedule Formula"), Today());
            EmailEntryL.Insert(true);
        end;
    end;


    [TryFunction]
    procedure SendEmail(EmailEntryP: Record "Email Entry")
    var
        SmtpSetupL: Record "SMTP Mail Setup";
        UserTaskGroupMemberL: Record "User Task Group Member";
        UserSetupL: Record "User Setup";
        TypeHelperL: Codeunit "Type Helper";
        TempBlobL: Codeunit "Temp Blob";
        SmtpMailL: Codeunit "SMTP Mail";
        SmtpConfigErr: Label 'SMTP setup is missing.';
        EmailToL: List of [Text];
        EmailCcL: List of [Text];
        CounterL: Integer;
        OutStreamL: OutStream;
        InStreamL: InStream;
    begin
        if not SmtpMailL.IsEnabled() then
            Error(SmtpConfigErr);
        SmtpSetupL.Get();
        SmtpMailL.Initialize();
        SmtpMailL.AddFrom(SmtpSetupL."Send As", SmtpSetupL."User ID");
        if EmailEntryP.Type = EmailEntryP.Type::Single then begin
            EmailToL.Add(EmailEntryP."Email To");
            EmailCcL.Add(EmailEntryP."Email Cc");
        end else
            for CounterL := 1 to 2 do begin
                UserTaskGroupMemberL.SetAutoCalcFields("User Name");
                if CounterL = 1 then
                    UserTaskGroupMemberL.SetRange("User Task Group Code", EmailEntryP."Email To")
                else
                    UserTaskGroupMemberL.SetRange("User Task Group Code", EmailEntryP."Email Cc");
                if UserTaskGroupMemberL.FindSet() then
                    repeat
                        UserSetupL.Get(UserTaskGroupMemberL."User Name");
                        UserSetupL.TestField("E-Mail");
                        if CounterL = 1 then
                            EmailToL.Add(UserSetupL."E-Mail")
                        else
                            EmailCcL.Add(UserSetupL."E-Mail");
                    until UserTaskGroupMemberL.Next() = 0;
            end;
        SmtpMailL.AddRecipients(EmailToL);
        SmtpMailL.AddCC(EmailCcL);
        SmtpMailL.AddSubject(EmailEntryP."Email Subject");
        TempBlobL.CreateOutStream(OutStreamL);
        EmailEntryP."Email Template".ExportStream(OutStreamL);
        TempBlobL.CreateInStream(InStreamL);
        SmtpMailL.AddBody(TypeHelperL.ReadAsTextWithSeparator(InStreamL, TypeHelperL.CRLFSeparator()));
        if not SmtpMailL.Send() then
            Error(SmtpMailL.GetLastSendMailErrorText());
    end;

    var
        OriginalTemplateG: Text;
        EmailSubjectG: Text[100];
}