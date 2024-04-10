# frozen_string_literal: true

require 'swagger_helper'

describe 'GET /api/v1/merchants', type: :request do
  path '/api/v1/merchants' do
    get 'Retrieves all merchants by user_id' do
      tags 'Merchants'
      produces 'application/json'
      consumes 'application/json'

      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: :user_id, in: :query, type: :string, required: true

      let(:staff_user) { create(:internal_user) }
      let!(:merchant_user) { create(:merchant_user) }
      let(:user_id) { merchant_user.user_id }

      response '200', 'Merchants found' do
        schema type: :object,
               properties: {
                 data: {
                   type: :array,
                   items: {
                     type: :object,
                     properties: {
                       id: { type: :string, format: :uuid },
                       name: { type: :string }
                     },
                     required: %w[id name]
                   }
                 }
               }

        let('access-token') { staff_user.id }

        run_test! do |response|
          expect(response.parsed_body['data'].size).to eq(1)
        end
      end

      response '401', 'Unauthorized' do
        schema type: :object, properties: { error: { type: :string } }
        let('access-token') { 'invalid' }

        run_test!
      end

      response '403', 'Forbidden' do
        schema type: :object, properties: { error: { type: :string } }
        let(:user_id) { SecureRandom.uuid }
        let('access-token') { merchant_user.user_id }

        run_test!
      end
    end
  end
end
