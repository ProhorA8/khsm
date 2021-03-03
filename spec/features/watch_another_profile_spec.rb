require 'rails_helper'

Rspec.feature 'watch another user profile', type: :feature do
  let(:first_user) { create :user }
  let(:second_user) { create :user }
  let(:first_game) { create :game, prize: 1000, user: second_user }
  let(:second_game) { create :game, user: second_user }

  let!(:games) { [first_game, second_game] }

  scenario 'success' do

    visit '/'

    expect(page).to have_text(second_user.name)

    click_link second_user.name

    expect(page).to have_current_path "/users/#{second_user.id}"
    expect(page).to have_text second_user.name
    expect(page).not_to have_text('Сменить имя и пароль')
    expect(page).to have_content('Выигрыш')
    expect(page).to have_content(0)
    expect(page).to have_content('1 000 ₽')
    expect(page).to have_content('Подсказки')
    expect(page).to have_content(I18n.l(first_game.created_at, format: :short))
    expect(page).to have_content(I18n.l(second_game.created_at, format: :short))
  end
end
