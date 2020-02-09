module EMAILER

    require 'pony'

    Pony.options = {
        :via => 'smtp',
        :via_options => {
            :address => 'smtp.mailgun.org',
            :port => '587',
            :enable_starttls_auto => true,
            :authenitcation => :plain,
            :user_name => 'not_real@sandbox.mailgun.org',
            :password => 'fake_password'
        }
    }


    def EMAILER::feedback_message(from, to, subject, user, feedback)
        message ={
            :from => from,
            :to => to,
            :subject => subject,
            :body =>
            """
            Dear #{user},

            We have recieved the below feedback and will endevour to respond to you shortly!

            \"#{feedback}\"

            All the best,

            Ding Chavez
            """
        }

        Pony.mail(message)
    end
end