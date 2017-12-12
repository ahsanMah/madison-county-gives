# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file was generated by Cucumber-Rails and is only here to get you a head start
# These step definitions are thin wrappers around the Capybara/Webrat API that lets you
# visit pages, interact with widgets and make assertions about page content.
#
# If you use these step definitions as basis for your features you will quickly end up
# with features that are:
#
# * Hard to maintain
# * Verbose to read
#
# A much better approach is to write your own higher level step definitions, following
# the advice in the following blog posts:
#
# * http://benmabey.com/2008/05/19/imperative-vs-declarative-scenarios-in-user-stories.html
# * http://dannorth.net/2011/01/31/whose-domain-is-it-anyway/
# * http://elabs.se/blog/15-you-re-cuking-it-wrong
#


require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(*selector_for(locator)) { yield } : yield
  end
end
World(WithinHelpers)

# Single-line step scoper
When /^(.*) within (.*[^:])$/ do |step, parent|
  with_scope(parent) { When step }
end

# Multi-line step scoper
When /^(.*) within (.*[^:]):$/ do |step, parent, table_or_string|
  with_scope(parent) { When "#{step}:", table_or_string }
end


Given /^these Users:$/ do |table|
  table.hashes.each do |h|
    User.create!(h)
  end
end


Given /^these Organizations:$/ do |table|
  table.hashes.each do |h|
    Organization.create!(h)
  end
end


Given /^these Campaigns:$/ do |table|
  table.hashes.each do |h|
    Campaign.create!(h)
  end
end

Given /^these CampaignChanges:$/ do |table|
  table.hashes.each do |h|
    CampaignChange.create!(h)
  end
end

Given /^these ShortQuestions:$/ do |table|
  table.hashes.each do |h|
    ShortQuestion.create!(h)
  end
end

Given /^these ShortResponses:$/ do |table|
  table.hashes.each do |h|
    ShortResponse.create!(h)
  end
end



Given /^debug$/ do
  debugger
end


Given /^(?:|I )am signed in as (.*)$/ do |name|
  org = Organization.where("name = ?", name).first
  if org.nil?
    user = User.where("email = ?", name).first
    visit new_user_session_path
    fill_in "Email", :with => user.email
    fill_in "Password", :with => "123456"
    click_button "Log in"
  else
    user = org.user
    visit new_user_session_path
    fill_in "Email", :with => user.email
    fill_in "Password", :with => "123456"
    click_button "Log in"
  end
end

Given /^I am signed out$/ do
  current_driver = Capybara.current_driver
  begin
    Capybara.current_driver = :rack_test
    page.driver.submit :delete, destroy_user_session_path, {}
  ensure
    Capybara.current_driver = current_driver
  end
end

Then /^the campaign cards should contain "([^"]*)"$/ do |text|
    card = page.all('.campaign').first
    expect(card).to have_content(text)
end

Then /^the campaign cards should not contain "([^"]*)"$/ do |text|
    card = page.all('.campaign').first
    expect(card).not_to have_content(text)
end

Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )go to (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )press "([^"]*)"$/ do |button|
  click_button(button)
end

When /^(?:|I )follow "([^"]*)"$/ do |link|
  click_link(link)
end

When /^(?:|I )fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end

When /^(?:|I )fill in "([^"]*)" for "([^"]*)"$/ do |value, field|
  fill_in(field, :with => value)
end

# Use this to fill in an entire form with data from a table. Example:
#
#   When I fill in the following:
#     | Account Number | 5002       |
#     | Expiry date    | 2009-11-01 |
#     | Note           | Nice guy   |
#     | Wants Email?   |            |
#
# TODO: Add support for checkbox, select or option
# based on naming conventions.
#
When /^(?:|I )fill in the following:$/ do |fields|
  fields.rows_hash.each do |name, value|
    fill_in(name, :with => value)
  end
end

When /^(?:|I )select "([^"]*)" from "([^"]*)"$/ do |value, field|
  select(value, :from => field)
end

When /^(?:|I )check "([^"]*)"$/ do |field|
  check(field)
