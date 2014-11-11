# == Schema Information
#
# Table name: users
#
#  id                              :integer          not null, primary key
#  name                            :string           not null
#  email                           :string           not null
#  linkedin                        :string
#  twitter                         :string
#  crypted_password                :string           not null
#  salt                            :string           not null
#  remember_me_token               :string
#  remember_me_token_expires_at    :datetime
#  reset_password_token            :string
#  reset_password_token_expires_at :datetime
#  reset_password_email_sent_at    :datetime
#  upload_id                       :integer
#  github                          :string
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
