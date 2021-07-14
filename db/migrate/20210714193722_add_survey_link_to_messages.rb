class AddSurveyLinkToMessages < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :survey_link, :string
  end
end
