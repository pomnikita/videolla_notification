ActiveRecord::Schema.define(:version => 1) do
  create_table 'users', :force =>true do |t|
    t.string :name
    t.string :email
    t.datetime :last_squawked_at
  end
  create_table 'mail_templates', :force =>true do |t|
    t.string :name
    t.string :title
    t.string :subject
    t.text :body
    t.datetime :last_tweeted_at
  end
end