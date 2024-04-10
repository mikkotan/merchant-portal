# frozen_string_literal: true

require 'swagger_helper'

describe 'GET /api/v1/pipelines/{id}', type: :request do
  path '/api/v1/pipelines/{id}' do
    get 'Retrieves a pipeline by id' do
      tags 'Pipelines'
      produces 'application/json'
      consumes 'application/json'

      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: :id, in: :path, type: :string, required: true
      parameter name: :merchant_id, in: :query, type: :string

      let(:staff_user) { create(:internal_user) }
      let!(:pipeline) { create(:pipeline) }

      let('access-token') { staff_user.id }
      let(:id) { pipeline.id }
      let(:merchant_id) { nil }

      response '200', 'Pipeline found' do
        schema type: :object, properties: {
          data: {
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
            }, required: %w[id name about founded_in stage categories company_website]
          }
        }

        run_test!
      end

      context 'when user is external' do
        let(:external_user) { create(:external_user) }
        let('access-token') { external_user.id }

        response '200', 'Pipeline found' do
          run_test!
        end

        context 'when merchant_id is present' do
          let(:merchant) { create(:merchant) }
          let(:merchant_id) { merchant.id }

          context 'when merchant belongs to user' do
            let!(:merchant_user) { create(:merchant_user, external_user:, merchant:) }

            response '200', 'Pipeline found' do
              run_test!
            end
          end

          context 'when merchant does not belong to user' do
            response '403', 'Forbidden' do
              schema type: :object, properties: { error: { type: :string } }

              run_test!
            end
          end
        end
      end

      response '404', 'Pipeline not found' do
        schema type: :object, properties: { error: { type: :string } }

        let(:id) { 'some-uuid' }
        run_test!
      end
    end
  end
end
