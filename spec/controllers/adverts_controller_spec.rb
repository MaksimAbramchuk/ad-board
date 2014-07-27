require 'rails_helper'

describe AdvertsController do
  describe 'GET' do
    let(:advert) { Fabricate(:advert) }

    describe '#edit' do
      it_loads_requested_advert do
        get_edit_request
      end

      for_user :admin do
        it_permits_access_for(:admin) do
          get_edit_request
        end
      end

      it_denies_access_for(:guest) do
        get_edit_request
      end

      for_user :user do
        it_denies_access_for(:user) do
          get_edit_request
        end
      end

      def get_edit_request
        get :edit, id: advert.id
      end
    end

    describe '#new' do
      for_users :user, :admin do
        it_permits_access_for(:user, :admin) do
          get_new_request
        end
      end

      it_denies_access_for(:guest) do
        get_new_request
      end

      def get_new_request
        get :new
      end
    end

    describe '#change' do
      for_user :owner do
        it_permits_access_for(:owner) do
          get_change_request
        end
      end

      it_denies_access_for(:guest) do
        get_change_request
      end

      for_user :user do
        it_denies_access_for(:user) do
          get_change_request
        end
      end

      for_user :admin do
        it_permits_access_for(:admin) do
          get_change_request
        end
      end

      it_loads_requested_advert do
        get_change_request
      end

      def get_change_request
        get :change, id: advert.id
      end
    end

    describe '#logs' do
      for_user(:owner) do
        it_permits_access_for(:owner) do
          get_logs_request
        end
      end

      for_user :user do
        it_denies_access_for(:user) do
          get_logs_request
        end
      end

      for_user :admin do
        it_permits_access_for(:admin) do
          get_logs_request
        end
      end

      it_denies_access_for(:guest) do
        get_logs_request
      end

      it_loads_requested_advert do
        get_logs_request
      end

      def get_logs_request
        get :logs, id: advert.id
      end
    end

    describe '#awaiting_publication' do
      for_user :admin do
        it_permits_access_for(:admin) do
          get_awaiting_publication_request
        end
      end

      for_user :user do
        it_denies_access_for(:user) do
          get_awaiting_publication_request
        end
      end

      it_denies_access_for(:quest) do
        get_awaiting_publication_request
      end

      def get_awaiting_publication_request
        get :awaiting_publication
      end
    end
  end

  describe 'PATCH' do
    let(:advert) { Fabricate(:advert) }

    describe '#update' do
      for_users :owner, :admin do
        it "updates advert's attributes" do
          patch_update_request
          expect(advert.reload.name).to eq('edited name')
        end
      end

      it_denies_access_for(:guest) do
        patch_update_request
      end

      it_loads_requested_advert do
        patch_update_request
      end

      it "render's new if can't edit the advert" do
        advert = Fabricate(:advert)
        sign_in(advert.user)
        patch :update, id: advert.id, advert: { name: nil }
        expect(response).to render_template(:edit)
      end

      def patch_update_request
        patch :update, id: advert.id, advert: { name: 'edited name' }
      end
    end

    describe '#change_state' do
      for_user :owner do
        it 'archives published advert' do
          patch_change_state(:archive)

          expect(advert.reload.state).to eq('archived')
        end
      end

      for_users :owner, :admin do
        it "can't decline advert" do
          patch_change_state(:decline)

          expect(advert.reload.state).not_to eq('declined')
        end
      end

      for_user :admin do
        it 'declines advert' do
          advert = Fabricate(:advert, state: 'awaiting_publication')

          patch :change_state, id: advert.id, advert: { state: :decline }

          expect(advert.reload.state).to eq('declined')
        end
      end

      def patch_change_state(state)
        patch :change_state, id: advert.id, advert: { state: state }
      end
    end
  end

  describe 'POST' do
    describe '#create' do
      for_user :admin do
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
            expect(assigns(:advert).user).to eq(user)
          end
        end

        context 'with invalid params' do
          it 'renders :new template' do
            post :create, advert: { name: nil }

            expect(response).to render_template(:new)
          end
        end
      end

      it_denies_access_for(:guest) do
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
      for_user :owner do
        it 'deletes the advert' do
          delete_destroy_request

          expect(assigns(:advert)).not_to be_persisted
        end
      end

      for_user :admin do
        it 'deletes the advert' do
          delete_destroy_request

          expect(assigns(:advert)).not_to be_persisted
        end
      end

      for_user :user do
        it "doesn't deletes the advert" do
          delete_destroy_request

          expect(assigns(:advert)).to be_persisted
        end
      end

      it_loads_requested_advert do
        delete_destroy_request
      end

      it_denies_access_for(:guest) do
        delete_destroy_request
      end

      def delete_destroy_request
        delete :destroy, id: advert.id
      end
    end
  end
end
