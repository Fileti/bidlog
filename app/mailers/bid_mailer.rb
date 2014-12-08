class BidMailer < ActionMailer::Base
  # TODO fixar o from para todos, talvez no config?
  default from: 'bidlog@mcorp.io'

  def invite(user)
    @user = user

    mail(to: user.email, subject: "Convite para participar de um bid")
  end
end
