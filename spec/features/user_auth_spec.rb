require 'rails_helper'

feature "Users" do

  scenario "There are sign up and sign in links on the home page" do
    visit root_path
    expect(page).to have_content "Sign In"
    expect(page).to have_content "Sign Up"
  end

  scenario "A visitor can register as a new user" do
    visit root_path
    click_on "Sign Up"
    fill_in "First name", with: "Bob"
    fill_in "Last name", with: "Example"
    fill_in "Email", with: "email@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_on "Register"
    expect(page).to have_content "Bob Example"
  end

  scenario "User cannot sign up without a password" do
    visit root_path
    click_on "Sign Up"
    fill_in "First name", with: "Bob"
    fill_in "Last name", with: "Example"
    fill_in "Email", with: "email@example.com"
    fill_in "Password", with: ""
    fill_in "Password confirmation", with: ""
    click_on "Register"
    expect(page).to have_content "Password can't be blank"
  end

  scenario "Registered users can sign in" do
    visit root_path
    click_on "Sign Up"
    fill_in "First name", with: "Bob"
    fill_in "Last name", with: "Example"
    fill_in "Email", with: "email@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_on "Register"
    expect(page).to have_content "Bob Example"
    click_on "Sign Out"
    click_on "Sign In"
    fill_in "Email", with: "email@example.com"
    fill_in "Password", with: "password"
  end

  scenario "A registered user can sign out" do
    visit root_path
    click_on "Sign Up"
    fill_in "First name", with: "Bob"
    fill_in "Last name", with: "Example"
    fill_in "Email", with: "email@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_on "Register"
    expect(page).to have_content "Bob Example"
    click_on "Sign Out"
    expect(page).to have_content "Sign In"
  end

  scenario "A user tries to sign up with a registered email address" do
    visit root_path
    click_on "Sign Up"
    fill_in "First name", with: "Bob"
    fill_in "Last name", with: "Example"
    fill_in "Email", with: "email@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_on "Register"
    expect(page).to have_content "Bob Example"
    click_on "Sign Out"
    click on "Sign Up"
    fill_in "First name", with: "New"
    fill_in "Last name", with: "Test"
    fill_in "Email", with: "email@example.com"
    fill_in "Password", with: "pass"
    fill_in "Password confirmation", with: "pass"
    click_on "Register"
    expect(page).to have_content "That email address is already taken"
  end
end
