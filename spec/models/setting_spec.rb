require "rails_helper"

RSpec.describe Setting, :type => :model do

  def load
    Settings::Init.load
  end

  describe "#get" do
    before(:each) do
      load
      Setting.create!({
        key: :i18n_activated,
        name: "Translations?",
        data_type: "boolean",
        description: "Translation active",
        value: "f"
      })

    end

    it "a boolean" do
      expect(Setting.get(:i18n_activated)).to eq(false)
    end
    it "a string" do
      setting = Setting.find_by(key: :title)
      setting.value = "Website Title"
      setting.save!

      expect(Setting.get(:title)).to eq("Website Title")
    end
  end
end