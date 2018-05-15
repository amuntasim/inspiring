# frozen_string_literal: true

class ProfileEditPage < BasePage
  set_url "/edit"

  element :first_name_field, "input#user_first_name"
  element :last_name_field, "input#user_last_name"
  element :email_field, "input#user_email"
  element :password_field, "input#user_password"
  element :password_confirmation_field, "input#user_password_confirmation"
  element :current_password_field, "input#user_current_password"
  element :update_button, "button[type='submit']"

  load_validation { [has_first_name_field?, "first_name_field did not appear"] }
  load_validation { [has_last_name_field?, "last_name_field did not appear"] }
  load_validation { [has_email_field?, "email_field did not appear"] }
  load_validation { [has_password_field?, "password_field did not appear"] }
  load_validation { [has_password_confirmation_field?, "password_confirmation_field did not appear"] }
  load_validation { [has_current_password_field?, "current_password_field did not appear"] }
  load_validation { [has_update_button?, "update_button did not appear"] }

  def update_name
    first_name_field.set       "Covfefe"
    last_name_field.set        "Covfefey"
    current_password_field.set "Abcd1234"
    update_button.click
  end
end
