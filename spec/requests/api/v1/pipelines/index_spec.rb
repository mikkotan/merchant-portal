# frozen_string_literal: true

require 'swagger_helper'

describe 'GET /api/v1/pipelines', type: :request do
  path '/api/v1/pipelines' do
    get 'Retrieves all pipelines by user_id and merchant_id' do
      tags 'Pipelines'
      produces 'application/json'
      consumes 'application/json'

      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: :user_id, in: :query, type: :string, required: true
      parameter name: :merchant_id, in: :query, type: :string, required: true
      parameter name: :active, in: :query, type: :boolean, required: false

      let(:staff_user) { create(:internal_user) }
      let!(:merchant_user) { create(:merchant_user) }
      let!(:pipeline) { create(:pipeline) }

      let('access-token') { staff_user.id }
      let(:user_id) { merchant_user.user_id }
      let(:merchant_id) { merchant_user.merchant_id }

      response '200', 'Pipelines found' do
        run_test!
      end

      context 'when active filter is present' do
        let!(:active_pipeline) { create(:active_pipeline, merchant: merchant_user.merchant) }

        response '200', 'Active pipelines found' do
          let(:active) { true }

          run_test!
        end
      end
    end
  end
end
