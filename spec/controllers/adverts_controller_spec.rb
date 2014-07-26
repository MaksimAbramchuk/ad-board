require 'rails_helper'

describe AdvertsController do
  describe 'GET' do
    let(:advert) { Fabricate(:advert) }

    describe '#edit' do
      it 'edit the requested advert' do
        sign_in(advert.user)

        get :edit, id: advert.id

        expect(assigns(:advert)).to eq(advert) 
      end

      it 'permit access for the admin' do
        admin = Fabricate(:user, role: :admin)
        sign_in(admin)

        get :edit, id: advert.id

        expect(response).to be_successful
      end

      it 'denied access for the guest' do
        get :edit, id: advert.id

        expect(response).not_to be_successful
      end

      it 'denied access for the user(not owner)' do
        user = Fabricate(:user)
        sign_in(user)

        get :edit, id: advert.id

        expect(response).not_to be_successful
      end
    end

    describe '#new' do
      it 'permit access for the user' do
        sign_in(Fabricate(:user))

        get :new

        expect(response).to be_successful
      end

      it 'denied access for unauthorized user' do
        get :new

        expect(response).not_to be_successful
      end
    end

    describe '#change' do
      it 'permit access for the advert owner' do
        user = advert.user
        sign_in(user)

        get :change, id: advert.id

        expect(response).to be_successful
        expect(assigns(:advert)).to eq(advert)
      end

      it 'denied access for the guest' do
        get :change, id: advert.id

        expect(response).not_to be_successful
      end

      it 'denied access for the user(not owner)' do
        user = Fabricate(:user)
        sign_in(user)

        get :change, id: advert.id

        expect(response).not_to be_successful
      end

      it 'permit access for the admin' do
        advert = Fabricate(:advert)
        admin = Fabricate(:user, role: :admin)
        sign_in(admin)

        get :change, id: advert.id

        expect(response).to be_successful
      end

      it 'loads the requested advert' do
        user = advert.user
        sign_in(user)

        get :change, id: advert.id

        expect(assigns(:advert)).to eq(advert)
      end
    end

    describe '#logs' do
      it 'permit access for the owner' do
        user = advert.user
        sign_in(user)

        get :logs, id: advert.id

        expect(response).to be_successful
      end

      it 'denied access for the user(not owner)' do
        user = Fabricate(:user)
        sign_in(user)

        get :logs, id: advert.id

        expect(response).not_to be_successful
      end

      it 'permit access for the admin' do
        admin = Fabricate(:user, role: :admin)
        sign_in(admin)

        get :logs, id: advert.id

        expect(response).to be_successful
      end

      it 'denied access for the guest' do
        get :logs, id: advert.id

        expect(response).not_to be_successful
      end

      it 'loads requested advert' do
        user = advert.user
        sign_in(user)

        get :logs, id: advert.id

        expect(assigns(:advert)).to eq(advert)
      end
    end

    describe '#awaiting_publication' do
      it 'permit access for the admin' do
        admin = Fabricate(:user, role: :admin)
        sign_in(admin)

        get :awaiting_publication

        expect(response).to be_successful
      end

      it 'denied access for the common user' do
        user = Fabricate(:user)
        sign_in(user)

        get :awaiting_publication

        expect(response).not_to be_successful
      end
    end
  end

  describe 'PATCH' do
    let(:advert) { Fabricate(:advert) }
    describe '#update' do
      context 'by owner' do
        before do
          sign_in(advert.user)
        end

        it "updates advert's attributes" do
          patch_update_request
          expect(advert.reload.name).to eq('edited name')
        end
      end

      context 'by admin' do
        before do
          admin = Fabricate(:user, role: :admin)
          sign_in(admin)
        end

        it "updates advert's attributes" do
          patch_update_request
          expect(advert.reload.name).to eq('edited name')
        end
      end

      it 'denied access for quest' do
        sign_in(Fabricate(:user))
        patch_update_request
        expect(response).not_to be_successful
      end

      it 'loads the requested advert' do
        sign_in(Fabricate(:user))
        patch_update_request
        expect(assigns(:advert)).to eq(advert)
      end

      def patch_update_request
        patch :update, id: advert.id, advert: { name: 'edited name' }
      end
    end

    describe '#change_state' do
      context 'by owner' do
        before do
          sign_in(advert.user)
        end
        it 'archives published advert' do
          patch_change_state('archive')
          expect(advert.reload.state).to eq('archived')
        end

        it "can't decline advert" do
          patch_change_state(:decline)
          expect(advert.reload.state).not_to eq('declined')
        end
      end

      context 'by admin' do
        before do
          admin = Fabricate(:user, role: :admin)
          sign_in(admin)
        end

        it 'declines advert' do
          advert = Fabricate(:advert, state: 'awaiting_publication')
          patch :change_state, id: advert.id, advert: { state: :decline }
          expect(advert.reload.state).to eq('declined')
        end

        it "can't decline advert" do
          patch_change_state(:decline)
          expect(advert.reload.state).not_to eq('declined')
        end
      end

      def patch_change_state(state)
        patch :change_state, id: advert.id, advert: { state: state }
      end
    end
  end

  describe 'POST' do
    describe '#create' do
      context 'for admin user' do
        let(:admin) { Fabricate(:user, role: :admin) }

        before do
          sign_in(admin)
        end

        context 'with valid params' do
          before do
            send_post_request_with_valid_params
          end

          it 'creates advert' do
            expect(assigns(:advert)).to be_persisted
          end

          it 'redirects to user adverts' do
            expect(response).to redirect_to(users_adverts_path)
          end

          it 'creates advert on behalf signed in user' do
            expect(assigns(:advert).user).to eq(admin)
          end
        end

        context 'with invalid params' do
          it 'redirects to #new action' do
            post :create, advert: { name: nil }

            expect(response).to render_template(:new)
          end
        end
      end

      it 'denied access for quest' do
        send_post_request_with_valid_params

        expect(response).to redirect_to(new_user_session_path)
      end

      def send_post_request_with_valid_params
        post :create, advert: {
          name: Faker::Lorem.sentence,
          description: Faker::Lorem.sentence,
          price: Faker::Number.number(10),
          user: Fabricate(:user),
          category_id: Fabricate(:category).id }
      end
    end
  end

  describe 'DELETE' do
    let(:advert) { Fabricate(:advert) }
    describe '#destroy' do
      before do
        sign_in(advert.user)
      end
      context 'by owner' do
        it 'deletes the advert' do
          delete_destroy_request

          expect(assigns(:advert)).not_to be_persisted
        end
      end

      context 'by admin' do
        before do
          admin = Fabricate(:user, role: 'admin')
          sign_in(admin)
        end

        it 'deletes the advert' do
          delete_destroy_request

          expect(assigns(:advert)).not_to be_persisted
        end
      end

      context 'by user(not owner)' do
        before do
          sign_in(Fabricate(:user))
        end

        it "doesn't deletes the advert" do
          delete_destroy_request

          expect(assigns(:advert)).to be_persisted
        end
      end

      it 'load the requested advert' do
        delete_destroy_request

        expect(assigns(:advert)).to eq(advert)
      end

      it 'denied access for quest' do
        delete_destroy_request

        expect(response).not_to be_successful
      end

      def delete_destroy_request
        delete :destroy, id: advert.id
      end
    end
  end
end