end

When /^(?:|I )uncheck "([^"]*)"$/ do |field|
  uncheck(field)
end

When /^(?:|I )choose "([^"]*)"$/ do |field|
  choose(field)
end

When /^(?:|I )attach the file "([^"]*)" to "([^"]*)"$/ do |path, field|
  actual_image_path = "features/test_images/" + path
  attach_file(field, File.expand_path(actual_image_path))
end

Then /^(?:|I )should see ["']([^"]*)["']$/ do |text|
  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
end

Then /^(?:|I )should see \/([^\/]*)\/$/ do |regexp|
  regexp = Regexp.new(regexp)

  if page.respond_to? :should
    page.should have_xpath('//*', :text => regexp)
  else
    assert page.has_xpath?('//*', :text => regexp)
  end
end

Then /^(?:|I )should not see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_no_content(text)
  else
    assert page.has_no_content?(text)
  end
end

Then /^(?:|I )should not see \/([^\/]*)\/$/ do |regexp|
  regexp = Regexp.new(regexp)

  if page.respond_to? :should
    page.should have_no_xpath('//*', :text => regexp)
  else
    assert page.has_no_xpath?('//*', :text => regexp)
  end
end

Then /^the "([^"]*)" field(?: within (.*))? should contain "([^"]*)"$/ do |field, parent, value|
  with_scope(parent) do
    field = find_field(field)
    field_value = (field.tag_name == 'textarea') ? field.text : field.value
    if field_value.respond_to? :should
      field_value.should =~ /#{value}/
    else
      assert_match(/#{value}/, field_value)
    end
  end
end

Then /^the "([^"]*)" field(?: within (.*))? should not contain "([^"]*)"$/ do |field, parent, value|
  with_scope(parent) do
    field = find_field(field)
    field_value = (field.tag_name == 'textarea') ? field.text : field.value
    if field_value.respond_to? :should_not
      field_value.should_not =~ /#{value}/
    else
      assert_no_match(/#{value}/, field_value)
    end
  end
end

Then /^the "([^"]*)" field should have the error "([^"]*)"$/ do |field, error_message|
  element = find_field(field)
  classes = element.find(:xpath, '..')[:class].split(' ')

  form_for_input = element.find(:xpath, 'ancestor::form[1]')
  using_formtastic = form_for_input[:class].include?('formtastic')
  error_class = using_formtastic ? 'error' : 'field_with_errors'

  if classes.respond_to? :should
    classes.should include(error_class)
  else
    assert classes.include?(error_class)
  end

  if page.respond_to?(:should)
    if using_formtastic
      error_paragraph = element.find(:xpath, '../*[@class="inline-errors"][1]')
      error_paragraph.should have_content(error_message)
    else
      page.should have_content("#{field.titlecase} #{error_message}")
    end
  else
    if using_formtastic
      error_paragraph = element.find(:xpath, '../*[@class="inline-errors"][1]')
      assert error_paragraph.has_content?(error_message)
    else
      assert page.has_content?("#{field.titlecase} #{error_message}")
    end
  end
end

Then /^the "([^"]*)" field should have no error$/ do |field|
  element = find_field(field)
  classes = element.find(:xpath, '..')[:class].split(' ')
  if classes.respond_to? :should
    classes.should_not include('field_with_errors')
    classes.should_not include('error')
  else
    assert !classes.include?('field_with_errors')
    assert !classes.include?('error')
  end
end

Then /^the "([^"]*)" checkbox(?: within (.*))? should be checked$/ do |label, parent|
  with_scope(parent) do
    field_checked = find_field(label)['checked']
    if field_checked.respond_to? :should
      field_checked.should be_true
    else
      assert field_checked
    end
  end
end

