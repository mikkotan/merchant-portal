# frozen_string_literal: true

require 'swagger_helper'

describe 'POST /api/v1/pipelines', type: :request do
  path '/api/v1/pipelines' do
    post 'Creates a pipeline' do
      tags 'Pipelines'
      produces 'application/json'
      consumes 'application/json'

      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: :body_params, in: :body, schema: {
        type: :object,
        properties: {
          merchant_id: { type: :string, format: :uuid },
          financial_institution_id: { type: :string, format: :uuid }
        }, required: %w[merchant_id financial_institution_id]
      }

      let('access-token') { current_user.id }
      let(:body_params) { { merchant_id: merchant.id, financial_institution_id: partner.id } }

      let(:current_user) { create(:internal_user) }
      let(:merchant) { create(:merchant) }
      let(:partner) { create(:partner) }

      response '201', 'Pipeline created' do
        schema type: :object, properties: {
          data: {
            type: :object,
            properties: {
              id: { type: :string, format: :uuid },
              merchant_id: { type: :string, format: :uuid },
              financial_institution_id: { type: :string, format: :uuid },
              partner: {
                type: :object,
                properties: {
                  id: { type: :string, format: :uuid },
                  name: { type: :string },
                  about: { type: :string },
                  founded_in: { type: :string },
                  stage: { type: :string },
                  categories: {
                    type: :array,
                    items: { type: :string }
                  },
                  company_website: { type: :string }
                }, required: %w[id name about founded_in stage categories company_website]
              }
            }, required: %w[id merchant_id financial_institution_id partner]
          }
        }

        run_test!
      end

      context 'when current_user is merchant_user' do
        let(:merchant_user) { create(:merchant_user) }
        let(:merchant) { merchant_user.merchant }
        let(:current_user) { merchant_user.external_user }

        response '201', 'Pipeline created' do
          run_test!
        end

        context 'when merchant does not belong to current_user' do
          let(:current_user) { create(:external_user) }

          response '403', 'Forbidden' do
            schema type: :object, properties: { error: { type: :string } }

            run_test!
          end
        end
      end

      context 'invalid params' do
        let(:body_params) { { merchant_id: nil, financial_institution_id: nil } }

        response '400', 'Invalid parameters' do
          schema type: :object, properties: { error: { type: :string } }

          run_test!
        end
      end
    end
  end
end