function sendMail (senderMail, password, ...
                    recipients, ...
                    subject, mail_message, ...
                    attachments)
% send_mail sends a mail message through Gmail
% function send_mail(subject, recipients, mail_message, attachments)
% input arguments:
% subject: A string - subject of the mail
% recipents: A cell array of strings - Email addresses of recipients
%                 eg. {'mail1@mail.com', 'mail2@mail.com'}
% mail_message: A cell array of strings - Actual body of the message A cell per line.
% attachments: A cell array of string - A cell per attachment: path to a file to attach Email.
%                      Use [] for none.

newlineInAscii1 = [13 10];
spaceInInAscii = 32;
% for printing, newline causes much confusion in matlab and is provided here as an alternative
newline = char(newlineInAscii1); 
spaceChar = char(spaceInInAscii);

% Don't touch unless you need to change the Email supplier (currently
% Gmail)
% Then this code will set up the preferences properly:
setpref('Internet','E_mail', senderMail);
mailServer = 'smtp.gmail.com';
setpref('Internet','SMTP_Server', mailServer);
setpref('Internet','SMTP_Username', senderMail);
setpref('Internet','SMTP_Password',password);
props = java.lang.System.getProperties;
props.setProperty('mail.smtp.auth','true');
props.setProperty('mail.smtp.socketFactory.class', 'javax.net.ssl.SSLSocketFactory');
props.setProperty('mail.smtp.socketFactory.port','465');

% Send the email
try
    sendmail(recipients, subject, mail_message, attachments);
    fprintf('Email sent.\n');
catch exception
    causeOfError = exception.identifier;
    specificDiagnosis = exception.message;
    
   % Branch here on an exception. If problem is a 
   % dimension mismatch, throw the appropriate error.
   if (strcmp(exception.identifier, ...
   'MATLAB:catenate:dimensionMismatch'))
      msg = longMsg(size(A,2), size(B,2));
      error('MATLAB:myFunction:Dimensionality', msg);

   % Otherwise, just let the error propagate.
   else       
       % identifier: 'MATLAB:sendmail:SmtpError'
       % message: 'Authentication failed.'
      if strfind(causeOfError, 'CannotOpenFile')
       % identifier: 'MATLAB:sendmail:CannotOpenFile'
       % message: 'Cannot open file "images\two_dollars.bmp".'          
          
          disp(causeOfError)
          disp(specificDiagnosis)
          %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          try  % send the message w/o attachment and report the issue via email regarding the attachment
            caveatMsg = 'report at least 1 attachment not found, esp:';
            fileExampleThatIsNotFound = specificDiagnosis;
            mail_message = strcat(mail_message, newline, caveatMsg, fileExampleThatIsNotFound);
            sendmail(recipients, subject, mail_message);
            fprintf('Email sent without attachment. [attachment Failed]\n');
          catch exception
            causeOf2ndError = exception.identifier;
            specificDiagnosisOf2ndError = exception.message;
    
            % Branch here on an exception. If problem is a dimension mismatch, throw the appropriate error.
            if (strcmp(exception.identifier, ...
                'MATLAB:catenate:dimensionMismatch'))
                msg2nd = longMsg(size(A,2), size(B,2));
                error('MATLAB:myFunction:Dimensionality', msg);

            % Otherwise, just let the error propagate.
            else  
                if strfind(causeOf2ndError, 'MATLAB:sendmail:SmtpError')
                   fprintf(specificDiagnosisOf2ndError); 
                end
                
                throw(exception);
            end
          end          
          %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%          
      else if strfind(causeOfError, 'MATLAB:sendmail:SmtpError')
              fprintf(specificDiagnosis); 
      end
      
      throw(exception);
      end
   end
end    % end try-catch
