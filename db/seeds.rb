# frozen_string_literal: true

# Create Users
InternalUser.find_or_create_by!(
  id: '450f9854-ab1f-4c04-94f2-a651fda030dc',
  email: 'internal@user.com'
)

external_user_a = ExternalUser.find_or_create_by!(
  id: 'cd7f33cb-c483-451d-b995-1730b2a580cd',
  email: 'externala@user.com'
)

external_user_b = ExternalUser.find_or_create_by!(
  id: '58894254-b0a7-4550-a42a-f774ceb4512d',
  email: 'externalb@user.com'
)

# Merchants
merchant_a = Merchant.find_or_create_by!(
  id: '10452350-147e-1234-a15b-503ba451f379',
  name: 'United British Merchant'
)

merchant_b = Merchant.find_or_create_by!(
  id: '1bde0977-e3b2-2222-8c7c-fe3a7cbb98bb',
  name: 'Flying Ethihad'
)

# Merchant Users
MerchantUser.find_or_create_by!(external_user: external_user_a, merchant: merchant_a)
MerchantUser.find_or_create_by!(external_user: external_user_b, merchant: merchant_b)

# Pipelines
pipeline_a = Pipeline.find_or_create_by!(
  id: '004acfe5-4334-1234-9498-28add7f4674a',
  name: 'Bank A',
  about: 'Bank A is the 2nd largest OTA platform in China in terms of GMV as of 2019. As the only loyalty program targeting the travel segment in the Alibaba e-commerce economy',
  founded_in: '1 Oct 2016',
  categories: [
      'other'
  ],
  stage: Pipeline.stages[:live],
  company_website: 'https://www.bankA.com/',
)

pipeline_b = Pipeline.find_or_create_by!(
  id: 'cd8469d7-3daf-43dd-9ee5-1966ba53db89',
  name: 'Bank B',
  about: 'Bank B is the 3rd largest OTA platform in China in terms of GMV as of 2019. As the only loyalty program targeting the travel segment in the Alibaba e-commerce economy',
  founded_in: '1 Sep 2016',
  categories: [
      'other'
  ],
  stage: Pipeline.stages[:live],
  company_website: 'https://www.bankB.com/',
)

other_pipelines = [
  {
    id: '004acfe5-4334-5678-9498-28add7f4674a',
    name: 'CC company B',
    about: 'CC company B is a corporate travel and expense management platform looking to launch a premium rewards program.',
    founded_in: '1 Oct 2019',
    categories: [
        'other'
    ],
    stage: Pipeline.stages[:contracting],
    company_website: 'https://www.ccCompanyB.com/',
  }, {
    id: 'ede3a8f9-4fd5-4a44-8d36-4077b3a82211',
    name: 'Bank C',
    about: 'Bank C is the 4th largest OTA platform in China in terms of GMV as of 2019. As the only loyalty program targeting the travel segment in the Alibaba e-commerce economy',
    founded_in: '1 Dec 2016',
    categories: [
        'other'
    ],
    stage: Pipeline.stages[:live],
    company_website: 'https://www.bankC.com/',
  }, {
    id: '829ca84f-9000-43df-a572-7dd13b1a22f8',
    name: 'Imperial Bank',
    about: 'Imperial Bank is a corporate travel and expense management platform looking to launch a premium rewards program.',
    founded_in: '2 Oct 2019',
    categories: [
        'other'
    ],
    stage: Pipeline.stages[:implementation],
    company_website: 'https://www.imperialbank.com/',
  }
]

other_pipelines.each { |pipeline| Pipeline.find_or_create_by!(pipeline) }

# Active Pipelines
ActivePipeline.find_or_create_by!(pipeline: pipeline_a, merchant: merchant_a)
ActivePipeline.find_or_create_by!(pipeline: pipeline_b, merchant: merchant_b)
