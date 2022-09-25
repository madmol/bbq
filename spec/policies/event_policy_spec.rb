require 'rails_helper'

describe EventPolicy do
  subject { described_class.new(user, event) }

  context 'being a visitor WITHOUT cookies' do
    let(:user) { UserContext.new(nil, {}) }
    let(:user_author) { User.create(email: 'test2@test.test', name: 'test2', password: '123456', confirmed_at: Time.now) }

    context 'event WITHOUT pin' do
      let(:event) { user_author.events.create }
      it { is_expected.to permit_actions(%i[show]) }
      it { is_expected.to forbid_actions(%i[new create destroy edit update]) }
    end

    context 'event WITH pin' do
      let(:event) { user_author.events.create(pincode: 123) }
      it { is_expected.to forbid_actions(%i[show new create destroy edit update]) }
    end
  end

  context 'being a visitor WITH cookies' do
    let(:user) { UserContext.new(nil,  { "events_#{event.id}_pincode" => '123' }) }
    let(:user_author) { User.create(email: 'test2@test.test', name: 'test2', password: '123456', confirmed_at: Time.now) }

    context 'event WITHOUT pin' do
      let(:event) { user_author.events.create }
      it { is_expected.to permit_actions(%i[show]) }
      it { is_expected.to forbid_actions(%i[new create destroy edit update]) }
    end

    context 'event WITH pin' do
      let(:event) { user_author.events.create(pincode: 123) }
      it { is_expected.to permit_actions(%i[show]) }
      it { is_expected.to forbid_actions(%i[new create destroy edit update]) }
    end
  end


  context 'being an user WITHOUT cookies' do
    let(:user_context) { User.create(email: 'test@test.test', name: 'test', password: '123456', confirmed_at: Time.now) }
    let(:user) { UserContext.new(user_context, {}) }
    let(:user_author) { User.create(email: 'test2@test.test', name: 'test2', password: '123456', confirmed_at: Time.now) }

    context 'event WITHOUT pin' do
      let(:event) { user_author.events.create }
      it { is_expected.to permit_actions(%i[show new create]) }
      it { is_expected.to forbid_actions(%i[destroy edit update]) }
    end

    context 'event WITH pin' do
      let(:event) { user_author.events.create(pincode: 123) }
      it { is_expected.to permit_actions(%i[new create]) }
      it { is_expected.to forbid_actions(%i[show destroy edit update]) }
    end
  end


  context 'being an user WITH cookies' do
    let(:user_context) { User.create(email: 'test@test.test', name: 'test', password: '123456', confirmed_at: Time.now) }
    let(:user) { UserContext.new(user_context, { "events_#{event.id}_pincode" => '123' }) }
    let(:user_author) { User.create(email: 'test2@test.test', name: 'test2', password: '123456', confirmed_at: Time.now) }

    context 'event WITHOUT pin' do
      let(:event) { user_author.events.create }
      it { is_expected.to permit_actions(%i[show new create]) }
      it { is_expected.to forbid_actions(%i[destroy edit update]) }
    end

    context 'event WITH pin' do
      let(:event) { user_author.events.create(pincode: 123) }
      it { is_expected.to permit_actions(%i[show new create]) }
      it { is_expected.to forbid_actions(%i[destroy edit update]) }
    end
  end

  context 'being an event owner user WIHOUT cookies' do
    let(:user_author) { User.create(email: 'test@test.test', name: 'test', password: '123456', confirmed_at: Time.now) }
    let(:user) { UserContext.new(user_author, {}) }

    context 'event WITHOUT pin' do
      let(:event) { user_author.events.create }
      it { is_expected.to permit_actions(%i[show new create destroy edit update]) }
    end

    context 'event WITH pin' do
      let(:event) { user_author.events.create(pincode: 123) }
      it { is_expected.to permit_actions(%i[show new create destroy edit update]) }
    end
  end

  context 'being an event owner user WITH cookies' do
    let(:user_author) { User.create(email: 'test@test.test', name: 'test', password: '123456', confirmed_at: Time.now) }
    let(:user) { UserContext.new(user_author, { "events_#{event.id}_pincode" => '123' }) }

    context 'event WITHOUT pin' do
      let(:event) { user_author.events.create }
      it { is_expected.to permit_actions(%i[show new create destroy edit update]) }
    end

    context 'event WITH pin' do
      let(:event) { user_author.events.create(pincode: 123) }
      it { is_expected.to permit_actions(%i[show new create destroy edit update]) }
    end
  end
end
