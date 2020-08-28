module SignInSupport
  def sign_in(company)
    visit new_company_session_path
    fill_in 'company[email]', with: company.email
    fill_in 'company[password]', with: company.password
    find('input[name="commit"]').click
    expect(current_path).to eq root_path
  end

  def creator_sign_in(creator)
    visit new_creator_session_path
    fill_in 'creator[email]', with: creator.email
    fill_in 'creator[password]', with: creator.password
    find('input[name="commit"]').click
    expect(current_path).to eq root_path
  end
end