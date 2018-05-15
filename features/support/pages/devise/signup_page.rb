# frozen_string_literal: true

class SignupPage < BasePage
  set_url "/register"

  element :first_name_field, "input#user_first_name"
  element :last_name_field, "input#user_last_name"
  element :email_field, "input#user_email"
  element :password_field, "input#user_password"
  element :password_confirmation_field, "input#user_password_confirmation"
  element :signup_button, "button[type='submit']"

  load_validation { [has_first_name_field?, "first_name_field did not appear"] }
  load_validation { [has_last_name_field?, "last_name_field did not appear"] }
  load_validation { [has_email_field?, "email_field did not appear"] }
  load_validation { [has_password_field?, "password_field did not appear"] }
  load_validation { [has_password_confirmation_field?, "password_confirmation_field did not appear"] }
  load_validation { [has_signup_button?, "sign_in_button did not appear"] }

  def signup
    first_name_field.set            "John"
    last_name_field.set             "Doe"
    email_field.set                 "test@gmail.com"
    password_field.set              "Abcd1234"
    password_confirmation_field.set "Abcd1234"
    signup_button.click
  end
end
