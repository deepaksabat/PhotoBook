require 'rails_helper'

describe CommentsController do
  let(:valid_attributes) { attributes_for(:comment) }
  let(:user) { create(:user) }
  let(:user_post) { create(:post, user: user) }

  context 'user is signed in' do
    before do
      allow(controller).to receive(:user_signed_in?).and_return(true)
      allow(controller).to receive(:current_user).and_return(user)
      allow(controller).to receive(:authenticate_user!).and_return(user)
    end

    describe 'POST create' do
      describe 'with valid params' do
        it 'creates a new Comment' do
          expect {
            post :create, post_id: user_post.to_param, comment: valid_attributes
          }.to change(Comment, :count).by(1)
        end

        it 'exposes a newly created comment as #comment' do
          post :create, post_id: user_post.to_param, comment: valid_attributes
          expect(assigns(:comment)).to be_an_instance_of(Comment)
          expect(assigns(:comment)).to be_persisted
        end

        it 'redirects to the front page' do
          post :create, post_id: user_post.to_param, comment: valid_attributes
          expect(response).to redirect_to(root_path)
        end
      end

      describe 'with invalid params' do
        before do
          allow_any_instance_of(Comment).to receive(:save).and_return(false)
          post :create, post_id: user_post.to_param, comment: valid_attributes
        end

        it 'exposes a newly created but unsaved comment' do
          expect(assigns(:comment)).to be_a_new(Comment)
        end

        it 'redirects to the front page with error message' do
          expect(response).to redirect_to(root_path)
          expect(flash[:alert]).to eq('Check the comment form, something went horribly wrong.')
        end
      end
    end

    describe 'DELETE destroy' do
      let!(:comment) { create(:comment, user: user, post: user_post) }

      it 'destroys the requested comment' do
        expect {
          delete :destroy, id: comment.to_param, post_id: user_post.to_param
        }.to change(Comment, :count).by(-1)
      end

      it 'redirects to the front page' do
        delete :destroy, id: comment.to_param, post_id: user_post.to_param
        expect(response).to redirect_to(root_path)
      end

      context 'delete other user\'s comment' do
        it 'redirects to the front page with error message' do
          user2 = create(:user, email: Faker::Internet.email, name: Faker::Internet.name)
          post2 = create(:post, user: user2)
          comment2 = create(:comment, user: user2, post: post2)
          delete :destroy, id: comment2.to_param, post_id: post2.to_param
          expect(response).to redirect_to(root_path)
          expect(flash[:alert]).to eq("That comment doesn't belong to you !")
        end
      end
    end
  end
end
