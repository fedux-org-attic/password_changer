Given(/^a user configuration file with:$/) do |string|
  step %Q(a file named "~/.config/password_changer/application.yaml" with:), string
end

Given(/^a file with user identities named "(.*?)" with:$/) do |name, string|
  content = []
  content << '"name","old_password","new_password"'
  content << string

  step %Q(a file named "#{name}.csv" with:), content.join("\n")
end
