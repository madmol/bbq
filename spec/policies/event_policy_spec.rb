require 'rails_helper'

describe EventPolicy do
  subject { described_class.new(user, event) }

  context 'being a visitor' do
    let(:user_not_author) { User.create(email: 'test2@test.test', name: 'user_not_author', password: '123456', confirmed_at: Time.now) }
    let(:event) { user_not_author.events.create }
    let(:user) { nil }

    it { is_expected.to permit_actions(%i[show]) }
    it { is_expected.to forbid_actions(%i[new create destroy edit update]) }
  end

  context 'being sign in' do
      let(:user) { User.create(email: 'test@test.test', name: 'test', password: '123456', confirmed_at: Time.now) }

    context 'being an event owner' do
      let(:event) { user.events.create }

      it { is_expected.to permit_actions(%i[show new create destroy edit update]) }
    end

    context 'not being an event owner' do
      let(:user_not_author) { User.create(email: 'test2@test.test', name: 'user_not_author', password: '123456', confirmed_at: Time.now) }
      let(:event) { user_not_author.events.create }

      it { is_expected.to permit_actions(%i[show create new]) }
      it { is_expected.to forbid_actions(%i[destroy edit update]) }
    end
  end
end
