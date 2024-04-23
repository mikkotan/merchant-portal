# frozen_string_literal: true

require 'swagger_helper'

describe 'POST /api/v1/pipelines/{id}/activate', type: :request do
  path '/api/v1/pipelines/{id}/activate' do
    post 'Activates a pipeline' do
      tags 'Pipelines'
      produces 'application/json'
      consumes 'application/json'

      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: :id, in: :path, type: :string, required: true

      let('access-token') { current_user.id }
      let(:id) { pipeline.id }

      let(:current_user) { create(:internal_user) }
      let(:partner) { create(:partner) }
      let(:merchant) { create(:merchant) }
      let(:pipeline) { create(:pipeline, partner:, merchant:) }

      response '200', 'Pipeline activated' do
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

      response '403', 'Forbidden' do
        schema type: :object, properties: { error: { type: :string } }
        let(:current_user) { create(:external_user) }

        run_test!
      end

      response '404', 'Pipeline not found' do
        schema type: :object, properties: { error: { type: :string } }
        let(:id) { 'some-uuid' }

        run_test!
      end

      response '422', 'Unprocessable entity' do
        schema type: :object, properties: { error: { type: :string } }
        let(:pipeline) { create(:pipeline, partner:, merchant:, status: Pipeline.statuses[:active]) }

        run_test!
      end
    end
  end
end
