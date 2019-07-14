module EMAILER

    require 'pony'

    Pony.options = {
        :via => 'smtp',
        :via_options => {
            :address => 'smtp.mailgun.org',
            :port => '587',
            :enable_starttls_auto => true,
            :authenitcation => :plain,
            :user_name => 'postmaster@sandbox74fb8b2e824a43d59af7df8a5e334972.mailgun.org',
            :password => 'a8318745b824d30f2dde07c1dd7e1f01-afab6073-6cd6dc51'
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

            #{feedback}

            All the best,

            Ding Chavez
            """
        }

        Pony.mail(message)
    end
end