Then /^the "([^"]*)" checkbox(?: within (.*))? should not be checked$/ do |label, parent|
  with_scope(parent) do
    field_checked = find_field(label)['checked']
    if field_checked.respond_to? :should
      field_checked.should be_false
    else
      assert !field_checked
    end
  end
end

Then /^(?:|I )should be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == path_to(page_name)
  else
    assert_equal path_to(page_name), current_path
  end
end

Then /^(?:|I )should not be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should_not == path_to(page_name)
  else
    assert_not_equal path_to(page_name), current_path
  end
end


Then /^(?:|I )should have the following query string:$/ do |expected_pairs|
  query = URI.parse(current_url).query
  actual_params = query ? CGI.parse(query) : {}
  expected_params = {}
  expected_pairs.rows_hash.each_pair{|k,v| expected_params[k] = v.split(',')}

  if actual_params.respond_to? :should
    actual_params.should == expected_params
  else
    assert_equal expected_params, actual_params
  end
end

Then /^show me the page$/ do
  save_and_open_page
end

#################################  NEW WEB STEP DEFINITIONS   #########################################

When /^(?:|I )click on [^"]*"([^"]*)"$/ do |link|
  click_link(link)
end

When /^(?:|I )click "([^"]*)" for "([^"]*)"$/ do |button, title|
  row = find('.card') { |el| el.text =~ Regexp.new(title)}
  within(row) do
    click_on(button)
  end
end


# Then /^(?:|I )should see the image "([^"]*)"$/ do |imagename|
#   expect(page).to have_selector(%(img[@alt="#{imagename.capitalize}"]))
# end

Then /^I should see the image "(.*)"$/ do |img_name|
  expect(page).to have_css("img[src*= #{img_name}]")
end

#hard-coded css classes?  More flexible approach possible?

Then /^I should see "([^"]*)" in the organization's profile$/ do |item|
  card = find('.organization')
  expect(card.text).to match Regexp.escape(item)
end

Then /^I should not see "([^"]*)" in the organization's profile$/ do |item|
  card = find('.organization')
  expect(card.text).not_to match Regexp.escape(item)
end

And /^(?:|I )should see that the campaign "([^"]*)" has a[n]? ([a-z_A-Z]*) of "([^"]*)"$/ do |title, attribute, value|
  row = all('.campaign').find('.card') { |el| el.text =~ Regexp.new(title) }
  expect(row.find(".#{attribute}").text).to match Regexp.escape(value)
end

And /^(?:|I )should see that the pending campaign "([^"]*)" has a[n]? ([a-z_A-Z]*) of "([^"]*)"$/ do |title, attribute, value|
  row = all('.campaign-change').find('.card') { |el| el.text =~ Regexp.new(title) }
  expect(row.find(".#{attribute}").text).to match Regexp.escape(value)
end

Then /^(?:|I )should see that the campaign "([^"]*)" has an image "([^"]*)"$/ do |title, image|
  row = all('.campaign').find('.card') { |el| el.text =~ Regexp.new(title)}
  expect(row.find('img')['src']).to match Regexp.escape(image)
end

And /^(?:|I )should see that the organization "([^"]*)" has a[n]? ([a-z_A-Z]*) of "([^"]*)"$/ do |title, attribute, value|
  row = all('.organizations').find('tr') { |el| el.text =~ Regexp.new(title) }
  expect(row.find('.#{attribute}').text).to eq '#{value}'
end

Given /^there is a donation for "([^"]*)" for "([^"]*)"$/ do # helper function to add session data for cart MAY BE UNNEEDED WILL ASK SOMMERS FOR HELP
  pending
end

When /^(?:|I )click on "([^"]*)" in the nav bar$/ do |link|
  within("ul.navbar-nav") do
    click_link(link)
  end
end

When /^(?:|I )click on my organization "([^"]*)" in the nav bar$/ do |link|
  li = page.find("li.nav-item.dropdown.active", text: link)
  within(li) do
    click_link(link)
  end
end
