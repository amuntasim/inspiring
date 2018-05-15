# frozen_string_literal: true

class LoginPage < SitePrism::Page
  set_url "/users/sign_in"

  element :email_field, "input#user_email"
  element :password_field, "input#user_password"
  element :sign_in_button, "input[type='submit']"

  load_validation { [has_email_field?, "email_field did not appear"] }
  load_validation { [has_password_field?, "password_field did not appear"] }
  load_validation { [has_sign_in_button?, "sign_in_button did not appear"] }

  def login(email, password = "Abcd1234")
    email_field.set    email
    password_field.set password
    sign_in_button.click
  end
end
