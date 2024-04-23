# frozen_string_literal: true

require 'swagger_helper'

describe 'GET /api/v1/partners', type: :request do
  path '/api/v1/partners' do
    get 'Retrieves all partners by user_id and merchant_id' do
      tags 'Partners'
      produces 'application/json'
      consumes 'application/json'

      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: :user_id, in: :query, type: :string, required: true
      parameter name: :merchant_id, in: :query, type: :string, required: true
      parameter name: :active, in: :query, type: :boolean, required: false

      let(:current_user) { create(:internal_user) }
      let!(:merchant_user) { create(:merchant_user) }
      let!(:partner) { create(:partner) }
      let!(:contracting_partner) { create(:partner, stage: Partner.stages[:contracting]) }

      let('access-token') { current_user.id }
      let(:user_id) { merchant_user.user_id }
      let(:merchant_id) { merchant_user.merchant_id }

      response '200', 'Partners found' do
        schema type: :object, properties: {
          data: {
            type: :array,
            items: {
              type: :object,
              properties: {
                id: { type: :string, format: :uuid },
                name: { type: :string },
                about: { type: :string },
                founded_in: { type: :string },
                active: { type: :boolean },
                stage: { type: :string },
                categories: {
                  type: :array,
                  items: { type: :string }
                },
                company_website: { type: :string }
              }, required: %w[id name about founded_in active stage categories company_website]
            }
          }
        }

        run_test! do |response|
          expect(response.parsed_body['data'].size).to eq(2)
        end
      end

      context 'when current_user is merchant_user' do
        let(:current_user) { merchant_user.external_user }

        response '200', 'Partners found' do
          run_test! do |response|
            expect(response.parsed_body['data'].size).to eq(1)
          end
        end
      end

      context 'when active filter is present' do
        let!(:pipeline) { create(:pipeline, merchant: merchant_user.merchant, status: Pipeline.statuses[:active]) }

        response '200', 'Active partners found' do
          let(:active) { true }

          run_test! do |response|
            expect(response.parsed_body['data'].size).to eq(1)
          end
        end
      end

      response '401', 'Unauthorized' do
        schema type: :object, properties: { error: { type: :string } }
        let('access-token') { 'invalid' }

        run_test!
      end

      response '403', 'Forbidden' do
        schema type: :object, properties: { error: { type: :string } }
        let(:user_id) { 'some-uuid' }
        let('access-token') { merchant_user.user_id }

        run_test!
      end

      context 'when merchant_id does not belong to user' do
        let(:merchant_id) { 'some-uuid' }

        response '403', 'Forbidden' do
          schema type: :object, properties: { error: { type: :string } }
          let('access-token') { merchant_user.user_id }

          run_test!
        end
      end
    end
  end
end
