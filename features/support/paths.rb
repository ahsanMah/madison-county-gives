# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the login page$/
      new_user_session_path

    when /^the home\s?page$/
      '/'

    when /^the campaigns? index page$/
      campaigns_path

    when /^the organizations? index page$/
      organizations_path

    when /^Test Organization ([0-9])'s page$/
      organization_path($1.to_i)

    when  /^the create new campaign page$/
      new_campaign_change_path

    when /^the create new organization page$/
      new_organization_path

    when /^the admin dashboard page$/
      admin_path

    when /^the admin database page$/
      rails_admin_path

    when /^the about us page$/
      about_us_path

    when /^the FAQs page$/
      faqs_path

    when /^the contact us page$/
      contact_us_path
      
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    when  /^the create new campaign page$/
      new_campaign_change_path

    when /^organizations\/(.*)$/
      organization_path($1.to_i)

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
