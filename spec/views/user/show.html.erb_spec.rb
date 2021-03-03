require 'rails_helper'

RSpec.describe 'users/show', type: :view do
  let(:user) { create(:user, name: 'Zevs') } # залогиненный юзер
  let(:game) { create(:game, id: 15, created_at: Time.parse('2016.10.09, 13:00'), current_level: 10, prize: 1000
  ) }

  context 'user see his own page' do
    before(:each) do
      assign(:user, user) # назначаем юзера
      sign_in user # log in
      assign(:games, [build_stubbed(:game)]) # назначаем игру

      allow(game).to receive(:status).and_return(:in_progress)
      render partial: 'users/game', object: game
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
end
