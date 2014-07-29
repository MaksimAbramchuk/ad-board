require 'rails_helper'

describe UsersController do
  describe 'GET' do
    before(:each) do
      request.env['devise.mapping'] = Devise.mappings[:user]
    end

    describe '#index' do
      for_user :admin do
        it_permits_access_for(:admin) do
          get :index
        end

        it 'loads users' do
          get :index
          expect(assigns(:users)).to eq(User.all)
        end
      end

      for_user :user do
        it_denies_access_for(:user) do
          get :index
        end
      end

      it_denies_access_for(:guest) do
        get :index
      end
    end

    describe '#show' do
      for_user :admin do
        it 'loads the requested variables' do
          get :show, id: user.id

          expect(assigns(:user)).to eq(user)
          expect(assigns(:awaiting)).to eq(user.adverts.awaiting_publication)
          expect(assigns(:declined)).to eq(user.adverts.declined)
          expect(assigns(:published)).to eq(user.adverts.published)
        end
      end

      for_user :admin, :user do
        it_permits_access_for(:admin, :user) do
          get :show, id: user.id
        end
      end

      it_denies_access_for(:guest) do
        get :show, id: Fabricate(:user).id
      end
    end

    describe '#edit' do
      for_user :admin do
        it_permits_access_for(:admin) do
          get :edit, id: user.id
        end
      end

      for_user :user do
        it_denies_access_for(:another_user) do
          another_user = Fabricate(:user)
          get :edit, id: another_user.id
        end

        it_permits_access_for(:user) do
          get :edit, id: user.id
        end
      end

      it_denies_access_for(:guest) do
        get :edit, id: Fabricate(:user).id
      end

      it_loads_requested(:user) do
        get :edit, id: user.id
      end
    end

    describe '#adverts' do
      for_users :admin, :user do
        it_permits_access_for(:admin, :user) do
          get :adverts
        end
      end

      it_denies_access_for(:guest) do
        get :adverts
      end
    end

    describe '#account' do
      for_user :admin do
        it 'renders admin_account template' do
          get :account

          expect(response).to render_template(:admin_account)
        end
      end

      for_user :user do
        it 'renders user_account template' do
          get :account

          expect(response).to render_template(:user_account)
        end
      end

      for_users :admin, :user  do
        it_permits_access_for(:admin, :user) do
          get :account
        end
      end

      it_denies_access_for(:guest) do
        get :account
      end
    end
  end

  describe 'PATCH' do
    describe '#update' do
      for_users :admin, :user  do
        it "updates user's attributes" do
          patch :update, id: user.id, user: { name: 'test' }
          expect(response).to redirect_to(user_path)
          expect(user.reload.name).to eq('test')
        end

        it 'renders :edit when params are invalid' do
          patch :update, id: user.id, user: { name: nil }
          expect(response).to render_template(:edit)
        end
      end

      for_user :user do
        it_denies_access_for(:another_user) do
          another_user = Fabricate(:user)
          patch :update, id: another_user.id, user: { name: 'test' }
        end
      end

      it_loads_requested(:user) do
        patch :update, id: user.id, user: { name: 'test' }
      end

    end
  end
end
