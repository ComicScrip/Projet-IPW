json.extract! assessment, :id, :grade, :user_id, :created_at, :updated_at
json.url assessment_url(assessment, format: :json)
