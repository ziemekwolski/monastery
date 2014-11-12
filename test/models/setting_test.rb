# == Schema Information
#
# Table name: settings
#
#  id          :integer          not null, primary key
#  key         :string
#  value       :text
#  created_at  :datetime
#  updated_at  :datetime
#  data_type   :string           default("string")
#  name        :string
#  description :text
#

require 'test_helper'

class SettingTest < ActiveSupport::TestCase
  test "setting not found" do
    assert_raise do
      Setting.get(:nope)
    end
  end
end
