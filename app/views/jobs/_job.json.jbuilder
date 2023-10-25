json.extract! job, :id, :title, :description, :job_category, :location, :job_author, :job_company, :salary, :created_at, :updated_at
json.url job_url(job, format: :json)
