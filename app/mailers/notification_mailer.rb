class NotificationMailer < ApplicationMailer

  def organization_approved_email(organization)
    @organization = organization
    mail(to: @organization.user.email, subject: 'Your Organization Has Been Approved!')
  end

  def campaign_approved_email(campaign, campaign_change)
    @campaign = campaign
    @campaign_change = campaign_change
    @action = campaign_change.action
    subject = ""
    if @action == "CREATE"
      subject = "Your Campaign Has Been Approved!"
    elsif @action == "UPDATE"
      subject = "Your Campaign Update Has Been Approved!"
    elsif @action == "DELETE"
      subject = "Your Campaign Deletion Has Been Approved!"
    end
    mail(to: @campaign_change.organization.user.email, subject: subject)
  end
end
