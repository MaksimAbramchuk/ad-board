require 'rails_helper'

describe CategoriesController do
  describe 'POST' do
    describe '#create' do
      for_user :admin do
        it 'creates category with valid params' do
          post :create, category: { name: 'test' }
          expect(assigns(:category)).to be_persisted
        end

        it 'redirects to categories_path after creation' do
          post :create, category: { name: 'test' }
          expect(response).to redirect_to(categories_path)
        end

        it 'renders :new when params are invalid' do
          post :create, category: { name: nil }
          expect(response).to render_template(:new)
        end
      end

      for_user :user do
        it 'denies access' do
          post :create, category: { name: nil }
          expect(response).to redirect_to(root_path)
        end
      end
    end
  end

  describe 'PATCH' do
    let(:category) { Fabricate(:category) }

    describe '#update' do
      for_user :admin do
        it "updates categorie's attributes" do
          patch :update, id: category.id, category: { name: 'test_name' }
          expect(category.reload.name).to eq('test_name')
        end

        it 'renders :edit when params are invalid' do
          patch :update, id: category.id, category: { name: nil }
          expect(response).to render_template(:edit)
        end

        for_user :user do
          it 'denies access for user' do
            patch :update, id: category.id, category: { name: 'test_name' }
            expect(response).to redirect_to(root_path)
          end
        end

        it_loads_requested(:category) do
          patch :update, id: category.id, category: { name: 'test_name' }
        end
      end

      describe 'DELETE' do
        describe '#destroy' do
          let(:category) { Fabricate(:category) }

          for_user :admin do
            it 'destroys category' do
              delete :destroy, id: category.id
              expect(assigns(:category)).not_to be_persisted
            end
          end

          for_user :user do
            it 'denies access for user' do
              delete :destroy, id: category.id
              expect(assigns(:category)).to be_persisted
            end
          end

          it_loads_requested(:category) do
            delete :destroy, id: category.id
          end
        end
      end
    end
  end
end
