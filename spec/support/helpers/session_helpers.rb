module Features
  module SessionHelpers
    def sign_up_with(email, password, confirmation)
      visit root_path
      click_link 'Sign in'
      click_link 'Register'
      fill_in 'Name', with: "Jhon"
      fill_in 'Email', with: email
      fill_in 'Password', with: password
      click_button 'Register'
    end

    def signin(email, password)
      visit root_path
      click_link 'Sign In'
      sleep 3
      #show_page
      first('input#user_email', visible: false).set(email)
      first('input#user_password', visible: false).set(password)
      first('input[value="Login"]', visible: false).click
    end
  end
end
