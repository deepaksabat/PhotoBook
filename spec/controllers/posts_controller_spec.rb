require 'rails_helper'

describe PostsController do
  let(:valid_attributes) { attributes_for(:post) }
  let(:user) { create(:user) }
  let!(:user_post) { create(:post, user: user) }

  context 'user is signed in' do
    before do
      allow(controller).to receive(:user_signed_in?).and_return(true)
      allow(controller).to receive(:current_user).and_return(user)
      allow(controller).to receive(:authenticate_user!).and_return(user)

      allow_any_instance_of(Paperclip::Attachment).to receive(:save).and_return(true)
    end

    describe 'GET index' do
      it 'exposes all posts' do
        get :index
        expect(assigns(:posts)).to eq([user_post])
      end
    end

    describe 'GET new' do
      it 'exposes a new post' do
        get :new
        expect(assigns(:post)).to be_a_new(Post)
      end
    end

    describe 'POST create' do
      describe 'with valid params' do
        it 'creates a new Post' do
          expect {
            post :create, post: valid_attributes
          }.to change(Post, :count).by(1)
        end

        it 'exposes a newly created post as #post' do
          post :create, post: valid_attributes
          expect(assigns(:post)).to be_an_instance_of(Post)
          expect(assigns(:post)).to be_persisted
        end

        it 'redirects to the front page' do
          post :create, post: valid_attributes
          expect(response).to redirect_to(root_path)
        end
      end

      describe 'with invalid params' do
        before do
          allow_any_instance_of(Post).to receive(:save).and_return(false)
          post :create, post: valid_attributes
        end

        it 'exposes a newly created but unsaved post' do
          expect(assigns(:post)).to be_a_new(Post)
        end

        it "re-renders the 'new' template" do
          expect(response).to render_template('new')
        end
      end
    end

    describe 'GET show' do
      it 'exposes the requested post' do
        get :show, id: user_post.to_param
        expect(assigns(:post)).to eq(user_post)
      end
    end

    describe 'GET edit' do
      it 'exposes the requested post' do
        get :edit, id: user_post.to_param
        expect(assigns(:post)).to eq(user_post)
      end
    end

    describe 'PUT update' do
      let(:book) { create(:book) }

      describe 'with valid params' do
        it 'updates the requested post' do
          # attributes = valid_attributes.stringify_keys.transform_values { |x| x.to_s }
          allow_any_instance_of(Post).to receive(:update).with(valid_attributes)
          put :update, id: user_post.to_param, post: valid_attributes
        end

        it 'exposes the requested post' do
          put :update, id: user_post.to_param, post: valid_attributes
          expect(assigns(:post)).to eq(user_post)
        end

        it 'redirects to the book' do
          put :update, id: user_post.to_param, post: valid_attributes
          expect(response).to redirect_to(user_post)
        end
      end

      describe 'with invalid params' do
        before do
          allow_any_instance_of(Post).to receive(:update).and_return(false)
          put :update, id: user_post.to_param, post: valid_attributes
        end

        it 'exposes the post' do
          expect(assigns(:post)).to eq(user_post)
        end

        it "re-renders the 'edit' template" do
          expect(response).to render_template('edit')
        end
      end
    end

    describe 'DELETE destroy' do
      it 'destroys the requested post' do
        expect {
          delete :destroy, id: user_post.to_param
        }.to change(Post, :count).by(-1)
      end

      it 'redirects to the front page' do
        delete :destroy, id: user_post.to_param
        expect(response).to redirect_to(root_path)
      end

      context 'delete other user\'s post' do
        it 'redirects to the front page' do
          user2 = create(:user, email: Faker::Internet.email, name: Faker::Internet.name)
          other_post = create(:post, user: user2)
          delete :destroy, id: other_post.to_param
          expect(response).to redirect_to(root_path)
          expect(flash[:alert]).to eq("That post doesn't belong to you!")
        end
      end
    end
  end
end
