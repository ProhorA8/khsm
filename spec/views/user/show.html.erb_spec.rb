require 'rails_helper'

RSpec.describe 'users/show', type: :view do
  let(:user) { create(:user, name: 'Zevs') } # залогиненный юзер
  let(:another_user) { create(:user, name: 'Prometheus') } # не залогиненный юзер

  context 'user see his own page' do
    before(:each) do
      assign(:user, user) # назначаем юзера
      sign_in user # log in
      assign(:games, [build_stubbed(:game)]) # назначаем игру

      render
    end

    it 'user see his name' do
      expect(rendered).to match('Zevs')
    end

    it 'renders change password' do
      expect(rendered).to match('Сменить имя и пароль')
    end

    it 'renders game fragments' do
      expect(rendered).to match('в процессе')
    end
  end

  context 'first user look at second user' do
    before(:each) do
      assign(:user, another_user)
      assign(:games, [build_stubbed(:game)])

      render
    end

    it 'renders second user name' do
      expect(rendered).to match('Prometheus')
    end

    it 'renders game fragments' do
      expect(rendered).to match('в процессе')
    end

    it 'renders change password' do
      expect(rendered).not_to match('Сменить имя и пароль')
    end
  end
end
